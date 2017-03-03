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
                <h1><asp:Literal ID="litFoodName" runat="server" Text='<%# Eval("Name") %>' /></h1>
                <asp:Label ID="lblDescription" runat="server" Text='<%# Eval("Description") %>' />
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