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
    <asp:SqlDataSource ID="sqlstuff" runat="server"
        ConnectionString="<%$ ConnectionStrings:SEI_DB_Connection %>"
        ProviderName="<%$ ConnectionStrings:SEI_DB_Connection.providerName %>"
        SelectCommand="SELECT * FROM food_detail_line">
    </asp:SqlDataSource>
    <asp:GridView ID="gdvstuff" runat="server" DataSourceID="sqlstuff" AutoGenerateColumns="true" />
</asp:Content>