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
        var numInterval = 0;

        $(document).ready(function () {
            $(document).focus();

            $('div[class*="window_button"]').on('click', function ()
            {
                //get the button number
                var window_num = parseInt($(this).attr('id').replace('#', ''));

                //refresh the orders for it
                get_orders(window_num);

                //change which one is focused if necessary
                $('div[class*="window_button"]').each(function () {
                    $(this).removeClass("focused_window_button");
                });
                $("#" + window_num.toString()).addClass("focused_window_button");
            });

            setInterval(function () //there can be only one interval which is replaced by any following calls to setInterval()
            {
                document.getElementById("time").innerHTML = (new Date()).toLocaleTimeString();

                if (numInterval >= 3)
                {
                    //get the button number and refresh the orders for it
                    get_orders(parseInt($('div[class*="focused_window_button"]').first().attr('id').replace('#', '')));
                    numInterval = 0;
                }

                numInterval = numInterval + 1;
            }, 1000);
        });

        $(document).on('keypress', function (e) {
            //get the button number
            var window_number = parseInt($('div[class*="focused_window_button"]').first().attr('id').replace('#', ''));
            var code = (e.keyCode | e.which); // bitwise OR

            if (window_number == 1)//only 'Front Window' for now
            {
            if (code >= 49 && code <= 56)
            {
                //$('input[order_id]').each(function (index, box)
                //{
                //    if ((index + 1) == (code - 48)) //match box on screen to keypad number
                //    {
                var id = $($('input[order_id]').toArray()[code - 49]).attr("order_id");
                if (id != "")
                {
                    $.ajax({
                        type: "POST",
                        url: "BumpBoard.aspx/bump_order",
                        contentType: "application/json; charset=utf-8",
                        data: '{"order_id":' + id + '}',
                        dataType: "json",
                        success: function (result) {
                            $(document).focus();
                            get_orders(window_number);
                        },
                        error: function (XMLHttpRequest, textStatus, errorThrown) {
                            alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                        }
                    });
                }
                //    }
                //});
            }
            }
        });

        function get_orders(window_display)
        {
            var boundary = 8;

            $.ajax({
                type: "POST",
                url: "BumpBoard.aspx/get_more_orders",
                contentType: "application/json; charset=utf-8",
                data: '{"order_number_boundary":' + boundary + ', "window_number": ' + window_display + '}',
                dataType: "json",
                success: function (result) {
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
            <div id="1" class="window_button focused_window_button">Front Window</div>
            <div id="2" class="window_button">Back Window</div>
            <div id="3" class="window_button">Ice Cream</div>
            <div id="4" class="window_button">Frier</div>
            <div id="5" class="window_button">Salad</div>
            <div id="6" class="window_button">Pizza</div>
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
