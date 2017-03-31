<%@ Page Language="C#"
         Title="Payment"
         AutoEventWireup="true"
         CodeFile="Payment.aspx.cs"
         Inherits="Payment"
         MasterPageFile="~/Master Pages/Default.Master" %>

<%@ MasterType VirtualPath="~/Master Pages/Default.Master" %>

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="Styles">
    <%-- cart styles --%>
    <style type="text/css">
        .card-front-name
        {
            position: absolute;
            top: 0px;
            width: 100%;
            text-align: center;
            background-color: none;
            background-color: rgba(255, 255, 255, .5);
            display: block;
        }

        .card-front-price
        {
            position: absolute;
            bottom: 0px;
            width: 100%;
            text-align: center;
            background-color: none;
            background-color: rgba(255, 255, 255, .5);
            display: block;
        }

        .payment-item
        {
            margin-left: -100px;
            position: inherit;
            display: inline-block;
        }

        .cannot-deliver
        {
            border: 5px solid rgb(200, 25, 25);
        }
    </style>
    <%-- order summary --%>
    <style type="text/css">
        .order-summary
        {
            display: inline-block;
            width: 600px;
            height: 300px;
            overflow: hidden;
        }

        .order-summary-info
        {
            border: 2px solid rgb(128, 128, 128);
            border-radius: 20px;
            display: block;
            height: 40px;
        }

        .order-summary-items
        {
            padding-left: 100px;
            width: 1000px;
            height: 200px;
            text-align: left;
        }
    </style>
    <%-- payment options --%>
    <style type="text/css">
        .payment-options
        {
            display: inline-block;
            width: 600px;
        }

        .payment-options-button-container
        {
            width: 100%;
        }

        .payment-options-button
        {
            border: 2px solid rgb(128, 128, 128);
            padding: 10px;
            width: 50%;
            text-align: center;
            cursor: pointer;
        }

        .payment-options-button:hover
        {
            background-color: rgb(200, 200, 200);
        }

        .current-tab
        {
            border-width: 2px 2px 0px 2px;
        }

        .payment-options-section
        {
            border-width: 0px 2px 2px 2px;
            border-style: solid;
            border-color: rgb(128, 128, 128);
            padding: 20px;
            width: 100%;
            text-align: left;
        }

        .payment-options-section table
        {
            width: 100%;
        }

        .payment-submit-button
        {
            margin-top: 20px;
            padding: 10px 30px 10px 30px;
            border: 2px solid rgb(36, 156, 202);
            border-radius: 10px;
            color: rgb(36, 156, 202);
            display: inline-block;
        }

        .payment-submit-button:hover
        {
            border: 2px solid rgb(25, 77, 157);
            color: rgb(25, 77, 157);
            text-decoration: none;
        }

        .Error
        {
            color: rgb(200, 25, 25);
        }

        .bad-data
        {
            border: 2px solid rgb(200, 25, 25);
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="Scripts">
    <script type="text/javascript">
        $(document).ready(function () {
            switchToTab("1");

            $('#<%= this.lnkSubmit.ClientID %>').on('click', function () {
                var isValid = true;

                var txtLocationPlaceCheck  = /^[0-9]{3,4}$/;

                var txtFirstName           = $('#<%= this.txtFirstName.ClientID %>');
                var txtLastName            = $('#<%= this.txtLastName.ClientID %>');
                var ddlDeliveryType        = $('#<%= this.ddlDeliveryType.ClientID %>');
                var ddlLocations           = $('#<%= this.ddlLocations.ClientID %>');
                var locationPlaceContainer = $('#<%= this.locationPlaceContainer.ClientID %>');
                var txtLocationPlace       = $('#<%= this.txtLocationPlace.ClientID %>');
                var lblError               = $('#<%= this.lblError.ClientID %>');
                
                if (txtFirstName.val() != "") {
                    txtFirstName.removeClass("bad-data");
                }
                else {
                    txtFirstName.addClass("bad-data");
                    isValid = false;
                }

                if (txtLastName.val() != "") {
                    txtLastName.removeClass("bad-data");
                }
                else {
                    txtLastName.addClass("bad-data");
                    isValid = false;
                }

                if (!(lblError.html().includes("cannot be delivered")) && ddlDeliveryType.val() != "") {
                    ddlDeliveryType.removeClass("bad-data");
                }
                else {
                    ddlDeliveryType.addClass("bad-data");
                    isValid = false;
                }

                if (ddlLocations.val() != "") {
                    ddlLocations.removeClass("bad-data");
                }
                else {
                    ddlLocations.addClass("bad-data");
                    isValid = false;
                }

                if (locationPlaceContainer.is(':visible'))
                {
                    if (txtLocationPlaceCheck.test(txtLocationPlace.val())) {
                        txtLocationPlace.removeClass("bad-data");
                    }
                    else {
                        txtLocationPlace.addClass("bad-data");
                        isValid = false;
                    }
                }

                if ($('#<%= this.hidPaymentType.ClientID %>').val() == "1")//credit card
                {
                    var CCNumberCheck            = /^[0-9]{16,16}$/;
                    var expirationMonthDateCheck = /^(0[1-9]|1[0-2])\/[0-9]{2,2}$/;
                    var cardSecurityCodeCheck    = /^[0-9]{3,4}$/;
                    var ownerNameCheck           = /^[^\\\/?^!@#$%&*+=<>;:)(}{\[\]]+$/;

                    var txtCreditCardNumber       = $('#<%= this.txtCreditCardNumber.ClientID %>');
                    var txtCreditCardExpDate      = $('#<%= this.txtCreditCardExpDate.ClientID %>');
                    var txtCreditCardSecurityCode = $('#<%= this.txtCreditCardSecurityCode.ClientID %>');
                    var txtCreditCardOwnerName    = $('#<%= this.txtCreditCardOwnerName.ClientID %>');

                    if (CCNumberCheck.test(txtCreditCardNumber.val())) {
                        txtCreditCardNumber.removeClass("bad-data");
                    }
                    else {
                        txtCreditCardNumber.addClass("bad-data");
                        isValid = false;
                    }

                    if (expirationMonthDateCheck.test(txtCreditCardExpDate.val())) {
                        txtCreditCardExpDate.removeClass("bad-data");
                    }
                    else {
                        txtCreditCardExpDate.addClass("bad-data");
                        isValid = false;
                    }

                    if (cardSecurityCodeCheck.test(txtCreditCardSecurityCode.val())) {
                        txtCreditCardSecurityCode.removeClass("bad-data");
                    }
                    else {
                        txtCreditCardSecurityCode.addClass("bad-data");
                        isValid = false;
                    }

                    if (ownerNameCheck.test(txtCreditCardOwnerName.val())) {
                        txtCreditCardOwnerName.removeClass("bad-data");
                    }
                    else {
                        txtCreditCardOwnerName.addClass("bad-data");
                        isValid = false;
                    }
                }
                else if ($('#<%= this.hidPaymentType.ClientID %>').val() == "2")//ID card
                {
                    var IDNumberCheck = /^[0-9]{4,6}$/;
                    var PasswordCheck = /^[0-9]{8,8}$/;

                    var txtIDNumber = $('#<%= this.txtIDNumber.ClientID %>');
                    var txtPassword = $('#<%= this.txtPassword.ClientID %>');

                    if (IDNumberCheck.test(txtIDNumber.val())) {
                        txtIDNumber.removeClass("bad-data");
                    }
                    else {
                        txtIDNumber.addClass("bad-data");
                        isValid = false;
                    }

                    if (PasswordCheck.test(txtPassword.val())) {
                        txtPassword.removeClass("bad-data");
                    }
                    else {
                        txtPassword.addClass("bad-data");
                        isValid = false;
                    }
                }
                return isValid;// false stops postback :D
            });
        });

        function switchToTab(tabToOpen)
        {
            $('td[Tab][Tab!="' + tabToOpen + '"]').each(function (index) {
                $(this).removeClass("current-tab");
            });

            $('td[Tab="' + tabToOpen + '"]').first().addClass("current-tab");


            $('div[tabSection]:visible').each(function (index) {
                $( this ).hide();
            });

            $('div[tabSection="' + tabToOpen + '"]').first().show();

            $('#<%= this.hidPaymentType.ClientID %>').val(tabToOpen);
        }

        function pickLocation(ddl)
        {
            var ddl = $(ddl);

            if (ddl.val() != null && ddl.val() != '')
            {
                ddl.children().first().hide();
            }

            if (ddl.val() == 'DR' || ddl.val() == 'WA')
            {
                $('#<%= this.locationPlaceContainer.ClientID %>').show();
                $('#<%= this.txtLocationPlace.ClientID %>').val('');


                if (ddl.val() == 'DR')
                {
                    $('#<%= this.lbllocationPlace.ClientID %>').html('Room Number');
                }
                else
                {
                    $('#<%= this.lbllocationPlace.ClientID %>').html('Apartment Number');
                }
            }
            else
            {
                $('#<%= this.locationPlaceContainer.ClientID %>').hide();
            }
        }
    </script>
</asp:Content>

<asp:Content ID="Content" runat="server" ContentPlaceHolderID="Content">
    <div class="container">
        <div class="row" style="text-align: center;">
            <div class="order-summary">
                <div class="order-summary-info">
                    Items: <asp:Literal ID="litSummaryNumber" runat="server" />
                </div>
                <div class="order-summary-items">
                    <asp:Repeater ID="rptItems" runat="server">
                        <ItemTemplate>
                            <div class="front payment-item <%# (MyOrder.Type == "Delivery" && Eval("Deliverable") != null && Eval("Deliverable").ToString() != "Y") ? "cannot-deliver" : "" %>">
                                    <%# (Eval("ImagePath") != null && Eval("ImagePath").ToString() != "") ? "<img class=\"card-image\" src=\"" + URL.root(Request) + "Includes/images/Menu Items/" + Eval("ImagePath").ToString() +"\">" : "" %>
                                <asp:Label     ID="litFoodName"    runat="server" Text='<%# Eval("Name") %>' CssClass="card-front-name" />
                                <asp:Label     ID="lblfrontprice"  runat="server" Text='<%# Eval("Price").ToString().Insert(Eval("Price").ToString().IndexOf("-") + 1,"$") %>' CssClass="card-front-price" />
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
                <div class="order-summary-info">
                    Total Price: <asp:Literal ID="litPrice" runat="server" />
                </div>
            </div>

            <div>
                <asp:Label   ID="lblError"       runat="server" Text="" CssClass="Error" />
            </div>
            <asp:HiddenField ID="hidPaymentType" runat="server" Value="1" />

            <div class="payment-options">
                <div class="payment-options-section" style="border-width: 2px 2px 2px 2px;">
                    <table>
                        <tr>
                            <td>Customer First Name:</td>
                            <td><asp:TextBox      ID="txtFirstName"    runat="server" /></td>
                        </tr>
                        <tr>
                            <td>Customer last Name:</td>
                            <td><asp:TextBox      ID="txtLastName"     runat="server" /></td>
                        </tr>
                        <tr>
                            <td>Order Type:</td>
                            <td>
                                <asp:DropDownList ID="ddlDeliveryType" runat="server" AutoPostBack="true" OnTextChanged="ddlDeliveryType_Click" >
                                    <asp:ListItem Text=""         Value="" Selected="True" />
                                    <asp:ListItem Text="Pick Up"  Value="PickUp" />
                                    <asp:ListItem Text="Delivery" Value="Delivery" />
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr id="deliveryLocationContainer" runat="server">
                            <td>Delivery Location:</td>
                            <td>
                                <asp:DropDownList ID="ddlLocations"    runat="server" onchange="pickLocation(this);" >
                                    <asp:ListItem Text=""                   Value="" />
                                    <asp:ListItem Text="Palm's Grille"      Value="Palm's Grille" Enabled="false" />
                                    <asp:ListItem Text="Campus House Lobby" Value="Campus House Lobby" />
                                    <asp:ListItem Text="Sports Center"      Value="Sports Center" />
                                    <asp:ListItem Text="Dorm Room"          Value="DR" />
                                    <asp:ListItem Text="Waveland Apartment" Value="WA" />
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr id="locationPlaceContainer" runat="server">
                            <td><span id="lbllocationPlace" runat="server"></span></td>
                            <td><asp:TextBox ID="txtLocationPlace"     runat="server" Width="3em" /></td>
                        </tr>
                    </table>
                </div>
            </div>

            <div class="payment-options">
                <table class="payment-options-button-container">
                    <tr>
                        <td class="payment-options-button" Tab="1" onclick="switchToTab('1');">Credit Card</td>
                        <td class="payment-options-button" Tab="2" onclick="switchToTab('2');">PCC ID Card</td>
                    </tr>
                </table>
                <div class="payment-options-section" tabSection="1">
                    <table>
                        <tr>
                            <td>Credit Card Number:</td>
                            <td><asp:TextBox ID="txtCreditCardNumber" runat="server" /></td>
                        </tr>
                        <tr>
                            <td>Credit Card Security Code:</td>
                            <td><asp:TextBox ID="txtCreditCardSecurityCode" runat="server" /></td>
                        </tr>
                        <tr>
                            <td>Credit Card Exp. Date:</td>
                            <td><asp:TextBox ID="txtCreditCardExpDate" runat="server" /></td>
                        </tr>
                        <tr>
                            <td>Credit Card Owner Name:</td>
                            <td><asp:TextBox ID="txtCreditCardOwnerName" runat="server" /></td>
                        </tr>
                    </table>
                </div>
                <div class="payment-options-section" tabSection="2">
                    <table>
                        <tr>
                            <td>ID Number:</td>
                            <td><asp:TextBox ID="txtIDNumber" runat="server" /></td>
                        </tr>
                        <tr>
                            <td>Password:</td>
                            <td><asp:TextBox ID="txtPassword" runat="server" TextMode="Password" /></td>
                        </tr>
                    </table>
                </div>

                <asp:LinkButton ID="lnkSubmit" runat="server" Text="Submit" OnClick="lnkSubmit_Click" CssClass="payment-submit-button" />
            </div>
        </div>
    </div>
</asp:Content>