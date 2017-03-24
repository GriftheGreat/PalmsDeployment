using System;

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
        if (MyOrder == null)
        {
            Response.Redirect(URL.root(Request) + "Cart.aspx", true);
        }
        else
        {
            this.litSummaryNumber.Text = Session["orderItemNumber"].ToString();

            if (MyOrder.Order_Elements != null)
            {
                string cost = MyOrder.CalculateCost().ToString();
                this.litPrice.Text = cost.Insert(cost.IndexOf("-") + 1, "$");

                this.rptItems.DataSource = MyOrder.Order_Elements;
                this.rptItems.DataBind();
            }
        }
    }

    protected void lnkSubmit_Click(object sender, EventArgs e)
    {
        bool success = false;

        if(this.hidPaymentType.Value == "1") // Credit Card
        {
            //validate?
            string paymentResultString = Data_Provider.Credit_Card_Interface.Send_Credit_Card_Info(this.txtCreditCardNumber.Text, this.txtCreditCardExpDate.Text, this.txtCreditCardSecurityCode.Text, this.txtCreditCardOwnerName.Text, this.litPrice.Text, Request);
            string saveResultString    = Data_Provider.Transact_Interface.Save_Credit_Card_Info("1234"/*not possible... Use customer name?  MyOrder.ID.ToString()*/, paymentResultString, paymentResultString.Contains("Pass:") ? "Y" : "N", Request);

            success = paymentResultString.Contains("Pass:") && saveResultString.Contains("Pass:");
        }
        else if(this.hidPaymentType.Value == "2") // PCC ID Card
        {
            //validate?
            string paymentResultString = Data_Provider.Transact_Interface.SendSave_ID_Card_Info("1234"/*not possible... Use customer name?  MyOrder.ID.ToString()*/, this.txtIDNumber.Text, this.txtPassword.Text, Request);

            success = paymentResultString.Contains("Pass:");
        }
        else
        {
            //neither of the tabs are chosen...?
        }

        if (success)
        {
            if (Data_Provider.Transact_Interface.Send_Order_Info(MyOrder, Request))
            {
                Session.Remove("order");
                Session.Remove("orderItemNumber");
                Response.Redirect(URL.root(Request) + "ThankYou.aspx", true);
            }
            else
            {
                //order was not sent correctly...?
            }
        }
    }
}