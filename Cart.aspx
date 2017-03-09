<%@ Page Language="C#"
         AutoEventWireup="true"
         CodeFile="Cart.aspx.cs"
         Inherits="Cart"
         MasterPageFile="~/Master Pages/Default.Master" %>

<%@ MasterType VirtualPath="~/Master Pages/Default.Master" %>

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="Styles">
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="Scripts">
</asp:Content>

<asp:Content ID="Content" runat="server" ContentPlaceHolderID="Content">
    <br />
    Hello World! This is the cart!
    <br />
    <asp:Repeater ID="rptItems" runat="server">
        <ItemTemplate>
            <div>
                <div class="front">
<%# string.IsNullOrEmpty(Eval("ImagePath").ToString()) ? "" : "                                    <img class=\"card-image\" src=\"Includes/images/Menu Items/" + Eval("ImagePath").ToString() +"\">" %>
                    <h1><asp:Label ID="litFoodName"    runat="server" Text='<%# Eval("Name") %>' CssClass="card-front-name" /></h1>
                </div>
                <asp:Label         ID="lblDescription" runat="server" Text='<%# Eval("Description") %>' />
                <asp:Label         ID="lblPrice"       runat="server" Text='<%# Eval("Price") %>' />
                <asp:HiddenField   ID="hid1"           runat="server" Value='<%# Eval("Deliverable") %>' />
            <%-- if (this..hid1.Value == "Y") { --%>
                <img alt="deliverable" src=<%= "\"" + Request.Url.GetLeftPart(UriPartial.Authority) + "Includes/images/delivery/deliver icon 2.png\"" %> />
            <%-- } --%>
            <%--Deliverable
                Description
                Details
                ID
                Name
                Price
                ImagePath--%>
            </div>
        </ItemTemplate>
    </asp:Repeater>
</asp:Content>