using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using System.Linq;

public partial class Cart : System.Web.UI.Page
{
    #region Properties
    public Order MyOrder
    {
        get
        {
            return Session["order"] != null ? (Order)Session["order"] : null;
        }
        set
        {
            Session["order"] = value;
            Session["orderItemNumber"] = value.Order_Elements != null ? value.Order_Elements.Count.ToString() : "0";
        }
    }
    #endregion

    protected void Page_Load(object sender, EventArgs e)
    {
        if (MyOrder != null && MyOrder.Order_Elements != null)
        {
            if(Page.IsPostBack)
            {
                Order tempOrder = MyOrder;
                foreach (RepeaterItem item in this.rptItems.Items)
                {
                    foreach (RepeaterItem detailitem in ((Repeater)item.FindControl("rptDetails")).Items)
                    {
                        tempOrder.Order_Elements[item.ItemIndex].Details[detailitem.ItemIndex].Chosen = ((CheckBox)detailitem.FindControl("chbAdded")).Checked;
                    }
                }
                MyOrder = tempOrder;
            }
            this.rptItems.DataSource = MyOrder.Order_Elements;
            this.rptItems.DataBind();
        }
    }

    protected void Page_PreRender(object sender, EventArgs e)
    {
        int numItems = 0;

        if (Session["orderItemNumber"] != null)
        {
            numItems = Convert.ToInt32(Session["orderItemNumber"].ToString());
        }

        this.plhItemsAreInOrder.Visible = numItems != 0;
        this.plhNoItemsInOrder.Visible = numItems == 0;

        if (MyOrder != null)
        {
            string type     = MyOrder.Type;
            string location = MyOrder.Location;

            this.ddlDeliveryType.SelectedValue     = type;
            this.ddlDeliveryType.Items[0].Enabled  = string.IsNullOrEmpty(type);
            this.deliveryLocationContainer.Visible = !string.IsNullOrEmpty(type);

            this.ddlLocations.Items[0].Enabled = string.IsNullOrEmpty(location);
            this.ddlLocations.Items[1].Enabled = false;
            this.locationPlaceContainer.Style.Add("display", "none");
            this.ddlLocations.Enabled          = true;
            this.txtLocationPlace.Text         = "";

            if (location != null)
            {
                if (location == "Palm's Grille")
                {
                    this.ddlLocations.SelectedValue = location;
                    this.ddlLocations.SelectedItem.Enabled = true;
                    this.ddlLocations.Enabled = false;
                }
                else if (location == "Sports Center" || location == "Campus House Lobby")
                {
                    this.ddlLocations.SelectedValue = location;
                }
                else if (location.Length > 2 && (location.Substring(0, 2) == "WA" || location.Substring(0, 2) == "DR"))
                {
                    this.ddlLocations.SelectedValue = location.Substring(0, 2);
                    this.txtLocationPlace.Text = location.Substring(3);
                    this.locationPlaceContainer.Style.Add("display", "");

                    if (location.Substring(0, 2) == "DR")
                    {
                        this.lbllocationPlace.InnerHtml = "Room Number";
                    }
                    else
                    {
                        this.lbllocationPlace.InnerHtml = "Apartment Number";
                    }
                }
            }
            else
            {
                this.ddlLocations.SelectedValue = "";
            }

            if (MyOrder.Order_Elements != null)
            {
                string cost = Math.Round(MyOrder.CalculateCost(), 2).ToString();
                this.litPrice.Text = cost.Insert(cost.IndexOf("-") + 1, "$");
            }
        }
        this.lblError.Text = "";
        this.lnkGoPay.Enabled = checkFoodDeliverability();
    }

    protected void rptItems_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        Repeater rpt = ((Repeater)e.Item.FindControl("rptDetails"));
        rpt.DataSource = ((Order_Element)e.Item.DataItem).Details;
        rpt.DataBind();
    }

    protected void rptDetails_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if(((List<Detail>)((Repeater)sender).DataSource).Count(detail => !string.IsNullOrEmpty(detail.GroupName) && detail.GroupName == ((Detail)e.Item.DataItem).GroupName) > 1)
        {
            RadioButton r = new RadioButton();
            r.ID = "Added";
            r.Text = ((Detail)e.Item.DataItem).Description;
            r.Checked = ((Detail)e.Item.DataItem).Chosen;
            r.GroupName = ((Detail)e.Item.DataItem).GroupName;
            e.Item.Controls.AddAt(0, r);
        }
        else
        {
            CheckBox c = new CheckBox();
            c.ID = "Added";
            c.Text = ((Detail)e.Item.DataItem).Description;
            c.Checked = ((Detail)e.Item.DataItem).Chosen;
            e.Item.Controls.AddAt(0, c);
        }
    }

    protected void lnkGoPay_Click(object sender, EventArgs e)
    {
        if (MyOrder != null)
        {
            Order tempOrder    = MyOrder;
            tempOrder.Type     = this.ddlDeliveryType.SelectedValue;
            tempOrder.Location = (this.ddlLocations.SelectedValue == "Palm's Grille" ||
                                  this.ddlLocations.SelectedValue == "Sports Center" ||
                                  this.ddlLocations.SelectedValue == "Campus House Lobby" ? this.ddlLocations.SelectedValue :
                                                                                            this.ddlLocations.SelectedValue + " " + this.txtLocationPlace.Text);
            MyOrder = tempOrder;
        }
        Response.Redirect(URL.root(Request) + "Payment.aspx", true);
    }

    protected void lnkRemoveItem_Click(object sender, EventArgs e)
    {
        Order temp = MyOrder;
        if (temp != null && temp.Order_Elements != null)
        {
            temp.Order_Elements.RemoveAt(((RepeaterItem)((LinkButton)sender).NamingContainer).ItemIndex);
            this.rptItems.DataSource = temp.Order_Elements;
            this.rptItems.DataBind();
            MyOrder = temp;
        }
    }

    protected void ddlDeliveryType_Click(object sender, EventArgs e)
    {
        if (MyOrder != null)
        {
            Order tempOrder    = MyOrder;
            tempOrder.Type     = this.ddlDeliveryType.SelectedValue;
            tempOrder.Location = (this.ddlDeliveryType.SelectedValue == "PickUp" ? "Palm's Grille" : "");
            tempOrder.TimeSlot = (this.ddlDeliveryType.SelectedValue == "PickUp" ? "ASAP" : "");

            MyOrder = tempOrder;
            this.rptItems.DataBind();
        }
    }

    #region Private Methods
    /// <summary>
    /// Checks if all foods match order type and adds message to error display
    /// </summary>
    /// <returns>True if all foods match order type.</returns>
    private bool checkFoodDeliverability()
    {
        bool allFoodsMatchType = false;
        if (MyOrder != null && MyOrder.Order_Elements != null)
        {
            allFoodsMatchType = true;
            foreach (Order_Element food in MyOrder.Order_Elements)
            {
                if (MyOrder.Type == "Delivery" && food.Deliverable != "Y")
                {
                    allFoodsMatchType = false;
                }
            }
            if (!allFoodsMatchType)
            {
                this.lblError.Text += (this.lblError.Text.Length > 0 ? "<br />" : "") + "One or more foods cannot be delivered. Please remove them or choose Pick-Up.";
            }
        }
        return allFoodsMatchType;
    }
    #endregion
}