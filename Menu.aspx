<%@ Page Language="C#"
         Title="Menu | Palms Grille"
         AutoEventWireup="true"
         CodeFile="Menu.aspx.cs"
         Inherits="Menu"
         MasterPageFile="~/Master Pages/Default.Master" %><%-- Title changed in Page_Load --%>

<%@ MasterType VirtualPath="~/Master Pages/Default.Master" %>

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="Styles">
	<link rel="stylesheet" type="text/css" href=<%= "\"" + URL.root(Request) + "Includes/stylesheets/MenuStyles.css\"" %> />
	<link rel="stylesheet" type="text/css" href=<%= "\"" + URL.root(Request) + "Includes/stylesheets/CardStyles.css\"" %> />
	<link rel="stylesheet" type="text/css" href=<%= "\"" + URL.root(Request) + "Includes/stylesheets/DetailStyles.css\"" %> />
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="Scripts">
    <script type="text/javascript">
        var foodID;// global variable

        $(document).ready(function () {
            $('input[id*="hidFoodID"][value="' + <%= tabToReopen %> + '"]').parents('div[AccordionControl],div[AccordionControl2]').show();

        <%--if($('#<%= this.hidOrderType.ClientID %>').val() == "")
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
                $('input[chooseDetail]').on("click", normalPurchaseClick);
            }--%>

        <%--$('#modalOrderType').on("hidden.bs.modal", function ()
            {
                putOptionsOnModal();// needs global variable
                $('#modalFoodDetails').modal('show');
            });--%>

            // set checkbox click events
            $('.item-detail-list input[type="checkbox"]').each(function ()
            {
                var chb = $(this);
                var chbGroup = chb.siblings('input[id*="hidGroupName"]').val();

                // VVV uncheck between foods VVV
                chb.prop('checked', '');
                // ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

                if (chbGroup == "") // if this detail has no group
                {
                    // Be normal
                }
                else
                {
                    if (chbGroup.indexOf('X') != -1) // if this detail is an extra
                    {
                        // Be normal
                        var id_of_parent_detail = chbGroup.substr(0, chbGroup.indexOf('X'));
                        var chbParentchb = chb.parent().siblings().find('input[id*="hidDetailID"][value="' + id_of_parent_detail + '"]').first().siblings('input[type="checkbox"]');// the checkbox of the 'normal' relative to this extra

                        chb.parent().addClass('sub-detail');
                        if (!chbParentchb.prop('checked'))
                        {
                            chb.parent().hide();
                        }

                        chbParentchb.on('click', function ()
                        {
                            var id = $(this).siblings('input[id*="hidDetailID"]').val();
                            var divOfextra = $(this).parent().siblings().find('input[id*="hidGroupName"][value^="' + id + 'X"]').first().parent();

                            if ($(this).prop('checked'))
                            {
                                divOfextra.show();
                            }
                            else
                            {
                                divOfextra.hide();
                                divOfextra.children('input[type="checkbox"]').prop('checked', '');
                            }
                        });
                    }
                    else if (chb.parent().siblings().find('input[id*="hidGroupName"][value="' + chbGroup + '"]').toArray().length > 0) // if there are others (not counting himself) in the same group
                    {
                        chb.on('click', function ()
                        {
                            if (!$(this).prop('checked'))
                            {
                                $(this).prop('checked', 'checked')
                            }
                            $(this).parent().siblings().find('input[id*="hidGroupName"][value="' + chbGroup + '"]').siblings('input[type="checkbox"]').prop('checked', '');
                        });
                    }
                    else // if this is the only detail with that group
                    {
                        // Be normal
                    }
                }
            });
        });

        function normalPurchaseClick(button)<%--()--%>
        {
            // get the foodID from hidFoodID from <this> purchase button
            var purchaseButton = $(button);
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

                // re-hide extras
                DetailDiv.children('input[id*="hidGroupName"][value*="X"]').parent().hide();
                // remove all separators
                DetailDiv.removeClass("BorderAboveDetail");
                // uncheck all
                DetailDiv.find('input[type="checkbox"]').prop('checked', '');
            });
            $('#<%= this.hidChosenFoodId.ClientID %>').val(foodID);

            // add separator line between checkbox groups
            var currentDetail = "";
            $('.item-detail-list').children(':not(div[style*="display: none;"])').each(function (index)
            {
                var group = $(this).find('input[id*="hidGroupName"]').first().val();

                // VVV added this to check first of groups VVV
                if (!(group == null || group == "") && $(this).siblings(':not(div[style*="display: none;"])').find('input[id*="hidGroupName"][value*="' + group + '"]').toArray().length > 0)
                {
                    var detailsInGroup = $('.item-detail-list').find(':not(div[style*="display: none;"]) input[id*="hidGroupName"][value*="' + group + '"]');
                    var detailInGroupToCheck = detailsInGroup.first();

                    // try to find a detail in this group that has 'Whole' as its text (because that is the default price)
                    detailsInGroup.each(function ()
                    {
                        if ($(this).siblings('label').first().html() == "Whole" || $(this).siblings('label').first().html() == "16\"")
                        {
                            detailInGroupToCheck = $(this);
                        }
                    });

                    detailInGroupToCheck.siblings('input[type="checkbox"]').prop('checked', 'checked');
                }
                // ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

                $(this).removeClass("BorderAboveDetail");

                if (currentDetail == null || currentDetail == "")
                {
                    if ($(this).siblings(':not(div[style*="display: none;"])').find('input[id*="hidGroupName"][value*="' + group + '"]').toArray().length > 0)
                    {
                        currentDetail = group;
                        if (!(group == null || group == "") && index != 0)
                        {
                            $(this).addClass("BorderAboveDetail");
                        }
                    }
                }
                else if (currentDetail != group && group.indexOf("X") == -1)
                {
                    $(this).addClass("BorderAboveDetail");
                    currentDetail = group;
                }
            });

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

    <%--function ClickOrderTypeChosen(type)
        {
            $('#<%= this.hidOrderType.ClientID %>').val(type);
            $('#modalOrderType').modal('hide');
        }--%>

        // Toggle the state of a "Choose you own pizza" button where there are no possibilty to 
        // apply to only half a pizza
        function ToggleCYOP(button)
        {
            var btn = $(button);
            var customID = btn.attr("customID");
            var btnType = btn.attr("type");

            var idArray = $('#<%= this.hidPizzaBtnValues.ClientID %>').val().split(",")

            jQuery.each(idArray, function (index, element) {
                stringIndex = element.indexOf("+");
                if (stringIndex != -1)
                {
                    if ($("[customID=" + element.substr(0, stringIndex) + "]").attr("type") == btnType) {
                        idArray.splice(index, 1);
                        return false;
                    }
                }
                else
                {
                    if ($("[customID=" + element + "]").attr("type") == btnType) {
                        idArray.splice(index, 1);
                        return false;
                    }
                }
            });
            if (customID == "CYOP_01")
            {
                document.getElementById("pizzaPrice").innerHTML = "5.49"
            }
            else
            {
                document.getElementById("pizzaPrice").innerHTML = "11.99"

            }
           idArray.push(customID);
           $('#<%= this.hidPizzaBtnValues.ClientID %>').val(idArray.toString());

            //btn.attr("value", "true");
            btn.addClass("CYOP-Button-whole");

            // Toggle the value of the clicked button
            btn.siblings("span[type='" + btnType + "']").each(function ()
            {
                //$(this).attr("value", "false");
                $(this).removeClass("CYOP-Button-whole");
            });
        }
        
        // Toggle the state of a "Choose you own pizza" button where there are possibilities 
        // to toggle beween the detail being applied to the left, right, or all of the pizza
        var states = ["+none", "+whole", "+left", "+right"];
        function ToggleCYOPHalves(button)
        {
            var btn = $(button);
            var customID = btn.attr("customID");
            var IDString;
            var btnType = btn.attr("type");
            var stringIndex;
            var statesIndexText;
            var statesIndexNum = 1;

            var idArray = $('#<%= this.hidPizzaBtnValues.ClientID %>').val().split(",");

            jQuery.each(idArray, function (index, element)
            {
                stringIndex = element.indexOf("+");
                if (stringIndex != -1)
                {
                    if (element.substr(0, stringIndex) == customID)
                    {
                        statesIndexText = element.substr(stringIndex);
                        statesIndexNum = states.indexOf(statesIndexText);
                        statesIndexNum = (statesIndexNum + 1) % 4;
                        idArray.splice(index, 1);
                        return false;
                    }
                }                
            });

            if (statesIndexNum != 0)
            {
                IDString = customID + states[statesIndexNum];
                idArray.push(IDString);
            }
            $('#<%= this.hidPizzaBtnValues.ClientID %>').val(idArray.toString());

            if (button.getAttribute("name") != "Baby Portabella Mushrooms")
            {
                if (button.getAttribute("state") == "none") {
                    button.setAttribute("state", "whole");
                    button.setAttribute("value", "true");
                    button.textContent = button.getAttribute("name");
                    button.className = "btn CYOP-Button CYOP-Button-whole";
                }
                else if (button.getAttribute("state") == "whole") {
                    button.setAttribute("state", "left");
                    button.textContent = button.getAttribute("name") + " (left)";
                    button.className = "btn CYOP-Button CYOP-Button-left";

                }
                else if (button.getAttribute("state") == "left") {
                    button.setAttribute("state", "right");
                    button.textContent = button.getAttribute("name") + " (right)";
                    button.className = "btn CYOP-Button CYOP-Button-right";


                }
                else {
                    button.setAttribute("state", "none");
                    button.setAttribute("value", "false");
                    button.textContent = button.getAttribute("name");
                    button.className = "btn CYOP-Button";
                }
            }
            else
            {
                if (button.getAttribute("state") == "none") {
                    button.setAttribute("state", "whole");
                    button.setAttribute("value", "true");
                    button.innerHTML = "Baby Portabella<br />Mushrooms";
                    button.className = "btn CYOP-Button-Special CYOP-Button-whole";
                }
                else if (button.getAttribute("state") == "whole") {
                    button.setAttribute("state", "left");
                    button.innerHTML = "Baby Portabella<br />Mushrooms  (left)";
                    button.className = "btn CYOP-Button-Special CYOP-Button-left";

                }
                else if (button.getAttribute("state") == "left") {
                    button.setAttribute("state", "right");
                    button.innerHTML = "Baby Portabella<br />Mushrooms (right)";
                    button.className = "btn CYOP-Button-Special CYOP-Button-right";


                }
                else {
                    button.setAttribute("state", "none");
                    button.setAttribute("value", "false");
                    button.innerHTML = "Baby Portabella<br />Mushrooms";
                    button.className = "btn CYOP-Button-Special";
                }
            }
        }
    </script>
