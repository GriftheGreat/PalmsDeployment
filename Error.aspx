<%@ Page Language="C#"
         Title="Error"
         AutoEventWireup="true"
         CodeFile="Error.aspx.cs"
         Inherits="Errors" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <link rel="shortcut icon" href=<%= "\"" + URL.root(Request) + "Includes/images/palmsgoIcon.png\"" %>"/>

    <style type="text/css">
        body {
            margin: 0px;
            font-size: 22px;
            font-family: 'Josefin Sans', sans-serif;
            background-color: rgba(242,241,239, .9);
        }

        h2 {
            margin-top: 0px;
            padding: 30px 20px;
            background-color: rgba(13,86,55, .9);
            color: white;
	        height: 35px;
            text-align: center;
        }

        .logo {
            margin-top: -15px;
            margin-left: 7px;
            float: left !important;
        }

        .navbar-link {
            font-size: 22px;
            font-family: 'Josefin Sans', sans-serif;
            font-weight: normal;
            color: rgb(255, 255, 255) !important;
            white-space: nowrap;
            text-decoration: initial;
            vertical-align: top;
        }

        .navbar-link:hover {
            color: rgba(272,120,75, .99) !important;
        }

        div span {
            padding-left: 20px;
        }

        div div {
            padding-left: 40px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <h2>
            <span class="logo">
                <a class="navbar-brand" href="Default.aspx"><img alt="Palms" src=<%= "\"" + URL.root(Request) + "Includes/images/palmsgoSandybrown.png\"" %> /></a>
            </span>
            <span style="float: left;">Error:</span>
            <asp:LinkButton ID="lnkbHome" runat="server" Text="Home" OnClick="lnkbHome_Click" CssClass="navbar-link" />
        </h2>
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