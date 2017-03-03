using System;
using System.Data;
using System.Web.UI.WebControls;
using System.Net;
using System.Collections.Specialized;
using Oracle.DataAccess.Client;

public partial class Cart : System.Web.UI.Page
{
    Order myOrder;

    protected void Page_Init(object sender, EventArgs e)
    {
        // dynamically load static checkbox lists here
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["order"] != null)
        {
            myOrder = (Order)Session["order"];

            this.rptItems.DataSource = myOrder.Order_Elements;
        }
    }

    protected void btnHI_click(object sender, EventArgs e)
    {
        this.gdvstuff.Visible = !this.gdvstuff.Visible;
    }
}