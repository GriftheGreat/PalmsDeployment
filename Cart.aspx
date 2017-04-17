<%@ Page Language="C#"
         Title="Cart"
         AutoEventWireup="true"
         CodeFile="Cart.aspx.cs"
         Inherits="Cart"
         MasterPageFile="~/Master Pages/Default.Master" %>

<%@ MasterType VirtualPath="~/Master Pages/Default.Master" %>

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="Styles">
	<link rel="stylesheet" type="text/css" href=<%= "\"" + URL.root(Request) + "Includes/stylesheets/CartStyles.css\"" %> />
	<link rel="stylesheet" type="text/css" href=<%= "\"" + URL.root(Request) + "Includes/stylesheets/CardStyles.css\"" %> />
	<link rel="stylesheet" type="text/css" href=<%= "\"" + URL.root(Request) + "Includes/stylesheets/DetailStyles.css\"" %> />
    <%-- payment options --%>
    <style type="text/css">
        .payment-options-section
        {
            border-width: 1px 2px 2px 2px;
            border-style: solid;
            border-color: gray;
            padding: 20px 40px;
            width: 100%;
            text-align: left;
            display: inline-block;
        }

        .payment-options-section table
        {
            width: 100%;
        }

        .Error
        {
            color: rgb(200, 25, 25);
        }

        .bad-data
        {
            border: 2px solid rgb(200, 25, 25);
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="Scripts">
    <%-- checkbox clicks --%>
    <script type="text/javascript">
        $(document).ready(function ()
        {
            var currentDetail = ""; // have to clear currentDetail per each food in cart
            $('div.row').each(function ()
            {
                $(this).find('.item-detail-list input[type="checkbox"]').each(function ()
                {
                    var chb = $(this);
                    var chbGroup = chb.siblings('input[id*="hidGroupName"]').val();

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

                currentDetail = "";
                $(this).find('.item-detail-list').children(':not(div[style*="display: none;"])').each(function (index)
                {
                    var group = $(this).find('input[id*="hidGroupName"]').first().val();

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
            });

            // validate delivery location
            $('#<%= this.lnkGoPay.ClientID %>').on('click', function ()
            {
                var isValid = true;

                var txtLocationPlaceCheck  = /^[0-9]{3,4}$/;

                var ddlDeliveryType        = $('#<%= this.ddlDeliveryType.ClientID %>');
                var ddlLocations           = $('#<%= this.ddlLocations.ClientID %>');
                var locationPlaceContainer = $('#<%= this.locationPlaceContainer.ClientID %>');
                var txtLocationPlace       = $('#<%= this.txtLocationPlace.ClientID %>');
                var lblError               = $('#<%= this.lblError.ClientID %>');

                if (!(lblError.html().includes("cannot be delivered")) && ddlDeliveryType.val() != "") {
                    ddlDeliveryType.removeClass("bad-data");
                }
                else {
                    ddlDeliveryType.addClass("bad-data");
                    isValid = false;
                }

                if (ddlLocations.val() != "") {
                    ddlLocations.removeClass("bad-data");
                }
                else {
                    ddlLocations.addClass("bad-data");
                    isValid = false;
                }

                if (locationPlaceContainer.is(':visible'))
                {
                    if (txtLocationPlaceCheck.test(txtLocationPlace.val())) {
                        txtLocationPlace.removeClass("bad-data");
                    }
                    else {
                        txtLocationPlace.addClass("bad-data");
                        isValid = false;
                    }
                }
                return isValid;// false stops postback
            }
        });
    </script>
    <%-- Location picking --%>
    <script type="text/javascript">
        function pickLocation(ddl)
        {
            var ddl = $(ddl);

            if (ddl.val() != null && ddl.val() != '') {
                ddl.children().first().hide();
            }

            if (ddl.val() == 'DR' || ddl.val() == 'WA')
            {
                $('#<%= this.locationPlaceContainer.ClientID %>').show();
                $('#<%= this.txtLocationPlace.ClientID %>').val('');

                if (ddl.val() == 'DR')
                {
                    $('#<%= this.lbllocationPlace.ClientID %>').html('Room Number');
                }
                else
                {
                    $('#<%= this.lbllocationPlace.ClientID %>').html('Apartment Number');
                }
            }
            else
            {
                $('#<%= this.locationPlaceContainer.ClientID %>').hide();
            }
        }
    </script>
</asp:Content>

<asp:Content ID="Content" runat="server" ContentPlaceHolderID="Content">
    <div class="container">
        <asp:PlaceHolder ID="plhNoItemsInOrder" runat="server">
            <div class="row" style="text-align: center;">
                <div class="col-lg-12" style="margin-bottom: 20px; margin-top: 40px; color: red;">
                    There are no items in your cart right now.
                </div>
            </div>
        </asp:PlaceHolder>
        <asp:PlaceHolder ID="plhItemsAreInOrder" runat="server">
            <div class="row" style="text-align: center;">
                <div class="col-lg-12" style="margin-bottom: 35px; margin-top: 40px; ">
                    The Cart allows you to modify your food how you like. When you are done, click Pay at the bottom to proceed.
                </div>
                <div>
                    <asp:Label   ID="lblError"       runat="server" Text="" CssClass="Error" />
                </div>
                <div class="payment-options-section" style="border-width: 2px 2px 2px 2px; background-color: sandybrown;">
                    <table>
                        <tr>
                            <td>
                                Order Type:
                                <asp:DropDownList ID="ddlDeliveryType" runat="server" AutoPostBack="true" OnTextChanged="ddlDeliveryType_Click" >
                                    <asp:ListItem Text=""         Value="" />
                                    <asp:ListItem Text="Pick Up"  Value="PickUp" />
                                    <asp:ListItem Text="Delivery" Value="Delivery" />
                                </asp:DropDownList>
                            </td>
                            <td id="deliveryLocationContainer" runat="server">
                                Delivery Location:
                                <asp:DropDownList ID="ddlLocations"    runat="server" onchange="pickLocation(this);" >
                                    <asp:ListItem Text=""                    Value="" />
                                    <asp:ListItem Text="Palm's Grille"       Value="Palm's Grille" />
                                    <asp:ListItem Text="Campus House Lobby"  Value="Campus House Lobby" />
                                    <asp:ListItem Text="Sports Center"       Value="Sports Center" />
                                    <asp:ListItem Text="Residence Hall Room" Value="DR" />
                                    <asp:ListItem Text="Waveland Apartment"  Value="WA" />
                                </asp:DropDownList>
                            </td>
                            <td id="locationPlaceContainer" runat="server">
                                <span id="lbllocationPlace" runat="server"></span>
                                <asp:TextBox ID="txtLocationPlace"     runat="server" Width="3em" />
                            </td>
                            <td>
                                Total Price: <asp:Literal ID="litPrice" runat="server" />
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <asp:Repeater ID="rptItems" runat="server" OnItemDataBound="rptItems_ItemDataBound">
                <ItemTemplate>
                    <div class="row">
                        <div class="col-lg-12 cart-item">
                            <div class="front card-front <%# (MyOrder.Type == "Delivery" && Eval("Deliverable") != null && Eval("Deliverable").ToString() != "Y") ? "cannot-deliver" : "" %>">
                                <%# (Eval("ImagePath") != null && Eval("ImagePath").ToString() != "") ? "<img class=\"card-image\" src=\"" + URL.root(Request) + "Includes/images/Menu Items/" + Eval("ImagePath").ToString() +"\" />" : "" %>
                            </div>
                            <asp:Label         ID="litFoodName"    runat="server" Text='<%# Eval("Name").ToString() + ":" %>' CssClass="food-name" />
                        <!--<asp:Label         ID="lblfrontprice"  runat="server" Text='<%# Eval("Price").ToString().Insert(Eval("Price").ToString().IndexOf("-") + 1,"$") %>' />-->

                            <%# (Eval("Deliverable") != null &&  Eval("Deliverable").ToString() == "Y") ? "<img alt=\"deliverable\" src=\"" + URL.root(Request) + "Includes/images/delivery/inverted_delivery_icon.png\" style=\"float: right;\" title=\"Deliverable\" />" : "<img alt=\"deliverable\" src=\"" + URL.root(Request) + "Includes/images/delivery/inverted_non_delivery_icon.png\" style=\"float: right;\" title=\"Deliverable\" />" %>
                            <asp:Label         ID="lblDescription" runat="server" Text='<%# Eval("Description") %>' />
                            <asp:HiddenField   ID="hid1"           runat="server" Value='<%# Eval("Deliverable") %>' />
                            <br />
                            <div class="item-detail-list">
                                <asp:Repeater  ID="rptDetails"     runat="server">
                                    <ItemTemplate>
                                        <asp:Panel ID="pnlDetail" runat="server">
                                            <asp:CheckBox     ID="chbAdded"     runat="server" Text='<%# Eval("Description") %>' Checked='<%# Eval("Chosen") %>' />
                                            <asp:Label        ID="lblcost"      runat="server" Text='<%# Eval("Cost").ToString().Insert(Eval("Cost").ToString().IndexOf("-") + 1,"$") %>' Visible='<%# Eval("Cost").ToString() != "0" %>' />
                                            <asp:HiddenField  ID="hidGroupName" runat="server" Value='<%# Eval("GroupName") %>' />
                                            <asp:HiddenField  ID="hidDetailID"  runat="server" Value='<%# Eval("ID") %>' />
                                        </asp:Panel>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                            <asp:LinkButton    ID="lnkRemoveItem"  runat="server" Text="Remove" OnClick="lnkRemoveItem_Click" CssClass="remove-button" />
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
            <div class="row" style="text-align: center;">
                <asp:LinkButton ID="lnkGoPay"    runat="server" Text="Pay" OnClick="lnkGoPay_Click" CssClass="payment-submit-button" />
            </div>
        </asp:PlaceHolder>
    </div>
</asp:Content>