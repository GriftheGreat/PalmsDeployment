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
            /*http://localhost:56863/Includes/images/Menu%20Items//Breakfast/Breakfast_SECCroissant.jpg */
            position: absolute;
            top: 0px;
            width: 100%;
            text-align: center;
            background-color: none;
            background-color: rgba(255, 255, 255, .5);
            display: inline;
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
            position: relative;
            margin-right: 50px;
            display: inline-block;
            float: left;
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

        .payment-options-tab-section
        {
            border-width: 0px 2px 2px 2px;
            border-style: solid;
            border-color: rgb(128, 128, 128);
            padding: 20px;
            width: 100%;
            text-align: left;
        }

        .payment-options-tab-section table
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
    </style>
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="Scripts">
    <script type="text/javascript">
        $(document).ready(function () {
            switchToTab("1");
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
                            <div class="front payment-item">
<%# (Eval("ImagePath") != null && Eval("ImagePath").ToString() != "") ? "                                    <img class=\"card-image\" src=\"" + Request.Url.GetLeftPart(UriPartial.Authority) + "/Includes/images/Menu Items/" + Eval("ImagePath").ToString() +"\">" : "" %>
                                <asp:Label     ID="litFoodName"    runat="server" Text='<%# Eval("Name") %>' CssClass="card-front-name" />
                                <asp:Label     ID="lblfrontprice"  runat="server" Text='<%# Eval("Price") %>' CssClass="card-front-price" />
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
                <div class="order-summary-info">
                    Price: $$$<asp:Literal ID="litPrice" runat="server" />
                </div>
            </div>
            <div class="payment-options">
                <table class="payment-options-button-container">
                    <tr>
                        <td class="payment-options-button" Tab="1" onclick="switchToTab('1');">Credit Card</td>
                        <td class="payment-options-button" Tab="2" onclick="switchToTab('2');">PCC ID Card</td>
                    </tr>
                </table>
                <div class="payment-options-tab-section" tabSection="1">
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
                <div class="payment-options-tab-section" tabSection="2">
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