<%@ Page Language="C#"
         Title="Thank You"
         AutoEventWireup="true"
         CodeFile="ThankYou.aspx.cs"
         Inherits="ThankYou"
         MasterPageFile="~/Master Pages/Default.Master" %>

<%@ MasterType VirtualPath="~/Master Pages/Default.Master" %>

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="Styles">
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="Scripts">
</asp:Content>

<asp:Content ID="Content" runat="server" ContentPlaceHolderID="Content">
    <div class="container">
        <div class="row">
	        <h1>Thank You!</h1>
            <h2>Your order number is:<asp:Label ID="lblOrderNumber" runat="server" /></h2>
            <asp:Label ID="lblASAPTime" runat="server" Text="The soonest your order will be ready is the time slot of " Visible="false" />
        </div>
    </div>
</asp:Content>