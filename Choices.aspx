<%@ Page Language="C#"
         AutoEventWireup="true"
         CodeFile="Choices.aspx.cs"
         Inherits="Choices"
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
    </style>
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="Scripts">
    <script type="text/javascript">
        function AccordionTrigger(open)
        {
            var clickedElement = $('div[AccordionControl="' + open + '"]').first();

            $('div[AccordionControl][AccordionControl!="' + open + '"]:visible').each(function (index) {
                $( this ).slideUp();
            });

            if (clickedElement.is(":visible"))
            {
                $('div[AccordionControl="' + open + '"]').first().slideUp();
            }
            else
            {
                $('div[AccordionControl="' + open + '"]').first().slideDown();
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
                            ORDER BY sort">
        </asp:SqlDataSource>
        <asp:Repeater ID="rptCategories" runat="server" DataSourceID="SqlCategories">
            <ItemTemplate>
                <div class="row">
                    <div class="col-lg-12">
                        <div class="HeaderButton" onclick="AccordionTrigger('<%# Eval("food_type_name") %>');">
                            <asp:Literal     ID="litCategory"   runat="server" Text='<%# Eval("food_type_name") %>' />
<%-- asp:Label's generate inside a span tag. asp:Literals do not. --%>
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
                                    <%-- front info --%>
                                    <img class="card-image" src="<%# "Includes/images/Menu Items/" + Eval("image_path").ToString() %>">
                                    <%--<%# Eval("food_name") %>--%>
                                </div>
                                <div class="back">
                                    <%-- back info --%>
<%-- Look up styles to h3s and h4s and simplify --%>
                                    <asp:HiddenField     ID="hidFoodID"           runat="server" Value='<%# Eval("food_id_pk") %>' />
                                    <h3 class="text-center productName">
<%-- Literals do not have ASP CssClass property  duh :) --%>
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
</asp:Content>