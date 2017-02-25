<%@ Page Language="C#"
         AutoEventWireup="true"
         CodeFile="Test.aspx.cs"
         Inherits="Test"
         MasterPageFile="~/Master Pages/Default.Master" %>

<%@ MasterType VirtualPath="~/Master Pages/Default.Master" %>

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="Styles">
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="Scripts">
</asp:Content>

<asp:Content ID="Content" runat="server" ContentPlaceHolderID="Content">
    <h1>Hello World!</h1>
    <asp:Label ID="me" runat="server" />

    <asp:SqlDataSource ID="sqlTestSelect" runat="server"
        ConnectionString="<%$ ConnectionStrings:SEI_DB_Connection.connectionString %>"
        ProviderName="<%$ ConnectionStrings:SEI_DB_Connection.providerName %>"
        SelectCommand="SELECT CASE WHEN COUNT(*) &gt; 0 THEN 'good'
                                   ELSE 'bad'
                              END AS status
                         FROM dual
                    UNION ALL
                       SELECT CASE WHEN COUNT(*) &gt; 0 THEN 'good'
                                    ELSE 'bad'
                               END AS status
                         FROM dual">
    </asp:SqlDataSource>

    <asp:Repeater ID="repTestDisplay" runat="server" DataSourceID="sqlTestSelect">
        <ItemTemplate>
            <br />
            The Connection to the Oracle SEI Database is
            <%-- 5 ways (runs with "errors" lol)--%> 
            <%# Eval("status") %>
            <asp:Label ID="Label1" runat="server" Text=<%# Eval("status") %> />
            <asp:Label ID="Label2" runat="server" Text='<%# Eval("status") %>' />
            <asp:Label ID="Label4" runat="server" OnDataBinding="Label4_DataBinding" /> <%-- see code behind --%>
            <%-- All double quotes like... Text="<%# Eval("status") %>" ...does not work because...
                       _______          __
                      /       \        /  \
                Text="<%# Eval("status") %>"

            is wrong syntax. :-) --%>
            <br />
        </ItemTemplate>
    </asp:Repeater>
    <br />

    <asp:Label ID="lbl1" runat="server" />
    <br />

    <asp:Button ID="btn1" runat="server" OnClick="btn1_Click" Text="Throw Error" />
</asp:Content>