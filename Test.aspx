<%@ Page Language="C#"
         Title="Test"
         AutoEventWireup="true"
         CodeFile="Test.aspx.cs"
         Inherits="Test"
         MasterPageFile="~/Master Pages/Default.Master" %>

<%@ MasterType VirtualPath="~/Master Pages/Default.Master" %>

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="Styles">
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="Scripts">
    <script type="text/javascript">
        function send_click() {
            $.ajax({
                type: "POST",
                data: "{}",
                dataType: "json",
                url: "http://localhost:50168/Services/CreditCard.asmx/HelloWorld",
                contentType: "application/json; charset=utf-8",
                success: function (msg) {
                    alert(msg.d);
                    $("lbl2").val(msg.d);
                },
                error: function () {
                    alert("Fail (I re-commented [System.Web.Script.Services.ScriptService] in ...\App_Code\CreditCard.cs)");
                    $("lbl2").val("Fail");
                }
            });
        }    </script>
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
    <br />
    <br />

    I used Send_Credit_Card_Info AJAX to see the <span style="font-weight: bold;">request headers</span> i needed for Send_Credit_Card_Info SERVER<br />
    <asp:Button ID="btn2" runat="server" OnClick="btn2_Click" Text="Send_Credit_Card_Info SERVER" />
    <div style="background-color: ButtonFace;border: 1px solid ButtonShadow;display: inline-block;padding: 2px;cursor: pointer;" onclick="send_click();">Send_Credit_Card_Info AJAX</div>
    <br />
    <asp:Label ID="lbl2" runat="server" />
    <br />
    <br />

    Request.Url.GetLeftPart(UriPartial.Authority) <pre><%= Request.Url.GetLeftPart(UriPartial.Authority) %></pre><br />
    Request.ApplicationPath                       <pre><%= Request.ApplicationPath %></pre><br />
    Request.Path                                  <pre><%= Request.Path %></pre><br />
    Request.PhysicalPath                          <pre><%= Request.PhysicalPath %></pre><br />
    Request.Url.AbsolutePath                      <pre><%= Request.Url.AbsolutePath %></pre><br />
    Request.Url.AbsoluteUri                       <pre><%= Request.Url.AbsoluteUri %></pre><br />
    Request.Url.GetLeftPart(UriPartial.Path)      <pre><%= Request.Url.GetLeftPart(UriPartial.Path) %></pre><br />
    Request.Url.LocalPath                         <pre><%= Request.Url.LocalPath %></pre><br />
</asp:Content>