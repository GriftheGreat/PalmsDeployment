<%@ Page Language="C#"
         Title="Menu | Palms Grille"
         AutoEventWireup="true"
         CodeFile="Menu.aspx.cs"
         Inherits="Menu"
         MasterPageFile="~/Master Pages/Default.Master" %><%-- Title changed in Page_Load --%>

<%@ MasterType VirtualPath="~/Master Pages/Default.Master" %>

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="Styles">
    <style type="text/css">
        .spaceAroundCategories {
            margin-top: 50px;
        }

        .MealHeaderButton
        {
            padding: 10px 0px 10px 0px;
            border: none;
            border-bottom: solid;
            border-bottom-width: 1px;
            border-color: white;
            outline: none;
            width: 100%;
            height: 100%;
            /*color: rgba(13,86,55, .9);*/
            /*background-color: rgba(236,100,75, .9);*/
            color: darkgreen;
            background-color: rgba(242,120, 75, .9);
            font-weight: bold;   

            text-decoration: none;
            text-align: center;
            display: inline-block;
        }
        
        .HeaderButton
        {
            margin-top: 10px;
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

        .sub-detail
        {
            padding-left: 20px;
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

                    $('#modalDesc').text(purchaseButton.attr("descr"));
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

            $('span.CYOP-Button').on("click", function () {
                $(this).attr('value', 'true');
                alert($(this).html());
            });
        });

        function normalPurchaseClick()
        {
            // get the foodID from hidFoodID from <this> purchase button
            var purchaseButton = $(this);
            var hidFoodID = purchaseButton.attr("chooseDetail");
            foodID = $('#' + hidFoodID).val();// assign global variable

            $('#modalDesc').text(purchaseButton.attr("descr"));

            putOptionsOnModal();// needs global variable
            
            // show modal
            $('#modalFoodDetails').modal('show');
        }

        function putOptionsOnModal()
        {
            $('div[detail]').each(function ()
            {
                var DetailDiv = $(this);
                var hidFoodIds = DetailDiv.attr("detail");

                if ($('#' + hidFoodIds).val().indexOf(' ' + foodID + ' ') != -1) // use global variable
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
    <%-- checkbox clicks --%>
    <script type="text/javascript">
        $(document).ready(function ()
        {
            $('.item-detail-list input[type="checkbox"]').each(function ()
            {
                var chb = $(this);
                var chbGroup = chb.parent().attr('group');
                if (chbGroup == "") // if this detail has no group
                {
                    // Be normal
                }
                else
                {
                    if (chbGroup.indexOf('X')) // if this detail is an extra
                    {
                        // Be normal
                        chb.addClass('sub-detail');

                        var id_of_parent_detail = chbGroup.substr(0, chbGroup.indexOf('X'));
                        //chb.parent().parent().siblings().find('input[type="hidden"]').each(function ()
                        //{
                        //    if($(this).val() == id_of_parent_detail)
                        //    {
                        //        var chbParentchb = $(this).parent().find('input[type="checkbox"]');// the checkbox of the 'normal' relative to this extra
                        //    }
                        //});
                        var chbParentchb = chb.parent().parent().siblings().find('input[type="hidden"][value="' + id_of_parent_detail + '"]').first().parent().find('input[type="checkbox"]');// the checkbox of the 'normal' relative to this extra
                        
                        chbParentchb.on('click', function ()
                        {
                            var id = $(this).parent().siblings('input[type="hidden"]').val();
                            var divOfextra = $(this).parent().parent().siblings().find('span[group*="' + id + '"]').first().parent();
                            if (divOfextra.is(':visible'))
                            {
                                divOfextra.hide();
                            }
                            else
                            {
                                divOfextra.show();
                            }
                        });
                    }
                    else if (chb.parent().parent().siblings().find('span[group="'+chb.attr('group')+'"]').toArray().length > 1) // if there are others in the same group
                    {
                        chb.parent().parent().siblings().find('span[group="' + chb.attr('group') + '"] input[type="checkbox"]').prop('checked', '');
                        chb.prop('checked', 'checked');
                    }
                    else // if this is the only detail with that group
                    {
                        // Be normal
                    }
                }
                var radioName = $(this).attr('name');
                $(this).attr('name', radioName.substr(radioName.lastIndexOf('$') + 1));
            });
        });
    </script>
</asp:Content>

<asp:Content ID="Content" runat="server" ContentPlaceHolderID="Content">
    <div class="container">
        <div class="spaceAroundCategories"></div>
        <asp:Repeater ID="rptCategories" runat="server" OnItemDataBound="rptCategories_ItemDataBound" ><%-- set DataSource in Page_Load --%>
            <ItemTemplate>
                <asp:PlaceHolder ID="plhBigCategoryStart"  runat="server" Visible="false">
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
                <asp:PlaceHolder ID="plhBigCategoryEnd"    runat="server" Visible="false">
                    </div>
                </asp:PlaceHolder>
                <asp:PlaceHolder ID="plhNormalHeader"      runat="server" Visible="true">
                    <div class="row">
                        <div class="col-lg-10 col-md-10 col-sm-10 col-xs-10 col-lg-offset-1 col-md-offset-0.5col-sm-offset-1 col-xs-offset-1 text-center" style="margin-bottom: 10px;">
                            <div class="HeaderButton" onclick="AccordionTrigger('<%# Eval("food_type_name") %>');">
                </asp:PlaceHolder>
                <asp:PlaceHolder ID="plhBigHeader"         runat="server" Visible="false"><%-- This is for our beverages we want to show as a big category when it is not --%>
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="MealHeaderButton" onclick="AccordionTrigger('<%# Eval("food_type_name") %>');">
                </asp:PlaceHolder>
                                <asp:Literal     ID="litCategory"   runat="server" Text='<%# Eval("food_type_name") %>' />
                                <asp:HiddenField ID="hidFoodTypeID" runat="server" Value='<%# Eval("food_type_id_pk") %>' />
                            </div>
                        </div>
                    </div>
                <div class="row" style="display:none;" AccordionControl="<%# Eval("food_type_name") %>">
                    <asp:Repeater ID="rptFood" runat="server" ><%-- set DataSource in rptCategories_ItemDataBound --%>
                        <ItemTemplate>
                            <div class="info-card col-xs-4 col-sm-4 col-md-3 col-lg-3 col-xs-offset-1 col-sm-offset-1 col-md-offset-1 col-lg-offset-1">
                                <div class="front">
                                    <%# string.IsNullOrEmpty(Eval("image_path").ToString()) ? "" : "<img class=\"card-image\" src=\"Includes/images/Menu Items/" + Eval("image_path").ToString() +"\" />" %>
                                    <asp:Label           ID="lblfrontfood_name"   runat="server" Text='<%# Eval("food_name") %>' CssClass="card-front-name" />
                                    <asp:Label           ID="lblfrontprice"       runat="server" Text='<%# Eval("food_cost").ToString().Insert(Eval("food_cost").ToString().IndexOf("-") + 1,"$") %>' CssClass="card-front-price" />
                                </div>
                                <div class="back">
                                    <asp:HiddenField     ID="hidFoodID"           runat="server" Value='<%# Eval("food_id_pk") %>' />
                                    <h4 class="text-center productName"><strong>
                                        <asp:Literal     ID="litfood_name" runat="server" Text='<%# Eval("food_name") %>' />
                                    </strong></h4>
                                    <div class="productInfo">
                                        <h4 class="text-center">
                                            <asp:Label   ID="lblfood_description" runat="server"  Text='<%# Eval("food_descr").ToString().Substring(0,Math.Min(67,Eval("food_descr").ToString().Length)) + (Eval("food_descr").ToString().Length > 67 ? "..." : "") %>' />                                          
                                        </h4>
                                    </div>
                                    <div class="addToCartButton">
                                        <asp:Label       ID="lblprice" runat="server" style="color: white;"                     Text='<%# Eval("food_cost").ToString().Insert(Eval("food_cost").ToString().IndexOf("-") + 1,"$") %>' />
                                        <input           id="Button2"  runat="server" class="btn btn-sm btn-danger text-center" value="View" type="button" Descr='<%# Eval("food_descr") %>' chooseDetail='<%# ((HtmlInputButton)sender).NamingContainer.FindControl("hidFoodID").ClientID %>' />
                                        <%# (Eval("is_deliverable") != null &&  Eval("is_deliverable").ToString() == "Y") ? "<img alt=\"deliverable\" src=\"" + URL.root(Request) + "Includes/images/delivery/deliver icon 2.png\" style=\"float: button;\" title=\"Deliverable\" />" : "<img alt=\"deliverable\" src=\"" + URL.root(Request) + "Includes/images/delivery/non_delivery_icon.png\" style=\"float: bottom;\" title=\"Can't be delivered\" />" %>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </ItemTemplate>
        </asp:Repeater>
        <div class="spaceAroundCategories"></div>
    </div>

    <asp:PlaceHolder ID="plhCreateYourOwnPizza" runat="server"><%-- set Visible in Page_Load --%>
        <div class="create-your-own-container">
            <button type="button" class="btn btn-info btn-lg modalButton" data-toggle="modal" data-target="#modalCreateYourOwnPizza">Create Your Own Pizza</button>
        </div>
    </asp:PlaceHolder>

    <%-- Modal --%>
    <div id="modalFoodDetails" class="modal fade text-center" role="dialog">
        <div class="modal-dialog modalSizing">
            <%-- Modal content--%>
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h3 class="modal-title">Food Details</h3>
                </div>
                <div class="modal-body">
                    <asp:HiddenField ID="hidChosenFoodId"     runat="server" Value="" />
                    <div>
                        <div class="item-detail-list" style="display:inline-block">
                            <asp:Repeater    ID="rptDetailList" runat="server" OnItemDataBound="rptDetailList_ItemDataBound" ><%-- set DataSource in Page_Load --%>
                                <ItemTemplate>
<%-- need to be panel ID="pnlDetail" --%>                                    <div detail='<%# ((DataBoundLiteralControl)sender).FindControl("hidFoodIds").ClientID %>'>
<%-- need identifier on this element for jquery --%>                                        <asp:HiddenField ID="hidDetailID"     runat="server" Value='<%# Eval("detail_id_pk") %>' />
                                        <asp:CheckBox    ID="chbChooseDetail" runat="server" Text='<%# Eval("detail_descr") %>' group='<%# Eval("group_name") %>' />
                                        <asp:Label       ID="lblDetailCost"   runat="server" Text='<%# Eval("detail_cost").ToString().Insert(Eval("detail_cost").ToString().IndexOf("-") + 1,"$") %>' />
                                        <asp:HiddenField ID="hidGroupmName"   runat="server" Value='<%# Eval("group_name") %>' />
                                        <asp:HiddenField ID="hidFoodIds"      runat="server" Value='<%# Eval("FoodIDs") %>' />
                                    </div>
    <%-- if...group name... make radio button too.  (Use javascript to choose if only ONE with that group name corrosponds to chosen food use checkbox else use radio button).
        if group name = id + "X..." then use (detailID) id to make this detail a subdetail that shows when the corrosponding one is checked. --%>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                        <div style="display:inline-block; padding-left:20;">
                            <p id="modalDesc"> Description</p>
                        </div>
                    </div>
                    <asp:Button ID="btnAdd2" runat="server" Text="Add to cart" UseSubmitBehavior="false" OnClick="btnAdd_Click" CssClass="btn btn-sm btn-danger text-center"/>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal -->
    <div id="modalCreateYourOwnPizza" class="modal fade text-center" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h3 class="modal-title">Create Your Own Pizza $11.99</h3>
                </div>
                <div class="modal-body">
                    <h1>Select size:</h1>
                    <span id="CYOP_1"  runat="server" class="btn CYOP-Button CYOP-Button-focus" value="true" >8''  -$6.50</span><span style="width:10px;">&nbsp;</span>
                    <span id="CYOP_2"  runat="server" class="btn CYOP-Button" value=""     >16''</span>

                    <h1>Choose Your Crust:</h1>
                    <span id="CYOP_3"  runat="server" class="btn CYOP-Button CYOP-Button-focus" value="true" >Thin Crust</span><span style="width:10px;">&nbsp;</span>
                    <span id="CYOP_4"  runat="server" class="btn CYOP-Button" value=""     >Pan Crust</span><span style="width:10px;">&nbsp;</span>
                    <span id="CYOP_5"  runat="server" class="btn CYOP-Button" value=""     >Stuffed Crust $1.00</span>
                    <br />

                    <h1>Choose Your Toppings:</h1>
                    <h3>Real Meat</h3>
                    <%--<span id=""  runat="server" class="btn CYOP-Button CYOP-Button-focus" value="true" >Cheese</span><span style="width:10px;">&nbsp;</span>
                    <span id=""  runat="server" class="btn CYOP-Button" value=""     >Peperoni</span><span style="width:10px;">&nbsp;</span>
                    <span id=""  runat="server" class="btn CYOP-Button" value=""     >Sausage</span>
                    <br />--%>

                    <span id="CYOP_6"  runat="server" class="btn CYOP-Button" value=""     >Bacon</span>
                    <span id="CYOP_7"  runat="server" class="btn CYOP-Button" value=""     >Beef</span>
                    <span id="CYOP_8"  runat="server" class="btn CYOP-Button" value=""     >Canadian Bacon</span>
                    <span id="CYOP_9"  runat="server" class="btn CYOP-Button" value=""     >Italian Sausage</span>
                    <span id="CYOP_10" runat="server" class="btn CYOP-Button" value=""     >Pepperoni</span>

                    <h3>Fresh Vegetables</h3>
                    <span id="CYOP_11" runat="server" class="btn CYOP-Button" value=""     >Fresh Sliced Onions</span>
                    <span id="CYOP_12" runat="server" class="btn CYOP-Button" value=""     >Green Pepper</span>
                    <span id="CYOP_13" runat="server" class="btn CYOP-Button" value=""     >Roma Tomatoes</span>
                    <span id="CYOP_14" runat="server" class="btn CYOP-Button" value=""     >Black Olives</span>
                    <br />

                    <span id="CYOP_15" runat="server" class="btn CYOP-Button" value=""     >Jalapeno Peppers</span>
                    <span id="CYOP_16" runat="server" class="btn CYOP-Button" value=""     >Banana Peppers</span>
                    <span id="CYOP_17" runat="server" class="btn CYOP-Button" value=""     >Baby Portabella</span>
                    <span id="CYOP_18" runat="server" class="btn CYOP-Button" value=""     >Mushrooms</span>

                    <div>
                        <asp:Button ID="AddPizzaToCart" runat="server" class="btn btn-danger" Text="Add to Cart" OnClick="AddPizzaToCart_Click" />
                    </div>
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
                    <input id="btnPickUp"   name="btnPickUp"   type="button" value="Pick-Up"      class="btn btn-danger" onclick="ClickOrderTypeChosen('PickUp');" />
                    <input id="Button1"     name="Button1"     type="button" value="Choose Later" class="btn btn-danger" onclick="ClickOrderTypeChosen('');" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>