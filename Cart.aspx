<%@ Page Language="C#"
         Title="Cart"
         AutoEventWireup="true"
         CodeFile="Cart.aspx.cs"
         Inherits="Cart"
         MasterPageFile="~/Master Pages/Default.Master" %>

<%@ MasterType VirtualPath="~/Master Pages/Default.Master" %>

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="Styles">
    <style type="text/css">
        .cart-item
        {
            padding: 15px 0px 15px 0px;
            margin-bottom: 16px;
            border-bottom: 1px solid rgb(192,192,192);
            /*border-radius: 12px;*/
           
        }


        .card-front {
            margin-right: 40px;
            width: 180px;
            position: inherit;
            display: inline-block;
            float: left;
        }

        /*.card-front-name
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
        }*/

        .item-detail-list
        {
            /*border: 1px solid rgb(128, 128, 128);*/
            width: 300px;
            height: 150px;
            overflow: auto;
            text-align: left;
        }


        .remove-button
        {
            font-size: 11pt;
            margin: 10px 0px 10px 10px;
            padding: 5px 10px 5px 10px;
            border: 1px solid rgb(202, 41, 36);
            border-radius: 10px;
            color: rgb(202, 41, 36);
            display: inline-block;
            position: absolute;
            bottom: 0px;
            right: 0px;
        }

        .remove-button:hover
        {
            border: 2px solid rgb(157, 25, 25);
            color: rgb(157, 25, 25);
            text-decoration: none;
        }



        .payment-button
        {
            margin-top: 20px;
            margin-bottom: 20px;
            padding: 10px 30px 10px 30px;
            border: 2px solid rgb(36, 156, 202);
            border-radius: 10px;
            color: rgb(36, 156, 202);
            display: inline-block;
        }

        .payment-button:hover
        {
            border: 2px solid rgb(25, 77, 157);
            color: rgb(25, 77, 157);
            text-decoration: none;
        }

        .cannot-deliver
        {
            border: 5px solid rgb(200, 25, 25) !important;
        }
    </style>
    <%-- payment options --%>
    <style type="text/css">
        .payment-options-section
        {
            border-width: 0px 2px 2px 2px;
            border-style: solid;
            border-color: rgb(128, 128, 128);
            padding: 20px 80px;
            width: 100%;
            text-align: left;
            display: inline-block;
        }

        .payment-options-section table
        {
            width: 100%;
        }

        .Error
        {
            color: rgb(200, 25, 25);
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="Scripts">
    <script type="text/javascript">
        function pickLocation(ddl)
        {
            var ddl = $(ddl);

            if (ddl.val() != null && ddl.val() != '') {
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
        <asp:PlaceHolder ID="plhNoItemsInOrder" runat="server">
            <div class="row" style="text-align: center;">
                <div class="col-lg-12" style="margin-bottom: 20px;">
                    There are no items in your cart right now.
                </div>
            </div>
        </asp:PlaceHolder>
        <asp:PlaceHolder ID="plhItemsAreInOrder" runat="server">
            <div class="row" style="text-align: center;">
                <div class="col-lg-12" style="margin-bottom: 20px;">
                    The Cart allows you to modify your food how you like. When you are done, click Pay at the bottom to proceed.
                </div>
                <div>
                    <asp:Label   ID="lblError"       runat="server" Text="" CssClass="Error" />
                </div>
                <div class="payment-options-section" style="border-width: 2px 2px 2px 2px;">
                    <table>
                        <tr>
                            <td>
                                Order Type:
                                <asp:DropDownList ID="ddlDeliveryType" runat="server" AutoPostBack="true" OnTextChanged="ddlDeliveryType_Click" >
                                    <asp:ListItem Text=""         Value="" />
                                    <asp:ListItem Text="Pick Up"  Value="PickUp" />
                                    <asp:ListItem Text="Delivery" Value="Delivery" />
                                </asp:DropDownList>
                            </td>
                            <td id="deliveryLocationContainer" runat="server">
                                Delivery Location:
                                <asp:DropDownList ID="ddlLocations"    runat="server" onchange="pickLocation(this);" >
                                    <asp:ListItem Text=""                   Value="" />
                                    <asp:ListItem Text="Palm's Grille"      Value="Palm's Grille" />
                                    <asp:ListItem Text="Campus House Lobby" Value="Campus House Lobby" />
                                    <asp:ListItem Text="Sports Center"      Value="Sports Center" />
                                    <asp:ListItem Text="Dorm Room"          Value="DR" />
                                    <asp:ListItem Text="Waveland Apartment" Value="WA" />
                                </asp:DropDownList>
                            </td>
                            <td id="locationPlaceContainer" runat="server">
                                <span id="lbllocationPlace" runat="server"></span>
                                <asp:TextBox ID="txtLocationPlace"     runat="server" Width="3em" />
                            </td>
                            <td>
                                Total Price: <asp:Literal ID="litPrice" runat="server" />
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <asp:Repeater ID="rptItems" runat="server" OnItemDataBound="rptItems_ItemDataBound">
                <ItemTemplate>
                    <div class="row">
                        <div class="col-lg-12 cart-item">
                            <div class="front card-front <%# (MyOrder.Type == "Delivery" && Eval("Deliverable") != null && Eval("Deliverable").ToString() != "Y") ? "cannot-deliver" : "" %>">
                                <%# (Eval("ImagePath") != null && Eval("ImagePath").ToString() != "") ? "<img class=\"card-image\" src=\"" + URL.root(Request) + "Includes/images/Menu Items/" + Eval("ImagePath").ToString() +"\" />" : "" %>
                            </div>
                            <asp:Label     ID="litFoodName"    runat="server" Text='<%# Eval("Name") %>' />
                            <asp:Label     ID="lblfrontprice"  runat="server" Text='<%# Eval("Price").ToString().Insert(Eval("Price").ToString().IndexOf("-") + 1,"$") %>' />

                            <%# (Eval("Deliverable") != null &&  Eval("Deliverable").ToString() == "Y") ? "<img alt=\"deliverable\" src=\"" + URL.root(Request) + "Includes/images/delivery/inverted_delivery_icon.png\" style=\"float: right;\" title=\"Deliverable\" />" : "<img alt=\"deliverable\" src=\"" + URL.root(Request) + "Includes/images/delivery/inverted_non_delivery_icon.png\" style=\"float: right;\" title=\"Deliverable\" />" %>
                            <asp:Label         ID="lblDescription" runat="server" Text='<%# Eval("Description") %>' />
                            <asp:HiddenField   ID="hid1"           runat="server" Value='<%# Eval("Deliverable") %>' />
                            <br />
                            <div class="item-detail-list">
                                <asp:Repeater ID="rptDetails" runat="server" OnItemDataBound="rptDetails_ItemDataBound">
                                    <ItemTemplate>
<%--                                        <asp:CheckBox      ID="chbAdded"  runat="server" Text='<%# Eval("Description") %>' Checked='<%# Eval("Chosen") %>' />--%>
                                        <asp:Label         ID="Label1"    runat="server" Text='<%# Eval("Cost").ToString().Insert(Eval("Cost").ToString().IndexOf("-") + 1,"$") %>' />
                                        <asp:HiddenField   ID="hid1"      runat="server" Value='<%# Eval("ID") %>' />
                                        <br />
<%-- (use div like menu...?)
    if...group name and others have same group name... make radio button else make use checkbox.
    if group name = id + "X..." then use (detailID) id to make this detail a subdetail that shows when the corrosponding one is checked. --%>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                            <asp:LinkButton    ID="lnkRemoveItem"  runat="server" Text="Remove" OnClick="lnkRemoveItem_Click" CssClass="remove-button" />
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
            <div class="row" style="text-align: center;">
                <asp:LinkButton ID="lnkGoPay"    runat="server" Text="Pay" OnClick="lnkGoPay_Click" CssClass="payment-button" />
            </div>
        </asp:PlaceHolder>
    </div>
</asp:Content>