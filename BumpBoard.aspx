<%@ Page Language="C#"
         Title="Home Page"
         AutoEventWireup="true"
         CodeFile="BumpBoard.aspx.cs" 
         Inherits="_Bump_Board"
         MasterPageFile="~/Master Pages/Bump_Board.Master"%>

<%@ MasterType VirtualPath="~/Master Pages/Bump_Board.Master" %>

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="Styles">
    <link rel="stylesheet" type="text/css" href=<%= "\"" + URL.root(Request) + "Includes/stylesheets/Bump_Board.css\"" %> />
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="Scripts" >
    <script type="text/javascript">
        setInterval(function () {
            document.getElementById("time").innerHTML = (new Date()).toLocaleTimeString();
            //get_orders();
        }, 1000);
        //there can be only one interval replaced by calls to setInterval()
    </script>
    <script type="text/javascript">
        var window_number = 1;
        var order_box_array;

        $(document).ready(function () {
            $(document).focus();
        });

        $(document).on('keypress', function (e) {
            if (window_number == 1)
            {
                alert(e.keyCode);
                alert(e.keyCode >= 49 && e.keyCode <= 56);
                if (e.keyCode >= 49 && e.keyCode <= 56)
                {
                    //alert(e.keyCode.toString());
                    $('input[order_id]').each(function (index, box) {
                        //alert(index.toString());
                        if ((index + 1) == (e.keyCode - 48)) {
                            var id = $(box).attr("order_id");
                            if (id != "") {
                                $.ajax({
                                    type: "POST",
                                    url: "bump_board.aspx/bump_order",
                                    contentType: "application/json; charset=utf-8",
                                    data: '{"order_id":' + id + '}',
                                    dataType: "json",
                                    success: function (result) {
                                        document.focus();
                                        get_orders(1);
                                    },
                                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                                        alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                                    }
                                });
                            }
                        }
                    });
                }
            }
        });

        function get_orders(window_display) {
            var boundary = 8;
            window_number = window_display;
            $("#1").removeClass("focused_window_button");
            $("#2").removeClass("focused_window_button");
            $("#3").removeClass("focused_window_button");
            $("#4").removeClass("focused_window_button");
            $("#5").removeClass("focused_window_button");
            $("#6").removeClass("focused_window_button");
            $("#" + window_display.toString()).addClass("focused_window_button");
            $.ajax({
                type: "POST",
                url: "bump_board.aspx/get_more_orders",
                contentType: "application/json; charset=utf-8",
                data: '{"order_number_boundary":' + boundary + ', "window_number": ' + window_number + '}',
                dataType: "json",
                success: function (result) {
                    //alert(window_number.toString());
                    $("#middle").html(result.d);
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                }
            });
        }
    </script>
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="Content" runat="server">
    <div class="order_display">    
        <div class="top">
            <div id="1" class="window_button focused_window_button" onclick="get_orders(1);">Front Window</div>
            <div id="2" class="window_button" onclick="get_orders(2);">Back Window</div>
            <div id="3" class="window_button" onclick="get_orders(3);">Ice Cream</div>
            <div id="4" class="window_button" onclick="get_orders(4);">Frier</div>
            <div id="5" class="window_button" onclick="get_orders(5);">Salad</div>
            <div id="6" class="window_button" onclick="get_orders(6);">Pizza</div>
            <div class="bar">PG - Front Video 8</div> 
        </div>
         
        <div id="middle" class="middle">
            <asp:Literal ID="litOrder_boxes" runat="server" />
        </div>

        <div class="bottom">
            <div style="float: left;">BT 10.19.33.21</div>
            <div style="display: inline-block;">
                <asp:Button UseSubmitBehavior="false" CssClass="base_bar"       enabled="false"   ID="clear"  Text="Clear"  runat="server"></asp:Button>
                <asp:Button UseSubmitBehavior="false" CssClass="base_bar grey"  enabled="false"   ID="park"   Text="Park"  runat="server"></asp:Button>
                <asp:Button UseSubmitBehavior="false" CssClass="base_bar"       enabled="false"   ID="sum"    Text="Sum"  runat="server"></asp:Button>
                <asp:Button UseSubmitBehavior="false" CssClass="base_bar"       enabled="false"   ID="recall" Text="Recall"  runat="server"></asp:Button>
                <asp:Button UseSubmitBehavior="false" CssClass="base_bar grey"  enabled="false"   ID="esc"    Text="Esc"  runat="server"></asp:Button>
                <asp:Button UseSubmitBehavior="false" CssClass="base_bar"       enabled="false"   ID="refresh" Text="Refresh"  runat="server"></asp:Button>
                <asp:Button UseSubmitBehavior="false" CssClass="base_bar"       enabled="false"   ID="funct"  Text="Funct"  runat="server"></asp:Button>
                <asp:Button UseSubmitBehavior="false" CssClass="base_bar red"   enabled="false"   ID="help"   Text="Help"  runat="server"></asp:Button>
            </div>
            <div id="func"><span id="time"></span></div>
        </div>
    </div>
</asp:Content>
