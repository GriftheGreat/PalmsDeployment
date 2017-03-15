using System;
using System.Web.UI.WebControls;

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

    protected void Page_Init(object sender, EventArgs e)
    {
        // dynamically load static checkbox lists here
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (MyOrder != null && MyOrder.Order_Elements != null)
        {
            this.rptItems.DataSource = MyOrder.Order_Elements;
            this.rptItems.DataBind();
        }
    }

    protected void Page_PreRender(object sender, EventArgs e)
    {
        int numItems;

        if (!Int32.TryParse(Session["orderItemNumber"].ToString(), out numItems))
        {
            numItems = 0;
        }

        this.plhItemsAreInOrder.Visible = numItems != 0;
        this.plhNoItemsInOrder.Visible = numItems == 0;
    }

    protected void rptItems_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        Repeater rpt = ((Repeater)e.Item.FindControl("rptDetails"));
        rpt.DataSource = ((Order_Element)e.Item.DataItem).Details;
        rpt.DataBind();
    }

    protected void lnkGoPay_Click(object sender, EventArgs e)
    {
        Response.Redirect(Request.Url.GetLeftPart(UriPartial.Authority) + "/Payment.aspx", true);
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
}