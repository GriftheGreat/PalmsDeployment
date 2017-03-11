using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Payment : System.Web.UI.Page
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
        if (Session["order"] == null)
        {
            Response.Redirect(Request.Url.GetLeftPart(UriPartial.Authority) + "/Cart.aspx", true);
        }
        else
        {
            this.litSummaryNumber.Text = Session["orderItemNumber"].ToString();

            if (MyOrder.Order_Elements != null)
            {
                this.rptItems.DataSource = MyOrder.Order_Elements;
                this.rptItems.DataBind();
            }
        }
    }

    protected void lnkSubmit_Click(object sender, EventArgs e)
    {
        //send payment data here
        //save payment data here
        //if good
        {
            //send order data here
            //if good
            {
                Session.Remove("order");
                Session.Remove("orderItemNumber");
                Response.Redirect(Request.Url.GetLeftPart(UriPartial.Authority) + "/ThankYou.aspx", true);
            }
        }
    }
}