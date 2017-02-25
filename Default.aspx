<%@ Page Language="C#"
         AutoEventWireup="true"
         CodeFile="Default.aspx.cs"
         Inherits="_Default"
         MasterPageFile="~/Master Pages/Default.Master" %>

<%@ MasterType VirtualPath="~/Master Pages/Default.Master" %>

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="Styles">
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="Scripts">
</asp:Content>

<asp:Content ID="Content" runat="server" ContentPlaceHolderID="Content">
    <div class="container">
        <div class="row">
            <div>Palms Grille</div>
            <div>Papa John's</div>
        </div>
    </div>
</asp:Content>