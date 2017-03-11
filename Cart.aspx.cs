using System;
using System.Data;
using System.Web.UI.WebControls;
using System.Net;
using System.Collections.Specialized;
using Oracle.DataAccess.Client;

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

    protected void lnk1_Click(object sender, EventArgs e)
    {
        Response.Redirect(Request.Url.GetLeftPart(UriPartial.Authority) + "/Payment.aspx", true);
    }
}