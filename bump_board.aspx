<%@ Page Title="Home Page"
    Language="C#"
    MasterPageFile="~/Master Pages/Bump_Board.Master"
    AutoEventWireup="true"
    CodeFile="bump_board.aspx.cs" 
    Inherits="_Bump_Board" %>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="scripts" >
    <script type="text/javascript">
        $(document).ready(function (){ 
        });


    </script>

</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="Content" runat="server">
    
    <asp:MultiView ID="tab_multi_view" ActiveViewIndex="0" runat="server" >
        
    <asp:View ID="front_window_view" runat="server">
             <asp:Button CssClass="focused_tab" ID="Button1"  Text="Front Window" OnClick="front_window_Click" runat="server"></asp:Button>
             <asp:Button CssClass="tab" ID="Button2"   Text="Back Window"  OnClick="back_window_Click" runat="server"></asp:Button>
             <asp:Button CssClass="tab" ID="Button3"     Text="Ice Cream"  OnClick="ice_cream_Click" runat="server"></asp:Button>
             <asp:Button CssClass="tab" ID="Button4"         Text="Frier"  OnClick="frier_Click" runat="server"></asp:Button> 
             <asp:Button CssClass="tab" ID="Button5"         Text="Salad"  OnClick="salad_Click" runat="server"></asp:Button>
             <asp:Button CssClass="tab" ID="Button6"         Text="Pizza"  OnClick="pizza_Click" runat="server"></asp:Button> 
    </asp:View>
    <asp:View ID="ice_cream_view"  runat="server">
             <asp:Button CssClass="tab" ID="Button7"  Text="Front Window" OnClick="front_window_Click" runat="server"></asp:Button>
             <asp:Button CssClass="focused_tab" ID="Button8"   Text="Back Window"  OnClick="back_window_Click" runat="server"></asp:Button>
             <asp:Button CssClass="tab" ID="Button9"     Text="Ice Cream"  OnClick="ice_cream_Click" runat="server"></asp:Button>
             <asp:Button CssClass="tab" ID="Button10"         Text="Frier"  OnClick="frier_Click" runat="server"></asp:Button> 
             <asp:Button CssClass="tab" ID="Button11"         Text="Salad"  OnClick="salad_Click" runat="server"></asp:Button>
             <asp:Button CssClass="tab" ID="Button12"         Text="Pizza"  OnClick="pizza_Click" runat="server"></asp:Button> 
    </asp:View>
    <asp:View ID="frier_view"  runat="server">
             <asp:Button CssClass="tab" ID="Button13"  Text="Front Window" OnClick="front_window_Click" runat="server"></asp:Button>
             <asp:Button CssClass="tab" ID="Button14"   Text="Back Window"  OnClick="back_window_Click" runat="server"></asp:Button>
             <asp:Button CssClass="focused_tab" ID="Button15"     Text="Ice Cream"  OnClick="ice_cream_Click" runat="server"></asp:Button>
             <asp:Button CssClass="tab" ID="Button16"         Text="Frier"  OnClick="frier_Click" runat="server"></asp:Button> 
             <asp:Button CssClass="tab" ID="Button17"         Text="Salad"  OnClick="salad_Click" runat="server"></asp:Button>
             <asp:Button CssClass="tab" ID="Button18"         Text="Pizza"  OnClick="pizza_Click" runat="server"></asp:Button> 
    </asp:View>
    <asp:View ID="salad_view"  runat="server">
             <asp:Button CssClass="tab" ID="Button19"  Text="Front Window" OnClick="front_window_Click" runat="server"></asp:Button>
             <asp:Button CssClass="tab" ID="Button20"   Text="Back Window"  OnClick="back_window_Click" runat="server"></asp:Button>
             <asp:Button CssClass="tab" ID="Button21"     Text="Ice Cream"  OnClick="ice_cream_Click" runat="server"></asp:Button>
             <asp:Button CssClass="focused_tab" ID="Button22"         Text="Frier"  OnClick="frier_Click" runat="server"></asp:Button> 
             <asp:Button CssClass="tab" ID="Button23"         Text="Salad"  OnClick="salad_Click" runat="server"></asp:Button>
             <asp:Button CssClass="tab" ID="Button24"         Text="Pizza"  OnClick="pizza_Click" runat="server"></asp:Button> 
    </asp:View>
    <asp:View ID="pizza_view" runat="server">
             <asp:Button CssClass="tab" ID="Button25"  Text="Front Window" OnClick="front_window_Click" runat="server"></asp:Button>
             <asp:Button CssClass="tab" ID="Button26"   Text="Back Window"  OnClick="back_window_Click" runat="server"></asp:Button>
             <asp:Button CssClass="tab" ID="Button27"     Text="Ice Cream"  OnClick="ice_cream_Click" runat="server"></asp:Button>
             <asp:Button CssClass="tab" ID="Button28"         Text="Frier"  OnClick="frier_Click" runat="server"></asp:Button> 
             <asp:Button CssClass="focused_tab" ID="Button29"         Text="Salad"  OnClick="salad_Click" runat="server"></asp:Button>
             <asp:Button CssClass="tab" ID="Button30"         Text="Pizza"  OnClick="pizza_Click" runat="server"></asp:Button> 
     </asp:View>
    <asp:View ID="back_window_view"  runat="server">
             <asp:Button CssClass="tab" ID="button31"  Text="Front Window" OnClick="front_window_Click" runat="server"></asp:Button>
             <asp:Button CssClass="tab" ID="button32"   Text="Back Window"  OnClick="back_window_Click" runat="server"></asp:Button>
             <asp:Button CssClass="tab" ID="button33"     Text="Ice Cream"  OnClick="ice_cream_Click" runat="server"></asp:Button>
             <asp:Button CssClass="tab" ID="button34"         Text="Frier"  OnClick="frier_Click" runat="server"></asp:Button> 
             <asp:Button CssClass="tab" ID="button35"         Text="Salad"  OnClick="salad_Click" runat="server"></asp:Button>
             <asp:Button CssClass="focused_tab" ID="button36"         Text="Pizza"  OnClick="pizza_Click" runat="server"></asp:Button> 
    </asp:View>
    </asp:MultiView>   

    <div class="bar">PG - Front Video 8</div>
    <div class="row1">
    <asp:Repeater    ID="repeat_orderbox" runat="server">
        <ItemTemplate>
            <div class="orderBox">
                <asp:HiddenField ID="hid1" runat="server" Value='<%# Eval("order_id_pk") %>' />
                <span <%# Eval("customer_fname") %> class="order_text" />
                <span <%# Eval("customer_lname") %> class="order_text" />
                <span <%# Eval("order_num") %>      class="order_text" />
            
                 <asp:SqlDataSource ID="order_element" runat="server"
                    ConnectionString="<%$ ConnectionStrings:SEI_DB_Connection.connectionString %>"
                    ProviderName=    "<%$ ConnectionStrings:SEI_DB_Connection.providerName %>"
                
                     SelectCommand="SELECT food_name, order_element_id_pk
                                    FROM   food
                                    JOIN   order_element
                                      ON   order_element.food_id_fk = food.food_id_pk
                                    WHERE  order_element.order_id_fk = :order_id">

                     <SelectParameters>
                         <asp:ControlParameter ControlID="hid1" PropertyName="Value" Name="order_id" />
                     </SelectParameters>
                </asp:SqlDataSource>
                <asp:Repeater ID="repeat_food_items" runat="server" DataSourceID="order_element">
                    <ItemTemplate>
                        <asp:HiddenField ID="hid2" runat="server" Value='<%# Eval("order_element_id_pk") %>' />
                        <div class="food_item">
                            <span <%# Eval("food_name") %> class="food_item" />
                        </div>  
                        <asp:SqlDataSource ID="detail_item" runat="server"
                                ConnectionString="<%$ ConnectionStrings:SEI_DB_Connection.connectionString %>"
                                ProviderName=    "<%$ ConnectionStrings:SEI_DB_Connection.providerName %>"
                    
                                SelectCommand="SELECT detail_descr
                                                FROM detail
                                                JOIN order_detail
                                                ON  order_detail.detail_id_fk = detail.detail_id_pk
                                                WHERE order_element_id_fk = :order_element_id_pk">

                                <SelectParameters>
                                    <asp:ControlParameter ControlID="hid2" PropertyName="Value" Name="order_element_id_pk" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:Repeater ID="repeat_details" runat="server" DataSourceID="detail_item">
                                <ItemTemplate>
                                    <div class="detail">
                                        <span <%# Eval("detail_descr") %>      class="detail" />                           
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                    </ItemTemplate>
                </asp:Repeater>
                </div>
        </ItemTemplate>
    </asp:Repeater>
    </div>
    
                    



      