</asp:Content>

<asp:Content ID="Content" runat="server" ContentPlaceHolderID="Content">
    <div class="container">

    <!-- Modal -->
    <div id="modalCreateYourOwnPizza" class="modal fade text-center" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h3 class="modal-title">Create Your Own Pizza $<strong id ="pizzaPrice">11.99</strong></h3>
                </div>
                <div class="modal-body">
                    
                    <h1 class="CYOP-Header">Select size:</h1>
                    <asp:Label id="CYOP_01"  runat="server" customID="CYOP_01" type="size" class="btn CYOP-Button" onclick="ToggleCYOP(this)" value="true" >8''</asp:Label><span style="width:10px;">&nbsp;</span> 
                    <asp:Label id="CYOP_02"  runat="server" customID="CYOP_02" type="size" class="btn CYOP-Button CYOP-Button-whole" onclick="ToggleCYOP(this)" value="false"  >16''</asp:Label>            

                    <h1 class="CYOP-Header">Choose Your Crust:</h1>
                    <asp:Label id="CYOP_03"  runat="server" customID="CYOP_03" type="crust" class="btn CYOP-Button CYOP-Button-whole" onclick="ToggleCYOP(this)" value="true">Thin Crust</asp:Label><span style="width:10px;">&nbsp;</span>
                    <asp:Label id="CYOP_04"  runat="server" customID="CYOP_04" type="crust" class="btn CYOP-Button" onclick="ToggleCYOP(this)" value="false">Pan Crust</asp:Label><span style="width:10px;">&nbsp;</span>
                    <asp:Label id="CYOP_05"  runat="server" customID="CYOP_05" type="crust" class="btn CYOP-Button" onclick="ToggleCYOP(this)" value="false">Stuffed Crust +$1.00</asp:Label>
                    <asp:Label id="placeholder_1"  runat="server" customID="CYOP-placeholder" ></asp:Label>
                    <asp:Label id="placeholder_2"  runat="server" customID="CYOP-placeholder" ></asp:Label>

                    <h1 class ="CYOP-Header">Choose Your Sauce:</h1>
                    <asp:Label id="CYOP_18" runat="server" customID="CYOP_18" type="sauce" class="btn CYOP-Button CYOP-Button-whole" onclick="ToggleCYOP(this);" value="true"  state="none">Original</asp:Label>
                    <asp:Label id="CYOP_19" runat="server" customID="CYOP_19" type="sauce" class="btn CYOP-Button" onclick="ToggleCYOP(this);" value="false" state="none">Ranch</asp:Label>
                    <asp:Label id="CYOP_20" runat="server" customID="CYOP_20" type="sauce" class="btn CYOP-Button" onclick="ToggleCYOP(this);" value="false" state="none">BBQ</asp:Label>
                    <asp:Label id="CYOP_21" runat="server" customID="CYOP_21" type="sauce" class="btn CYOP-Button" onclick="ToggleCYOP(this);" value="false" state="none">Spinach Alfredo</asp:Label>

                    <h1 class="CYOP-Header">Choose Your Toppings:</h1>
                    <p id="instructions" style="color:rgba(13,86,55, .9); font-weight: bold;">Click a topping multiple times to apply to only one side of the pizza</p>
                    <h3>Real Meat</h3>
                    <asp:Label id="CYOP_06"  name="Bacon"            runat="server" customID="CYOP_06" class="btn CYOP-Button" onclick="ToggleCYOPHalves(this);" type="meat" value="false" state="none">Bacon</asp:Label>
                    <asp:Label id="CYOP_07"  name="Beef"             runat="server" customID="CYOP_07" class="btn CYOP-Button" onclick="ToggleCYOPHalves(this);" type="meat" value="false" state="none">Beef</asp:Label>
                    <asp:Label id="CYOP_08"  name="Canadian Bacon"   runat="server" customID="CYOP_08" class="btn CYOP-Button" onclick="ToggleCYOPHalves(this);" type="meat" value="false" state="none">Canadian Bacon</asp:Label>
                    <asp:Label id="CYOP_09"  name="Italian Sausage"  runat="server" customID="CYOP_09" class="btn CYOP-Button" onclick="ToggleCYOPHalves(this);" type="meat" value="false" state="none">Italian Sausage</asp:Label>
                    <asp:Label id="CYOP_10" name="Pepperoni"        runat="server" customID="CYOP_10" class="btn CYOP-Button" onclick="ToggleCYOPHalves(this);" type="meat" value="false" state="none">Pepperoni</asp:Label>

                    <div id="placeholder3" runat="server" class="CYOP-placeholder">&ensp;&ensp;&ensp;&ensp;&ensp;</div>
                    <h3 class="CYOP-Header3">Fresh vegetable</h3> 
                    <asp:Label name="Fresh Sliced Onions"   id="CYOP_11" runat="server" customID="CYOP_11" type="vegetable" class="btn CYOP-Button" onclick="ToggleCYOPHalves(this)" value="false" state="none">Fresh Sliced Onions</asp:Label>
                    <asp:Label name="Green Pepper"          id="CYOP_12" runat="server" customID="CYOP_12" type="vegetable" class="btn CYOP-Button" onclick="ToggleCYOPHalves(this)" value="false" state="none">Green Pepper</asp:Label>
                    <asp:Label name="Roma Tomatoes"         id="CYOP_13" runat="server" customID="CYOP_13" type="vegetable" class="btn CYOP-Button" onclick="ToggleCYOPHalves(this)" value="false" state="none">Roma Tomatoes</asp:Label>
                    <asp:Label name="Black Olives"          id="CYOP_14" runat="server" customID="CYOP_14" type="vegetable" class="btn CYOP-Button" onclick="ToggleCYOPHalves(this)" value="false" state="none">Black Olives</asp:Label>
                    <asp:Label name="Jalapeno Peppers"      id="CYOP_15" runat="server" customID="CYOP_15" type="vegetable" class="btn CYOP-Button" onclick="ToggleCYOPHalves(this)" value="false" state="none">Jalapeno Peppers</asp:Label>
                    <asp:Label name="Banana Peppers"        id="CYOP_16" runat="server" customID="CYOP_16" type="vegetable" class="btn CYOP-Button" onclick="ToggleCYOPHalves(this)" value="false" state="none">Banana Peppers</asp:Label>
                    <asp:Label name="Baby Portabella Mushrooms" style="font-size: 2.5vmin" id="CYOP_17" runat="server" customID="CYOP_17" type="vegetable" class="btn CYOP-Button" onclick="ToggleCYOPHalves(this)" value="false" state="none">Baby Portabella<br /> Mushrooms</asp:Label>
                    <br /> <br />
                    <div>
                        <asp:HiddenField ID="hidPizzaBtnValues" runat="server" value="CYOP_02,CYOP_03,CYOP_18" />
                        <asp:Button  ID="AddPizzaToCart" runat="server" class="btn btn-success btn-block" Text="Add to Cart" OnClick="AddPizzaToCart_Click" />
                    </div>
                </div>
              </div>
            </div>
        </div>

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
                        <div class="col-lg-10 col-md-10 col-sm-10 col-xs-10 col-lg-offset-1 col-md-offset-1 col-sm-offset-1 col-xs-offset-1 text-center" style="margin-bottom: 10px;">
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
                            <div class="info-card col-xs-4 col-sm-4 col-md-3 col-lg-3" style="margin-left: 115px">
                                <div class="front">
                                    <%# string.IsNullOrEmpty(Eval("image_path").ToString()) ? "" : "<img class=\"card-image\" src=\"Includes/images/Menu Items/" + Eval("image_path").ToString() +"\" />" %>
                                    <asp:Label           ID="lblfrontfood_name"   runat="server" Text='<%# Eval("food_name") %>' CssClass="card-front-name" />
                                    <asp:Label           ID="lblfrontprice"       runat="server" Text='<%# Eval("food_cost_1").ToString().Insert(Eval("food_cost_1").ToString().IndexOf("-") + 1,"$") %>' CssClass="card-front-price" />
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
                                        <asp:Label       ID="lblprice" runat="server" style="color: white;"                     Text='<%# Eval("food_cost_1").ToString().Insert(Eval("food_cost_1").ToString().IndexOf("-") + 1,"$") %>' />
                                        <input           id="Button2"  runat="server" class="btn btn-sm btn-danger text-center" value="View" type="button" onclick="normalPurchaseClick(this);" Descr='<%# Eval("food_descr") %>' chooseDetail='<%# ((HtmlInputButton)sender).NamingContainer.FindControl("hidFoodID").ClientID %>' />
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
        <div class="container create-your-own-container">
            <div class="row">
                <div class="col-lg-10 col-md-10 col-sm-10 col-xs-10 col-lg-offset-1 col-md-offset-1 col-sm-offset-1 col-xs-offset-1">
                    <button type="button" class="btn btn-info btn-lg modalButton" data-toggle="modal" data-target="#modalCreateYourOwnPizza">Create Your Own Pizza</button>
                </div>
            </div>   
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
                            <asp:Repeater    ID="rptDetailList" runat="server" ><%-- set DataSource in Page_Load --%>
                                <ItemTemplate>
                                    <asp:Panel ID="pnlDetail" runat="server" detail='<%# ((Panel)sender).FindControl("hidFoodIds").ClientID %>'>
                                        <asp:CheckBox    ID="chbChooseDetail" runat="server" Text='<%# Eval("detail_descr") %>' />
                                        <asp:Label       ID="lblDetailCost"   runat="server" Text='<%# Eval("detail_cost").ToString().Insert(Eval("detail_cost").ToString().IndexOf("-") + 1,"$") %>' Visible='<%# Eval("detail_cost").ToString() != "0" %>' />
                                        <asp:HiddenField ID="hidDetailID"     runat="server" Value='<%# Eval("detail_id_pk") %>' />
                                        <asp:HiddenField ID="hidGroupName"    runat="server" Value='<%# Eval("group_name") %>' />
                                        <asp:HiddenField ID="hidFoodIds"      runat="server" Value='<%# Eval("FoodIDs") %>' />
                                    </asp:Panel>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                        <br />
                        <div style="display:inline-block; padding-left:20px;">
                            <p id="modalDesc"> Description</p>
                        </div>
                    </div>
                    <asp:Button ID="btnAdd2" runat="server" Text="Add to cart" UseSubmitBehavior="false" OnClick="btnAdd_Click" CssClass="btn btn-sm btn-danger text-center"/>
                </div>
            </div>
        </div>
    </div>

<%--    <asp:HiddenField ID="hidOrderType" runat="server" Value="" />--%>

    <%-- Modal --%>
<%--    <div id="modalOrderType" class="modal fade text-center" role="dialog">
        <div class="modal-dialog">--%>
            <%-- Modal content--%>
<%--            <div class="modal-content">
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
    </div>--%>





</asp:Content>

