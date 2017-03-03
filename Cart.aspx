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
    <asp:Button ID="btnHI" Text="show DB order data" runat="server" OnClick="btnHI_click" />
    <br />
    <asp:SqlDataSource ID="sqlstuff" runat="server"
        ConnectionString="<%$ ConnectionStrings:SEI_DB_Connection.connectionString %>"
        ProviderName="<%$ ConnectionStrings:SEI_DB_Connection.providerName %>"
        SelectCommand='SELECT * FROM "order"'>
    </asp:SqlDataSource>
    <asp:GridView ID="gdvstuff" runat="server" DataSourceID="sqlstuff" AutoGenerateColumns="true" Visible="false" />
    
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