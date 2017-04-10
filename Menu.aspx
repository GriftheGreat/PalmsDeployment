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
                $('body').one("click", 'input[chooseDetail]', function ()
                {
                    $('#modalOrderType').modal('show');
                    $('input[chooseDetail]').on("click", normalPurchaseClick);

                    var purchaseButton = $(this);
                    var hidFoodID = purchaseButton.attr("chooseDetail");
                    foodID = $('#' + hidFoodID).val();// assign global variable
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

                if ($('#' + hidFoodIds).val().includes(' ' + foodID + ' '))// use global variable
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
                                    <div class="productInfo">
                                        <h4 class="text-center">
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
                        </ItemTemplate>
                    </asp:Repeater>
                    <asp:PlaceHolder ID="plhBigCategoryEnd" runat="server" Visible="false">
                        </div>
                    </asp:PlaceHolder>
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
                    <input id="btnPickUp"   name="btnPickUp"   type="button" value="Pick-Up"      class="btn btn-danger" onclick="ClickOrderTypeChosen('Pick-Up');" />
                    <input id="Button1"     name="Button1"     type="button" value="Choose Later" class="btn btn-danger" onclick="ClickOrderTypeChosen('');" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>