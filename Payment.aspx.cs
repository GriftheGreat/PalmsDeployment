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
        bool success = false;

        if(true/*CC*/)
        {
            success = true;
        }
        else if(true/*idC*/)
        {
            success = true;
        }
        if (success)
        {
            Session.Remove("order");
            Session.Remove("orderItemNumber");
            Response.Redirect(Request.Url.GetLeftPart(UriPartial.Authority) + "/ThankYou.aspx", true);
        }
    }

    private void choseCreditCard()
    {
        //validate?
        string paymentResultString = Data_Provider.Credit_Card_Interface.Send_Credit_Card_Info(this._.Text, "05/17", "123", "Jacob Harder", "0.00");
        //save payment data here
        if(paymentResultString.Contains("Pass:"))
        {
            //send order data here
        }
    }

    private void choseIDCard()
    {

    }
}