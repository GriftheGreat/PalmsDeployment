<%@ Page Language="C#"
         Title="Cart"
         AutoEventWireup="true"
         CodeFile="Cart.aspx.cs"
         Inherits="Cart"
         MasterPageFile="~/Master Pages/Default.Master" %>

<%@ MasterType VirtualPath="~/Master Pages/Default.Master" %>

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="Styles">
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
    </style>
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="Scripts">
</asp:Content>

<asp:Content ID="Content" runat="server" ContentPlaceHolderID="Content">
    <br />
    Hello World! This is the cart!
    <br />
    <asp:LinkButton ID="lnk1" runat="server" Text="Pay" OnClick="lnk1_Click" />
    <br />
    <div class="container">
        <asp:Repeater ID="rptItems" runat="server">
            <ItemTemplate>
                <div class="row">
                    <div class="col-lg-12 cart-row">
                        <div class="front">
<%# string.IsNullOrEmpty(Eval("ImagePath").ToString()) ? "" : "                                    <img class=\"card-image\" src=\"" + Request.Url.GetLeftPart(UriPartial.Authority) + "/Includes/images/Menu Items/" + Eval("ImagePath").ToString() +"\" />" %>
                            <asp:Label     ID="litFoodName"    runat="server" Text='<%# Eval("Name") %>'  CssClass="card-front-name" />
                            <asp:Label     ID="lblfrontprice"  runat="server" Text='<%# Eval("Price") %>' CssClass="card-front-price" />
                        </div>
                        <asp:Label         ID="lblDescription" runat="server" Text='<%# Eval("Description") %>' />
                        <asp:HiddenField   ID="hid1"           runat="server" Value='<%# Eval("Deliverable") %>' />
                        <asp:Literal       ID="lit1"           runat="server" Text='<%# Eval("Deliverable").ToString() == "Y" ? "<img alt=\"deliverable\" src=\"" + Request.Url.GetLeftPart(UriPartial.Authority) + "Includes/images/delivery/deliver icon 2.png\" />" : "" %>' />
<%# Eval("Deliverable").ToString() == "Y" ? "                        <img alt=\"deliverable\" src=\"" + Request.Url.GetLeftPart(UriPartial.Authority) + "/Includes/images/delivery/deliver icon 2.png\" />" : "" %>
                    <%--Deliverable
                        Description
                        Details
                        ID
                        Name
                        Price
                        ImagePath--%>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</asp:Content>