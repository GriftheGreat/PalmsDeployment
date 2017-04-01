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
    </style>
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="Scripts">
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
            </div>
            <asp:Repeater ID="rptItems" runat="server" OnItemDataBound="rptItems_ItemDataBound">
                <ItemTemplate>
                    <div class="row">
                        <div class="col-lg-12 cart-item">
                            <div class="front card-front">
<%# (Eval("ImagePath") != null && Eval("ImagePath").ToString() != "") ? "    <img class=\"card-image\" src=\"" + Request.Url.GetLeftPart(UriPartial.Authority) + "/Includes/images/Menu Items/" + Eval("ImagePath").ToString() +"\" />" : "" %>
                               <%-- <asp:Label     ID="litFoodName"    runat="server" Text='<%# Eval("Name") %>'  CssClass="card-front-name" />
                                <asp:Label     ID="lblfrontprice"  runat="server" Text='<%# Eval("Price") %>' CssClass="card-front-price" />--%>
                            </div>
<%--                        <asp:Literal       ID="lit1"           runat="server" Text='<%# Eval("Deliverable").ToString() == "Y" ? "<img alt=\"deliverable\" src=\"" + Request.Url.GetLeftPart(UriPartial.Authority) + "/Includes/images/delivery/deliver icon 2.png\" />" : "" %>' />--%>
<%# (Eval("Deliverable") != null &&  Eval("Deliverable").ToString() == "Y") ? "                        <img alt=\"deliverable\" src=\"" + Request.Url.GetLeftPart(UriPartial.Authority) + "/Includes/images/delivery/deliver icon 2.png\" style=\"float: right;background-color: green;\" title=\"Deliverable\" />" : "" %>
                            <asp:Label         ID="lblDescription" runat="server" Text='<%# Eval("Description") %>' />
                            <asp:HiddenField   ID="hid1"           runat="server" Value='<%# Eval("Deliverable") %>' />
                        <%--Deliverable
                            Description
                            Details
                            ID
                            Name
                            Price
                            ImagePath--%>
                            <br />
                            <div class="item-detail-list">
                                <asp:Repeater ID="rptDetails" runat="server">
                                    <ItemTemplate>
                                        <%--# Eval("Chosen").ToString() --%>
                                        <asp:CheckBox      ID="chbAdded"    runat="server" Text='<%# Eval("Description") %>' Checked='<%# Eval("Chosen") %>' />
                                        <%--<asp:Label         ID="lblmydetails" runat="server" Text='<%# Eval("Description") %>' />--%>
                                        <asp:Label         ID="Label1" runat="server" Text='<%# "$" + Eval("Cost").ToString() %>' />
                                        <%--<asp:Label         ID="Label2" runat="server" Text='<%# Eval("GroupName") %>' />--%>
                                        <asp:HiddenField   ID="hid1"   runat="server" Value='<%# Eval("ID") %>' /><br />
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                            <asp:LinkButton    ID="lnkRemoveItem"  runat="server" Text="Remove" OnClick="lnkRemoveItem_Click" CssClass="remove-button" />
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
            <div class="row" style="text-align: center;">
                <asp:Label      ID="lblfullprice" runat="server" />
                <br />
                <asp:LinkButton ID="lnkGoPay"     runat="server" Text="Pay" OnClick="lnkGoPay_Click" CssClass="payment-button" />
            </div>
        </asp:PlaceHolder>
    </div>
</asp:Content>