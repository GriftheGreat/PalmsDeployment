﻿<%@ Page Language="C#"
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
        }
    </script>
</asp:Content>

<asp:Content ID="Content" runat="server" ContentPlaceHolderID="Content">
    <asp:GridView ID="gdvSession" runat="server" AutoGenerateColumns="true" ShowHeaderWhenEmpty="true"></asp:GridView>
    <asp:Button ID="btnClearSession" runat="server" OnClick="btnClearSession_Click" Text="Clear All Session Variables" />
    <br /><br />

    <input id="chb1" type="checkbox" onclick="$('#stuff1').toggle();" checked="checked" />
    <label for="chb1" >Hide/Show Menu data from webservice</label>
    <div id="stuff1" style="display:none;">
        <asp:GridView ID="gdvMenu1" runat="server" AutoGenerateColumns="true" ShowHeaderWhenEmpty="true"></asp:GridView>
        <br />
        <asp:GridView ID="gdvMenu2" runat="server" AutoGenerateColumns="true" ShowHeaderWhenEmpty="true"></asp:GridView>
        <br />
        <asp:GridView ID="gdvMenu3" runat="server" AutoGenerateColumns="true" ShowHeaderWhenEmpty="true"></asp:GridView>
        <br />
        <asp:GridView ID="gdvMenu4" runat="server" AutoGenerateColumns="true" ShowHeaderWhenEmpty="true"></asp:GridView>
    </div>
    <br /><br />

    <asp:Button ID="btn1" runat="server" OnClick="btn1_Click" Text="Throw Error" />
    <br /><br />

    I used Send_Credit_Card_Info AJAX to see the <span style="font-weight: bold;">request headers</span> i needed for Send_Credit_Card_Info SERVER<br />
    <asp:Button ID="btn2" runat="server" OnClick="btn2_Click" Text="Send_Credit_Card_Info SERVER" />
    <div style="background-color: ButtonFace;border: 1px solid ButtonShadow;display: inline-block;padding: 2px;cursor: pointer;" onclick="send_click();">Send_Credit_Card_Info AJAX</div>
    <br />
    <asp:Label ID="lbl2" runat="server" />
    <br />
        
    <input id="chb2" type="checkbox" onclick="$('#stuff2').toggle();" checked="checked" />
    <label for="chb2" >Hide/Show URL path properties</label>
    <div id="stuff2" style="display:none;">
        Request.Url.GetLeftPart(UriPartial.Authority) <pre><%= Request.Url.GetLeftPart(UriPartial.Authority) %></pre><br />
        Request.ApplicationPath                       <pre><%= Request.ApplicationPath %></pre><br />
        Request.Path                                  <pre><%= Request.Path %></pre><br />
        Request.PhysicalPath                          <pre><%= Request.PhysicalPath %></pre><br />
        Request.Url.AbsolutePath                      <pre><%= Request.Url.AbsolutePath %></pre><br />
        Request.Url.AbsoluteUri                       <pre><%= Request.Url.AbsoluteUri %></pre><br />
        Request.Url.GetLeftPart(UriPartial.Path)      <pre><%= Request.Url.GetLeftPart(UriPartial.Path) %></pre><br />
        Request.Url.LocalPath                         <pre><%= Request.Url.LocalPath %></pre><br />
    </div>
    <br />
    <br />

    <input id="chb3" type="checkbox" onclick="$('#stuff3').toggle();" checked="checked" />
    <label for="chb3" >Hide/Show Debug values</label>
    <div id="stuff3" style="display:none;">
        <pre><%= Session["v1"] %></pre><br />
        <pre><%= Session["v2"] %></pre><br />
        <pre><%= Session["v3"] %></pre><br />
        <pre><%= Session["v4"] %></pre><br />
        <pre><%= Session["v5"] %></pre><br />
        <pre><%= Session["v6"] %></pre><br />
    </div>
</asp:Content>