<%@ Page Language="C#"
         AutoEventWireup="true"
         CodeFile="PapaJohns.aspx.cs"
         Inherits="PapaJohns"
         MasterPageFile="~/Master Pages/Default.Master" %>

<%@ MasterType VirtualPath="~/Master Pages/Default.Master" %>

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="Styles">
    <style type="text/css">
        /* Choices page css code starts here */
        /*.burgerHeader, .wrapsHeader, .paniniHeader, .quesadillaHeader, .saladHeader, .pizzaHeader
        {
            color: rgba(13,86,55, .9);
            background-color: sandybrown;
            font-weight: bold;   
        }

                       .wrapsHeader, .paniniHeader, .quesadillaHeader, .saladHeader, .pizzaHeader
        {
            margin-top: 20px;
        }

        .burgerButton, .wrapsButton, .paniniButton, .quesadillaButton, .saladButton, .pizzaButton
        {
            border: none;
            outline:none;
            text-decoration: none;
            width: 100%;
            height: 100%;
            background-color: sandybrown;
            display: inline-block;
            text-align: center;
        }*/

        .HeaderButton
        {
            margin-top: 20px;
            border: none;
            outline: none;
            width: 100%;
            height: 100%;
            color: rgba(13,86,55, .9);
            background-color: sandybrown;
            font-weight: bold;   

            text-decoration: none;
            text-align: center;
            display: inline-block;
        }

        .navbar
        {
            margin-bottom: 0px;
        }

        .card-front-name
        {
            position: absolute;
            top: 0px;
            width: 100%;
            text-align: center;
            background-color: none;
            background-color: rgba(255, 255, 255, .5);
            display: block;
        }

        .card-front-price
        {
            position: absolute;
            bottom: 0px;
            width: 100%;
            text-align: center;
            background-color: none;
            background-color: rgba(255, 255, 255, .5);
            display: block;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="Scripts">
    <script type="text/javascript">
        $(document).ready(function () {
            $('div[AccordionControl]').first().show();
        });

        function AccordionTrigger(open)
        {
            var clickedElement = $('div[AccordionControl="' + open + '"]').first();

            $('div[AccordionControl]:visible').each(function (index) {
                $( this ).slideUp();
            });

            if (clickedElement.is(":visible"))
            {
                clickedElement.slideUp();
            }
            else
            {
                clickedElement.slideDown();

                setTimeout(function () {
                    $('body,html').animate({
                        scrollTop: clickedElement.offset().top - 100
                    });
                }, 410); // The slide animation's default duration is 400. Specifying 410 ensures the collapse animation is done by the time we scroll.
            }
        }
    </script>
</asp:Content>

<asp:Content ID="Content" runat="server" ContentPlaceHolderID="Content">
    <div class="container">
        <asp:SqlDataSource ID="SqlCategories" runat="server"
            ConnectionString="<%$ ConnectionStrings:SEI_DB_Connection.connectionString %>"
            ProviderName="<%$ ConnectionStrings:SEI_DB_Connection.providerName %>"
            SelectCommand="SELECT ft.food_type_name, ft.food_type_id_pk,
                                  CASE LOWER(ft.food_type_name)
                                       WHEN 'Desserts'                       THEN 1
                                       WHEN 'Create Your Own Pizza'          THEN 2
                                       WHEN 'Papa Johns Sides'               THEN 3
                                       WHEN 'Classic Pizzas'                 THEN 4
                                       WHEN 'Specialty Pizzas'               THEN 5
                                       ELSE 6
                                  END AS sort
                             FROM food_type ft
                            WHERE food_type_vendor = 'PJ'
                         ORDER BY sort">
        </asp:SqlDataSource>
        <asp:Repeater ID="rptCategories" runat="server" DataSourceID="SqlCategories">
            <ItemTemplate>
                <div class="row">
                    <div class="col-lg-12">
                        <div class="HeaderButton" onclick="AccordionTrigger('<%# Eval("food_type_name") %>');">
                            <asp:Literal     ID="litCategory"   runat="server" Text='<%# Eval("food_type_name") %>' />
                            <asp:HiddenField ID="hidFoodTypeID" runat="server" Value='<%# Eval("food_type_id_pk") %>' />
                        </div>
                    </div>
                </div>
                <div class="row" style="display:none;" AccordionControl="<%# Eval("food_type_name") %>">
                    <asp:SqlDataSource ID="sqlFood" runat="server"
                        ConnectionString="<%$ ConnectionStrings:SEI_DB_Connection.connectionString %>"
                        ProviderName="<%$ ConnectionStrings:SEI_DB_Connection.providerName %>"
                        SelectCommand="SELECT f.food_id_pk, f.food_name, f.food_descr, f.food_cost, f.is_deliverable, f.image_path
                                         FROM food f
                                        WHERE f.food_type_id_fk = :food_type_id_pk
                                     ORDER BY f.food_name">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="hidFoodTypeID" Name="food_type_id_pk" DefaultValue="-1" PropertyName="Value" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:Repeater ID="rptFood" runat="server" DataSourceID="sqlFood">
                        <ItemTemplate>
                            <div class="info-card col-xs-6 col-sm-4 col-md-3 col-lg-2">
                                <div class="front">
<%# string.IsNullOrEmpty(Eval("image_path").ToString()) ? "" : "                                    <img class=\"card-image\" src=\"Includes/images/Menu Items/" + Eval("image_path").ToString() +"\">" %>
                                    <asp:Label           ID="lblfrontfood_name"   runat="server" Text='<%# Eval("food_name") %>'      CssClass="card-front-name" />
                                    <asp:Label           ID="lblfrontprice"       runat="server" Text='<%# Eval("food_cost") %>'      CssClass="card-front-price" />
                                </div>
                                <div class="back">
                                    <asp:HiddenField     ID="hidFoodID"           runat="server" Value='<%# Eval("food_id_pk") %>' />
                                    <h3 class="text-center productName">
                                        <asp:Literal     ID="litfood_name"        runat="server" Text='<%# Eval("food_name") %>' />
                                    </h3>
<%--combo?--%>                      <div class="productInfo">
<%--combo?--%>                          <h4 class="text-left">
                                            <asp:Literal ID="litfood_description" runat="server" Text='<%# Eval("food_descr") %>' />
                                            <asp:Label   ID="lblprice"            runat="server" Text='<%# Eval("food_cost") %>'      CssClass="" />
                                            <asp:Label   ID="lbldeliverable"      runat="server" Text='<%# Eval("is_deliverable") %>' CssClass="" />
                                        </h4>
                                    </div>
                                    <div class="addToCartButton">
                                        <asp:Button      ID="btnAdd"              runat="server" Text="Add to cart" OnClick="btnAdd_Click" CssClass="btn btn-sm btn-danger text-center"/>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>

    <!-- Trigger the modal with a button -->
    <button type="button" class="btn btn-info btn-lg modalButton" data-toggle="modal" data-target="#myModal">Create Your Own</button>

    <!-- Modal -->
    <div id="myModal" class="modal fade text-center" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h3 class="modal-title">Create Your Own</h3>
                </div>

                <div class="modal-body">

                    <!-- Sizes -->
                    <h1>Select size:</h1>
                    <span class="sizeEightWrapper">
                        <button class="btn sizeEightButton">8"</button>
                    </span>
                    <span class="sizeSixteenWrapper">
                        <button class="btn sizeSixteenButton">16"</button>
                    </span>

                    <!-- Types -->
                    <!--<h1>Select type:</h1>
                    <span class="cheesePizzaWrapper">
                        <button class="btn cheesePizzaButton">Cheese</button>
                    </span>
                    <span class="sausagePizzaWrapper">
                        <button class="btn sausagePizzaButton">Sausage</button>
                    </span>
                    <span class="peperoniPizzaWrapper">
                        <button class="btn peperoniPizzaButton">Peperoni</button>
                    </span>-->

                    <!-- Toppings -->
                    <h1>Choose Your Toppings:</h1>

                    <h3>Real Meat</h3>
                    <span class="cheesePizzaWrapper">
                        <button class="btn baconToppingButton">Bacon</button>
                    </span>
                    <span class="peperoniPizzaWrapper">
                        <button class="btn peperoniToppingButton">Peperoni</button>
                    </span>
                    <span class="sausageToppingWrapper">
                        <button class="btn sausageToppingButton">Sausage</button>
                    </span>
                    <br />
                    <span class="beefToppingWrapper">
                        <button class="btn beefToppingButton">Beef</button>
                    </span>
                    <span class="italianSausageWrapper">
                        <button class="btn italianSausageToppingButton">Italian Sausage</button>
                    </span>
                    <span class="CanaDianBaconToppingWrapper">
                        <button class="btn canadianBacconToppingButton">Canadian Bacon</button>
                    </span>

                    <h3>Fresh Vegetables</h3>
                    <span class="freshSlicedOnions">
                        <button class="btn freshSlicedOnionsButton">Fresh-Sliced Onions</button>
                    </span>
                    <span class="greenPepper">
                        <button class="btn greenPepperButton">Green Pepper</button>
                    </span>
                    <span class="romaTomatoes">
                        <button class="btn romaTomatoesButton">Roma Tomatoes</button>
                    </span>
                    <span class="blackOlives">
                        <button class="btn blackOlivesButton">Black Olives</button>
                    </span>
                    <br />

                    <span class="jalapenoPeppers">
                        <button class="btn jalapenoPeppersButton">Jalapeno Peppers</button>
                    </span>

                    <span class="bananaPeppers">
                        <button class="btn bananaPeppersButton">Banana Peppers</button>
                    </span>

                    <span class="babyPortabella">
                        <button class="btn babyPortabellaButton">Baby Portabella</button>
                    </span>

                    <span class="mushrooms">
                        <button class="btn mushroomsButton">Mushrooms</button>
                    </span>

                    <div>
                        <button type="button" class="btn btn-danger">Add to Cart</button>
                 </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>