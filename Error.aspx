<%@ Page Language="C#"
         AutoEventWireup="true"
         CodeFile="Error.aspx.cs"
         Inherits="Errors" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <h2>Error:</h2>
        <p></p>
        <asp:Label ID="FriendlyErrorMsg" runat="server" Text="Label" Font-Size="Large" style="color: red"></asp:Label>

        <asp:Panel ID="DetailedErrorPanel" runat="server" Visible="false">
            <h4>Detailed Error:</h4>
            <p>
                <asp:Label ID="ErrorDetailedMsg" runat="server" Font-Size="Small" /><br />
            </p>

            <%--<h4>Error Handler:</h4>
            <p>
                <asp:Label ID="ErrorHandler" runat="server" Font-Size="Small" /><br />
            </p>--%>

            <h4>Detailed Error Message:</h4>
            <p>
                <asp:Label ID="InnerMessage" runat="server" Font-Size="Small" /><br />
            </p>
            <p>
                <asp:Label ID="InnerTrace" runat="server"  />
            </p>
        </asp:Panel>
    </div>
    </form>
</body>
</html>