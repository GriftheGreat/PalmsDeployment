<%@ Page Title="Home Page"
    Language="C#"
    MasterPageFile="~/Master Pages/Bump_Board.Master"
    AutoEventWireup="true"
    CodeFile="bump_board.aspx.cs" 
    Inherits="_Bump_Board"

    EnableEventValidation="true"
     %>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="scripts" >
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
       <script type="text/javascript">
           document.addEventListener("keypress", process_input);
           function process_input(e)
           {
               if(e.keyCode >= 49 && e.keyCode <= 56)
               {
                   alert("boo " + e.keyCode.toString());
                   document.focus();
               }
               
           }

           function get_orders(window_display) {
               var boundary = 3;
               var window_number = window_display;
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
            <div id="1" class="window_button" onclick="get_orders(1);">Front Window</div>
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
                <asp:Button UseSubmitBehavior="false" CssClass="base_bar"         ID="clear"  Text="Clear"  runat="server"></asp:Button>
                <asp:Button UseSubmitBehavior="false" CssClass="base_bar grey"    ID="park"   Text="Park"  runat="server"></asp:Button>
                <asp:Button UseSubmitBehavior="false" CssClass="base_bar"         ID="sum"    Text="Sum"  runat="server"></asp:Button>
                <asp:Button UseSubmitBehavior="false" CssClass="base_bar"         ID="recall" Text="Recall"  runat="server"></asp:Button>
                <asp:Button UseSubmitBehavior="false" CssClass="base_bar grey"    ID="esc"    Text="Esc"  runat="server"></asp:Button>
                <asp:Button UseSubmitBehavior="false" CssClass="base_bar"         ID="refresh" Text="Refresh"  runat="server"></asp:Button>
                <asp:Button UseSubmitBehavior="false" CssClass="base_bar"         ID="funct"  Text="Funct"  runat="server"></asp:Button>
                <asp:Button UseSubmitBehavior="false" CssClass="base_bar red"     ID="help"   Text="Help"  runat="server"></asp:Button>
            </div>
            <div id="func"><span id="time"></span></div>
        </div>
    </div>
</asp:Content>
