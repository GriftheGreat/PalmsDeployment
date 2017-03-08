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
    <h1>Hello World! This is the cart!</h1>
    <br />
    <asp:Repeater ID="rptItems" runat="server">
        <ItemTemplate>
            <div>
                <div class="front">
<%# string.IsNullOrEmpty(Eval("image_path").ToString()) ? "" : "                                    <img class=\"card-image\" src=\"Includes/images/Menu Items/" + Eval("image_path").ToString() +"\">" %>
                    <h1><asp:Literal ID="litFoodName"    runat="server" Text='<%# Eval("Name") %>' /></h1>
                </div>
                <asp:Label       ID="lblDescription" runat="server" Text='<%# Eval("Description") %>' />
                <asp:Label       ID="lblPrice"       runat="server" Text='<%# Eval("Price") %>' />
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