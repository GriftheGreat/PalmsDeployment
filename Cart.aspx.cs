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
        int numItems = 0;

        if (MyOrder != null && MyOrder.Order_Elements != null)
        {
            this.rptItems.DataSource = MyOrder.Order_Elements;
            this.rptItems.DataBind();
        }

        if (Session["orderItemNumber"] == null || string.IsNullOrEmpty(Session["orderItemNumber"].ToString()) || !Int32.TryParse(Session["orderItemNumber"].ToString(), out numItems))
        {
            //MyOrder = null!!!!!!!!!
            Session["orderItemNumber"] = MyOrder.Order_Elements != null ? MyOrder.Order_Elements.Count.ToString() : "0";
        }

        this.plhItemsAreInOrder.Visible = numItems != 0;
        this.plhNoItemsInOrder.Visible  = numItems == 0;
    }

    protected void lnkGoPay_Click(object sender, EventArgs e)
    {
        Response.Redirect(Request.Url.GetLeftPart(UriPartial.Authority) + "/Payment.aspx", true);
    }

    protected void lnkRemoveItem_Click(object sender, EventArgs e)
    {
        Order temp = MyOrder;
        temp.Order_Elements.RemoveAt(((RepeaterItem)((LinkButton)sender).NamingContainer).ItemIndex);
        this.rptItems.DataSource = temp.Order_Elements;
        this.rptItems.DataBind();
        MyOrder = temp;
    }
}