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

    #region Variables
    public string tabToReopen = "1"; // "1" -> Credit Card , "2" -> PCC ID Card
    #endregion

    protected void Page_Load(object sender, EventArgs e)
    {
        this.Form.DefaultButton = this.lnkSubmit.UniqueID;
        if (MyOrder == null)
        {
            Response.Redirect(URL.root(Request) + "Cart.aspx", true);
        }
        this.lblError.Text = "";
        checkFoodDeliverability(); // put here to be checked before a button click function clears lblError (and re-checks)
    }

    protected void Page_PreRender(object sender, EventArgs e)
    {
        if (MyOrder != null)
        {
            string type = MyOrder.Type;
            string location = MyOrder.Location;

            this.litSummaryNumber.Text            = Session["orderItemNumber"].ToString();
            if (string.IsNullOrEmpty(this.txtFirstName.Text)) // do not want the txtboxes clearing on post back
            {
                this.txtFirstName.Text = MyOrder.CustomerFirstName;
            }
            if (string.IsNullOrEmpty(this.txtLastName.Text)) // do not want the txtboxes clearing on post back
            {
                this.txtLastName.Text = MyOrder.CustomerLastName;
            }

            this.ddlDeliveryType.SelectedValue     = type;
            this.ddlDeliveryType.Items[0].Enabled  = string.IsNullOrEmpty(type);
            this.deliveryLocationContainer.Visible = !string.IsNullOrEmpty(type);

            this.ddlLocations.Items[0].Enabled = string.IsNullOrEmpty(location);
            this.ddlLocations.Items[1].Enabled = false;
            this.locationPlaceContainer.Style.Add("display", "none");
            this.ddlLocations.Enabled = true;
            this.txtLocationPlace.Text = "";

            this.ddlTimes.Enabled = true;
            this.ddlTimes.DataSource = Data_Provider.Transact_Interface.Get_Times("", Request);
            this.ddlTimes.DataBind();
            if (this.ddlTimes.Items.FindByValue(MyOrder.TimeSlot) != null)
            {
                this.ddlTimes.SelectedValue = MyOrder.TimeSlot;
            }

            if (location != null)
            {
                if (location == "Palm's Grille")
                {
                    this.ddlLocations.SelectedValue = location;
                    this.ddlLocations.SelectedItem.Enabled = true;
                    this.ddlLocations.Enabled = false;
                    //this.ddlTimes.Enabled = false;
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
                this.litPrice.Text = Data_Provider.correctPrices(cost);

                this.rptItems.DataSource = MyOrder.Order_Elements;
                this.rptItems.DataBind();
            }
        }
    }

    protected void lnkSubmit_Click(object sender, EventArgs e)
    {
        Response.Write("start lnkSubmit_Click");
        bool success = false;
        this.lblError.Text = "";
        string location = this.ddlLocations.SelectedValue;
        Order tempOrder = MyOrder;

        #region gather order payment info
        tempOrder.CustomerFirstName = this.txtFirstName.Text;
        tempOrder.CustomerLastName  = this.txtLastName.Text;
        tempOrder.Type              = this.ddlDeliveryType.SelectedValue;
        tempOrder.TimeSlot          = this.ddlTimes.SelectedValue;
        tempOrder.Location          = (this.ddlLocations.SelectedValue == "Palm's Grille" ||
                                       this.ddlLocations.SelectedValue == "Sports Center" ||
                                       this.ddlLocations.SelectedValue == "Campus House Lobby" ? this.ddlLocations.SelectedValue :
                                                                                                 this.ddlLocations.SelectedValue + " " + this.txtLocationPlace.Text);
        MyOrder = tempOrder; // saving the delivery type is important on this page
        #endregion

        tabToReopen = this.hidPaymentType.Value; // "1" -> Credit Card , "2" -> PCC ID Card

        #region payment
        if (this.hidPaymentType.Value == "1") // Credit Card
        {
            //validate?
            #region Send_Credit_Card_Info
            string paymentResultString = Data_Provider.Credit_Card_Interface.Send_Credit_Card_Info(this.txtCreditCardNumber.Text,
                                                                                                   this.txtCreditCardExpDate.Text,
                                                                                                   this.txtCreditCardSecurityCode.Text,
                                                                                                   this.txtCreditCardOwnerName.Text,
                                                                                                   this.litPrice.Text.Replace("$", ""),
                                                                                                   Request);
            #endregion
            #region Save_Credit_Card_Info
            string saveResultString = Data_Provider.Transact_Interface.Save_Credit_Card_Info(this.txtFirstName.Text + " " + this.txtLastName.Text,
                                                                                             tempOrder.Time.ToString("yyyyMMdd HH:mm:ss"),
                                                                                             paymentResultString,
                                                                                             paymentResultString.Contains("Pass:") ? "Y" : "N",
                                                                                             Request);
            #endregion

            success = paymentResultString.Contains("Pass") && saveResultString.Contains("Pass");

            #region error messages
            if (paymentResultString.Contains("Fail"))
            {
                this.lblError.Text += (this.lblError.Text.Length > 0 ? "<br />" : "") + getFailure(paymentResultString);
            }

            if (saveResultString.Contains("Fail"))
            {
                this.lblError.Text += (this.lblError.Text.Length > 0 ? "<br />" : "") + getFailure(saveResultString);
            }
            #endregion
        }
        else if (this.hidPaymentType.Value == "2") // PCC ID Card
        {
            //validate?
            #region SendSave_ID_Card_Info
            string paymentResultString = Data_Provider.Transact_Interface.SendSave_ID_Card_Info(this.txtFirstName.Text + " " + this.txtLastName.Text,
                                                                                                tempOrder.Time.ToString("yyyyMMdd HH:mm:ss"),
                                                                                                this.txtIDNumber.Text,
                                                                                                this.txtPassword.Text,
                                                                                                this.litPrice.Text.Replace("$", ""),
                                                                                                Request);
            #endregion

            success = paymentResultString.Contains("Pass");

            #region error message
            if (paymentResultString.Contains("Fail"))
            {
                this.lblError.Text += (this.lblError.Text.Length > 0 ? "<br />" : "") + getFailure(paymentResultString);
            }
            #endregion error message
        }
        else
        {
            this.lblError.Text += (this.lblError.Text.Length > 0 ? "<br />" : "") + "Please choose a payment method.";
        }
        #endregion

        #region check food deliverability, order type, and order delivery location
        if (!checkFoodDeliverability() || string.IsNullOrEmpty(tempOrder.Type) || string.IsNullOrEmpty(tempOrder.Location))
        {
            success = false;
        }
        #endregion

        #region send order or refund
        if (success)
        {
            string orderResultString = Data_Provider.Transact_Interface.Send_Order_Info(tempOrder, Request);
            if (orderResultString.Contains("Pass"))
            {
                Session.Remove("order");
                Session.Remove("orderItemNumber");

                //Pass:{"order_id" : "26", "order_number" : "1", "ASAP time" : "20:30-20:45"} Pass Pass
                orderResultString = orderResultString.Remove(orderResultString.LastIndexOf("}")).Replace("Pass:{", "").Replace(": ", "#").Replace(" ", "").Replace("\"", "");
                //order_id#26,order_number#1,ASAPtime#20:30-20:45

                Session["orderNumber"] = orderResultString.Split("#,".ToCharArray())[3];
                Session["ASAPTime"]    = orderResultString.Split("#,".ToCharArray())[5];
                Response.Redirect(URL.root(Request) + "ThankYou.aspx", true);
            }
            else
            {
                this.lblError.Text += (this.lblError.Text.Length > 0 ? "<br />" : "") + getFailure(orderResultString);

                #region refund
                if (this.hidPaymentType.Value == "1") // Credit Card
                {
                    string paymentResultString = Data_Provider.Credit_Card_Interface.Send_Credit_Card_Info(this.txtCreditCardNumber.Text,
                                                                                                           this.txtCreditCardExpDate.Text,
                                                                                                           this.txtCreditCardSecurityCode.Text,
                                                                                                           this.txtCreditCardOwnerName.Text,
                                                                                                           (-(Convert.ToSingle(this.litPrice.Text.Replace("$", "")))).ToString(), // refund = negate
                                                                                                           Request);
                    string saveResultString = Data_Provider.Transact_Interface.Save_Credit_Card_Info(this.txtFirstName.Text + " " + this.txtLastName.Text,
                                                                                                     tempOrder.Time.ToString("yyyyMMdd HH:mm:ss"),
                                                                                                     paymentResultString,
                                                                                                     paymentResultString.Contains("Pass:") ? "Y" : "N",
                                                                                                     Request);
                }
                else if (this.hidPaymentType.Value == "2") // PCC ID Card
                {
                    string paymentResultString = Data_Provider.Transact_Interface.SendSave_ID_Card_Info(this.txtFirstName.Text + " " + this.txtLastName.Text,
                                                                                                        tempOrder.Time.ToString("yyyyMMdd HH:mm:ss"),
                                                                                                        this.txtIDNumber.Text,
                                                                                                        this.txtPassword.Text,
                                                                                                        (-(Convert.ToSingle(this.litPrice.Text.Replace("$", "")))).ToString(), // refund = negate
                                                                                                        Request);
                }
                #endregion
            }
        }
        #endregion
    }

    protected void ddlDeliveryType_Click(object sender, EventArgs e)
    {
        if (MyOrder != null)
        {
            Order tempOrder = MyOrder;
            tempOrder.Type = this.ddlDeliveryType.SelectedValue;
            tempOrder.CustomerFirstName = this.txtFirstName.Text;
            tempOrder.CustomerLastName = this.txtLastName.Text;
            tempOrder.Location = (this.ddlDeliveryType.SelectedValue == "PickUp" ? "Palm's Grille" : "");
            tempOrder.TimeSlot = ""; //(this.ddlDeliveryType.SelectedValue == "PickUp" ? "ASAP" : "");
            MyOrder = tempOrder;

            this.lblError.Text = "";
            checkFoodDeliverability(); // button click function happens after Page_Load check

            tabToReopen = this.hidPaymentType.Value; // "1" -> Credit Card , "2" -> PCC ID Card
        }
    }

    #region Private Methods
    /// <summary>
    /// Parses a failure message for its error message.
    /// </summary>
    /// <param name="text">A string with an error message between a ':' and a '.'</param>
    /// <returns>Error message as a string.</returns>
    private string getFailure(string text)
    {
        return text.Substring(text.IndexOf(":") + 1, text.IndexOf(".") - text.IndexOf(":"));
    }

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
                this.lblError.Text += (this.lblError.Text.Length > 0 ? "<br />" : "") + "One or more items cannot be delivered. Please remove them or choose Pick-Up.";
            }
        }
        return allFoodsMatchType;
    }
    #endregion
}