<%@ Page Language="C#"
         Title="Menu | Palms Grille"
         AutoEventWireup="true"
         CodeFile="Menu.aspx.cs"
         Inherits="Menu"
         MasterPageFile="~/Master Pages/Default.Master" %><%-- Title changed in Page_Load --%>

<%@ MasterType VirtualPath="~/Master Pages/Default.Master" %>

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="Styles">
    <style type="text/css">
        .MealHeaderButton
        {
            margin-top: 30px;
            border: outset;
            outline: none;
            width: 100%;
            height: 100%;
            color: sandybrown;
            background-color: darkred;
            font-weight: bold;   

            text-decoration: none;
            text-align: center;
            display: inline-block;
        }
        
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
        var foodID;// global variable

        $(document).ready(function () {
            $('div[AccordionControl]').first().show();

            if($('#<%= this.hidOrderType.ClientID %>').val() == "")
            {
                //alert('1');
                $('body').one("click", 'input[chooseDetail]', function ()
                {
                    $('#modalOrderType').modal('show');
                    $('input[chooseDetail]').on("click", normalPurchaseClick);

                    var purchaseButton = $(this);
                    var hidFoodID = purchaseButton.attr("chooseDetail");
                    foodID = $('#' + hidFoodID).val();// assign global variable
<%--=======
        function AccordionTrigger(open)
        {            
            var mealTabClicked = false;
            var clickedElements = []

            $('div[AccordionControl="' + open + '"]').each(function (index) {
                clickedElements.push($(this)); // Some food types are appear twice, once
                                               // under Breakfast and once in Lunch & Dinner
                                               // i.e. the Beverages food type
            });

            if (open == "Breakfast" || open == "Lunch & Dinner")
            {
                mealTabClicked = true;
            }

            // Collapse the correct category of tabs
            if (mealTabClicked == true)
            {
                $('div[AccordionControl][AccordionControl!="' + open + '"]:visible[AccordionControl="Breakfast"],[AccordionControl="Lunch & Dinner"]').each(function (index) {
                    $(this).slideUp();
>>>>>>> Judah--%>
                });
            }
            else
            {
                //alert('2');
                $('input[chooseDetail]').on("click", normalPurchaseClick);
            }

            $('#modalOrderType').on("hidden.bs.modal", function ()
            {
                putOptionsOnModal();// needs global variable
                $('#modalFoodDetails').modal('show');
            });
        });

        function normalPurchaseClick()
        {
            // get the foodID from hidFoodID from <this> purchase button
            var purchaseButton = $(this);
            var hidFoodID = purchaseButton.attr("chooseDetail");
            foodID = $('#' + hidFoodID).val();// assign global variable

            putOptionsOnModal();// needs global variable
            
            // show modal
            $('#modalFoodDetails').modal('show');
        }

        function putOptionsOnModal() {
            $('div[detail]').each(function () {
                var DetailDiv = $(this);
                var hidFoodIds = DetailDiv.attr("detail");

                //if ($('#' + hidFoodIds).val().includes(' ' + foodID + ' ')) || ($.inArray("#" + foodID, $('#' + hidFoodIds).val()) != -1)
                if ($('#' + hidFoodIds).val().indexOf(foodID) != -1) // use global variable
                {
                    DetailDiv.show();
                }
                else
                {
                    DetailDiv.hide();
                }

                DetailDiv.children()[1].checked = false;
            });
            $('#<%= this.hidChosenFoodId.ClientID %>').val(foodID);

            foodID = null;// clear global variable
        }

        function AccordionTrigger2(open)
        {
            var clickedElement = $('div[AccordionControl2="' + open + '"]').first();

            window.alert($('div[AccordionControl2="' + open + '"]').first());

            $('div[AccordionControl2]:visible').each(function (index) {
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

        function ClickOrderTypeChosen(type)
        {
            $('#<%= this.hidOrderType.ClientID %>').val(type);
            $('#modalOrderType').modal('hide');
            //$('#modalFoodDetails').modal('show');  REMOVED because this is handled by   $('#modalOrderType').on("hidden.bs.modal", function ()
<%--=======
                $('div[AccordionControl][AccordionControl!="' + open + '"]:visible[AccordionControl!="Breakfast"][AccordionControl!="Lunch & Dinner"]').each(function (index) {
                    $(this).slideUp();
                });
            }
            
            // Toggle whether the clicke tab is open or closed
            for (var instance = 1; instance <= clickedElements.length; instance++)
            {
                if (instance == 1)
                {
                    if (clickedElements[instance-1].is(":visible")) {
                        $('div[AccordionControl="' + open + '"]').first().slideUp();
                    }
                    else {
                        $('div[AccordionControl="' + open + '"]').first().slideDown();
                    }
                }
                else
                {
                    if (clickedElements[instance - 1].is(":visible")) {
                        $('div[AccordionControl="' + open + '"]').last().slideUp();
                    }
                    else {
                        $('div[AccordionControl="' + open + '"]').last().slideDown();
                    }
                }
            }
>>>>>>> Judah--%>
        }
    </script>
</asp:Content>

<asp:Content ID="Content" runat="server" ContentPlaceHolderID="Content">
    <div class="container">
        <asp:Repeater ID="rptCategories" runat="server" OnItemDataBound="rptCategories_ItemDataBound" ><%-- set DataSource in Page_Load --%>
            <ItemTemplate>
                <asp:PlaceHolder ID="plhBigCategoryStart" runat="server" Visible="false">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="MealHeaderButton" onclick="AccordionTrigger2('<%# Eval("food_type_meal").ToString() == "B" ? "Breakfast" : Eval("food_type_meal").ToString() == "L" ? "Lunch & Dinner" : "" %>');">
                                <asp:Literal     ID="lblMealName1"     runat="server" Text='<%# Eval("food_type_meal").ToString() == "B" ? "Breakfast" : Eval("food_type_meal").ToString() == "L" ? "Lunch & Dinner" : "" %>'/>
                            </div>
                        </div>
                    </div>

                    <div class="row" style="display:none;" AccordionControl2='<%# Eval("food_type_meal").ToString() == "B" ? "Breakfast" : Eval("food_type_meal").ToString() == "L" ? "Lunch & Dinner" : "" %>'>
                </asp:PlaceHolder>
                <asp:PlaceHolder ID="plhBigCategoryMiddle" runat="server" Visible="false">
                    </div>

                    <div class="row">
                        <div class="col-lg-12">
                            <div class="MealHeaderButton" onclick="AccordionTrigger2('<%# Eval("food_type_meal").ToString() == "B" ? "Breakfast" : Eval("food_type_meal").ToString() == "L" ? "Lunch & Dinner" : "" %>');">
                                <asp:Literal     ID="lblMealName2"     runat="server" Text='<%# Eval("food_type_meal").ToString() == "B" ? "Breakfast" : Eval("food_type_meal").ToString() == "L" ? "Lunch & Dinner" : "" %>'/>
                            </div>
                        </div>
                    </div>

                    <div class="row" style="display:none;" AccordionControl2='<%# Eval("food_type_meal").ToString() == "B" ? "Breakfast" : Eval("food_type_meal").ToString() == "L" ? "Lunch & Dinner" : "" %>'>
                </asp:PlaceHolder>
                <asp:PlaceHolder ID="plhBigCategoryEnd" runat="server" Visible="false">
                    </div>
                </asp:PlaceHolder>
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
                                    <asp:Label           ID="lblfrontfood_name"   runat="server" Text='<%# Eval("food_name") %>' CssClass="card-front-name" />
                                    <asp:Label           ID="lblfrontprice"       runat="server" Text='<%# Eval("food_cost").ToString().Insert(Eval("food_cost").ToString().IndexOf("-") + 1,"$") %>' CssClass="card-front-price" />
                                </div>
                                <div class="back">
                                    <asp:HiddenField     ID="hidFoodID"           runat="server" Value='<%# Eval("food_id_pk") %>' />
                                    <h3 class="text-center productName">
                                        <asp:Literal     ID="litfood_name"        runat="server" Text='<%# Eval("food_name") %>' />
                                    </h3>
<%--combo?--%>                      <div class="productInfo">
<%--combo?--%>                          <h4 class="text-center">
                                            <asp:Literal ID="litfood_description" runat="server" Text='<%# Eval("food_descr") %>' />
                                            <asp:Label   ID="lblprice"            runat="server" Text='<%# Eval("food_cost").ToString().Insert(Eval("food_cost").ToString().IndexOf("-") + 1,"$") %>' />
                                            <%# (Eval("is_deliverable") != null &&  Eval("is_deliverable").ToString() == "Y") ? "<img alt=\"deliverable\" src=\"" + URL.root(Request) + "Includes/images/delivery/deliver icon 2.png\" style=\"float: right;\" title=\"Deliverable\" />" : "" %>
                                        </h4>
                                    </div>
                                    <div class="addToCartButton">
                                        <input           id="Button2"             runat="server" value="View" type="button"      class="btn btn-sm btn-danger text-center" chooseDetail='<%# ((HtmlInputButton)sender).NamingContainer.FindControl("hidFoodID").ClientID %>'/>
                                    </div>
                                </div>
                            </div>
<%--=======
    <asp:SqlDataSource ID='SqlCategoriesBreakFast' runat="server"
                        ConnectionString="<%$ ConnectionStrings:SEI_DB_Connection.connectionString %>"
                        ProviderName="<%$ ConnectionStrings:SEI_DB_Connection.providerName %>"
                        SelectCommand="SELECT ft.food_type_meal,
                                              CASE
                                                  WHEN ft.food_type_meal = 'B' THEN 'Breakfast'
                                                  WHEN ft.food_type_meal = 'A' THEN 'Beverages'
                                                  WHEN ft.food_type_meal = 'L' THEN 'Lunch ' || chr(38) || ' Dinner'
                                                  ELSE 18
                                              END AS bigCategoryName
                                          FROM food_type ft
                                          WHERE ft.food_type_vendor = 'PG'
                                        ORDER BY sort">   
    </asp:SqlDataSource>
    <asp:SqlDataSource ID='SqlCategoriesLunch' runat="server"
                        ConnectionString="<%$ ConnectionStrings:SEI_DB_Connection.connectionString %>"
                        ProviderName="<%$ ConnectionStrings:SEI_DB_Connection.providerName %>"
                        SelectCommand="SELECT ft.food_type_name, ft.food_type_id_pk, ft.food_type_meal,
                                                CASE LOWER(ft.food_type_name)
                                                    WHEN 'breakfast sandwiches'           THEN 1
                                                    WHEN 'breakfast sides'                THEN 2
                                                    WHEN 'bakery'                         THEN 3
                                                    WHEN 'beverages'                      THEN 4
                                                    WHEN 'burgers'                        THEN 5
                                                    WHEN 'sides'                          THEN 6
                                                    WHEN 'soups ' || chr(38) || ' salads' THEN 7
                                                    WHEN 'sandwiches'                     THEN 8
                                                    WHEN 'paninis'                        THEN 9
                                                    WHEN 'quesadillas'                    THEN 10
                                                    WHEN 'wraps'                          THEN 12
                                                    WHEN 'appetizers'                     THEN 13
                                                    WHEN 'ice cream'                      THEN 14
                                                    WHEN 'pizza'                          THEN 15
                                                    WHEN 'sides'                          THEN 16
                                                    WHEN 'desserts'                       THEN 17
                                                    ELSE 18
                                                END AS sort
                                            FROM food_type ft
                                            WHERE food_type_meal = 'L'
                                            OR food_type_meal = 'A'
                                        ORDER BY sort">   
    </asp:SqlDataSource>
    <div class="container">
        <asp:Repeater ID="rptMeals" runat="server">
            <ItemTemplate>
                <div class="row">
                    <div class="col-lg-12">
                        <div class="MealHeaderButton" onclick="AccordionTrigger('<%#meals[meal_index]%>');">
                            <asp:Literal ID="litCategory1" runat="server" Text='<%#meals[meal_index] %>'/>
                            <asp:HiddenField ID="hidMealID" runat="server" Value='<%#meals[meal_index] %>'/>
                        </div>
                    </div>
                </div>

                <div class="row" style="display:none;" AccordionControl='<%#meals[meal_index] %>'>

                    <asp:Repeater ID="rptCategories" runat="server" DataSourceID='<%#"SqlCategories" + (meal_index++ == 0 ? "BreakFast" : "Lunch")%>'>
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
                                                <img class="card-image" src="<%# "Includes/images/Menu Items/" + Eval("image_path").ToString() %>">
                                            </div>
                                            <div class="back">
                                                <asp:HiddenField     ID="hidFoodID"           runat="server" Value='<%# Eval("food_id_pk") %>' />
                                                <h3 class="text-center productName">
                                                    <asp:Literal     ID="litfood_name"        runat="server" Text='<%# Eval("food_name") %>' />
                                                </h3>
                                  <div class="productInfo">
                                      <h4 class="text-left">
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
>>>>>>> Judah--%>
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
    <div id="modalFoodDetails" class="modal fade text-center modal-responsive" role="dialog">
        <div class="modal-dialog">
            <%-- Modal content--%>
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h3 class="modal-title">Food Details</h3>
                </div>
                <div class="modal-body">
                    <asp:HiddenField ID="hidChosenFoodId"     runat="server" Value="" />

                    <div class="item-detail-list">
                        <asp:Repeater    ID="rptDetailList" runat="server" ><%-- set DataSource in Page_Load --%>
                            <ItemTemplate>
                                <div detail='<%# ((DataBoundLiteralControl)sender).FindControl("hidFoodIds").ClientID %>'>
                                    <asp:HiddenField ID="hidDetailID"     runat="server" Value='<%# Eval("detail_id_pk") %>' />
                                    <asp:CheckBox    ID="chbChooseDetail" runat="server" Text='<%# Eval("detail_descr") %>' />
                                    <asp:Label       ID="lblDetailCost"   runat="server" Text='<%# Eval("detail_cost").ToString().Insert(Eval("detail_cost").ToString().IndexOf("-") + 1,"$") %>' />
<asp:Label   ID="lbl1"                runat="server" Text='<%# Eval("group_name") %>' />
                                    <asp:HiddenField ID="hidGroupmName"   runat="server" Value='<%# Eval("group_name") %>' />
                                    <asp:HiddenField ID="hidFoodIds"      runat="server" Value='<%# Eval("FoodIDs") %>' />
                                </div>
<%-- if...group name... make radio button too.  (Use javascript to choose if only ONE with that group name corrosponds to chosen food use checkbox else use radio button).
    if group name = id + "X..." then use (detailID) id to make this detail a subdetail that shows when the corrosponding one is checked. --%>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                    <asp:Button ID="btnAdd2" runat="server" Text="Add to cart" UseSubmitBehavior="false" OnClick="btnAdd_Click" CssClass="btn btn-sm btn-danger text-center"/>
                </div>
            </div>
        </div>
    </div>

<%-- Make a modal out of Pizza.aspx and put it here as modalFoodDetails2 --%>

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
                    <input id="btnPickUp"   name="btnPickUp"   type="button" value="Pick-Up"      class="btn btn-danger" onclick="ClickOrderTypeChosen('PickUp');" />
                    <input id="Button1"     name="Button1"     type="button" value="Choose Later" class="btn btn-danger" onclick="ClickOrderTypeChosen('');" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>