<!--      <div class="row1">
               <div class="orderBox">
         </div><div class="orderBox">
         </div><div class="orderBox">
         </div><div class="orderBox">
		 </div>         
      </div>
      <div class="bar"></div>
      <div class="row2">
               <div class="orderBox">
         </div><div class="orderBox">
         </div><div class="orderBox">
         </div><div class="orderBox">
         </div>
      </div>
    -->
      <div id="bottom">
         <div style="float: left;">BT 10.19.33.21</div>
         <div style="display: inline-block;">
            <asp:Button CssClass="base_bar"         ID="clear"  Text="Clear"  runat="server"></asp:Button>
            <asp:Button CssClass="base_bar grey"    ID="park"   Text="Park"  runat="server"></asp:Button>
            <asp:Button CssClass="base_bar"         ID="sum"    Text="Sum"  runat="server"></asp:Button>
            <asp:Button CssClass="base_bar"         ID="recall" Text="Recall"  runat="server"></asp:Button>
            <asp:Button CssClass="base_bar grey"    ID="esc"    Text="Esc"  runat="server"></asp:Button>
            <asp:Button CssClass="base_bar"         ID="refresh" Text="Refresh"  runat="server"></asp:Button>
            <asp:Button CssClass="base_bar"         ID="funct"  Text="Funct"  runat="server"></asp:Button>
            <asp:Button CssClass="base_bar red"     ID="help"   Text="Help"  runat="server"></asp:Button>
         </div>
         <div id="func"><span id="time"></span></div>
      </div>
</asp:Content>
