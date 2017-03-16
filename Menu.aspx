<%@ Page Language="C#"
         Title="Menu | Palms Grille"
         AutoEventWireup="true"
         CodeFile="Menu.aspx.cs"
         Inherits="Menu"
         MasterPageFile="~/Master Pages/Default.Master" %><%-- Title changed in Page_Load --%>

<%@ MasterType VirtualPath="~/Master Pages/Default.Master" %>

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="Styles">
    <style type="text/css">
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



        .item-detail-list
        {
            border: 1px solid rgb(128, 128, 128);
            width: 300px;
            height: 150px;
            overflow: auto;
            text-align: left;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="Scripts">
    <script type="text/javascript">
        $(document).ready(function () {
            $('div[AccordionControl]').first().show();

            if($('#<%= this.hidOrderType.ClientID %>').val() == "")
            {
                alert('1');
                $('body').one("click", 'input[mymodal="here"]', function ()
                {
                    $('#modalOrderType').modal('show');
                    $('input[mymodal="here"]').on("click", function ()
                    {
                        $('#modalFoodDetails').modal('show');
                    });
                });
            }
            else
            {
                alert('2');
                $('input[mymodal="here"]').on("click", function ()
                {
                    $('#modalFoodDetails').modal('show');
                });
            }

            $('#modalOrderType').on("hidden.bs.modal", function ()
            {
                $('#modalFoodDetails').modal('show');
            });
        });

        function ClickOrderTypeChosen(type)
        {
            $('#<%= this.hidOrderType.ClientID %>').val(type);
            $('#modalOrderType').modal('hide');
            //this    $('#modalFoodDetails').modal('show');    handled by    $('#modalOrderType').on("hidden.bs.modal", function ()
        }

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

        //function putOptionsOnModal()
        //{
        //    $('#modalFoodDetails').modal('show');
        //}
    </script>
</asp:Content>

<asp:Content ID="Content" runat="server" ContentPlaceHolderID="Content">
    <div class="container">
        <%--<asp:SqlDataSource ID="SqlCategories" runat="server"
            ConnectionString="<%$ ConnectionStrings:SEI_DB_Connection.connectionString %>"
            ProviderName="<%$ ConnectionStrings:SEI_DB_Connection.providerName %>"
            SelectCommand="SELECT ft.food_type_name, ft.food_type_id_pk,
                                  CASE LOWER(ft.food_type_name)
                                       WHEN 'breakfast sandwiches'           THEN 1
                                       WHEN 'breakfast sides'                THEN 2
                                       WHEN 'bakery'                         THEN 3
                                       WHEN 'appetizers'                     THEN 4
                                       WHEN 'burgers'                        THEN 5
                                       WHEN 'sandwiches'                     THEN 6
                                       WHEN 'paninis'                        THEN 7
                                       WHEN 'quesadillas'                    THEN 8
                                       WHEN 'wraps'                          THEN 9
                                       WHEN 'palms grille sides'             THEN 11
                                       WHEN 'soups ' || chr(38) || ' salads' THEN 12
                                       WHEN 'ice cream'                      THEN 11
                                       WHEN 'beverages'                      THEN 13
                                       ELSE 14
                                  END AS sort
                             FROM food_type ft
                            WHERE food_type_vendor = 'PG'
                         ORDER BY sort">
        </asp:SqlDataSource>--%>
        <asp:Repeater ID="rptCategories" runat="server" OnItemDataBound="rptCategories_ItemDataBound"><%-- set DataSource in Page_Load --%>
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
                    <asp:Repeater ID="rptFood" runat="server" ><%-- set DataSource in rptCategories_ItemDataBound --%>
                        <ItemTemplate>
                            <div class="info-card col-xs-6 col-sm-4 col-md-3 col-lg-2">
                                <div class="front">
                                    <%# string.IsNullOrEmpty(Eval("image_path").ToString()) ? "" : "<img class=\"card-image\" src=\"Includes/images/Menu Items/" + Eval("image_path").ToString() +"\" />" %>
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
                                        <asp:Button      ID="btnAdd"              runat="server" Text="Add to cart" UseSubmitBehavior="false" OnClick="btnAdd_Click" CssClass="btn btn-sm btn-danger text-center"/>
                                        <input           id="Button2"             runat="server" value="Purchase"   type="button"             class="btn btn-sm btn-danger text-center" mymodal="here"/>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>

    <asp:PlaceHolder ID="plhCreateYourOwnPizza" runat="server"><%-- set Visible in Page_Load --%>
        <%-- Trigger the modal with a button --%>
        <div class="create-your-own-container">
            <button type="button" class="btn btn-info btn-lg modalButton" data-toggle="modal" data-target="#modalFoodDetails">Create Your Own</button>
        </div>
    </asp:PlaceHolder>

    <%-- Modal --%>
    <div id="modalFoodDetails" class="modal fade text-center" role="dialog">
        <div class="modal-dialog">
            <%-- Modal content--%>
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h3 class="modal-title">Create Your Own</h3>
                </div>
                <div class="modal-body">
                    <%--<!-- Sizes -->
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
                    </span>--%>

                    <asp:HiddenField ID="hidChosenFoodId"     runat="server" Value="" />

                    <div class="item-detail-list">
                        <asp:Repeater    ID="rptDetailList" runat="server" ><%-- set DataSource in Page_Load --%>
                            <ItemTemplate>
                                <asp:HiddenField ID="hidDetailID"     runat="server" Value='<%# Eval("detail_id_pk") %>' />
                                <asp:CheckBox    ID="chbChooseDetail" runat="server" Text='<%# Eval("detail_descr") %>' Checked="false" />
                                <asp:Label       ID="lblDetailCost"   runat="server" Text='<%# Eval("detail_cost").ToString().Insert(Eval("detail_cost").ToString().IndexOf("-") + 1,"$") %>' />
                                <asp:HiddenField ID="hidGroupmName"   runat="server" Value='<%# Eval("group_name") %>' /><br />
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                    <asp:Button ID="btnAdd2" runat="server" Text="Add to cart" UseSubmitBehavior="false" OnClick="btnAdd_Click" CssClass="btn btn-sm btn-danger text-center"/>
                </div>
            </div>
        </div>
    </div>

    <asp:HiddenField ID="hidOrderType" runat="server" Value="" />

    <%-- Modal --%>
    <div id="modalOrderType" class="modal fade text-center" role="dialog">
        <div class="modal-dialog">
            <%-- Modal content--%>
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h3 class="modal-title">Delivery or Pick-Up?</h3>
                </div>
                <div class="modal-body">
                    <input id="btnDelivery" name="btnDelivery" type="button" value="Delivery"     class="btn btn-danger" onclick="ClickOrderTypeChosen('Delivery');" />
                    <input id="btnPickUp"   name="btnPickUp"   type="button" value="Pick-Up"      class="btn btn-danger" onclick="ClickOrderTypeChosen('Pick-Up');" />
                    <input id="Button1"     name="Button1"     type="button" value="Choose Later" class="btn btn-danger" onclick="ClickOrderTypeChosen('');" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>