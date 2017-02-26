﻿<%@ Page Language="C#"
         AutoEventWireup="true"
         CodeFile="Choices.aspx.cs"
         Inherits="Choices"
         MasterPageFile="~/Master Pages/Default.Master" %>

<%@ MasterType VirtualPath="~/Master Pages/Default.Master" %>

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="Styles">
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="Scripts">
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
                    <div class="col-md-12">
                        <asp:Label       ID="lblCategory"   runat="server" Text='<%# Eval("food_type_name") %>' /> <%-- asp:Label's generate inside a span tag. asp:Literals do not. --%>
                        <asp:HiddenField ID="hidFoodTypeID" runat="server" Value='<%# Eval("food_type_id_pk") %>' />
                        <%--<div class="sandwichesHeader"><button class="sandwichButton">Sandwiches</button></div>--%>
                    </div>
                </div>
                <div class="row">
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
                    <asp:Repeater    ID="rptFood"       runat="server" DataSourceID="sqlFood">
                        <ItemTemplate>
                            <div class="col-xm-5 col-sm-4 col-md-3 col-lg-2 flip-containers">
                                <div class="flippers">
                                    <%-- front content --%>
                                    <div class="frontSide" style="background-image: url(<%# Eval("image_path") %>);">
                                        <%# Eval("food_name") %>
                                    </div>

                                    <%-- back content --%>
                                    <div class="backSide">
                                        <asp:Label       ID="lblfood_name"        runat="server" Text='<%# Eval("food_name") %>'      CssClass="f_name" />
                                        <asp:Label       ID="lblfood_description" runat="server" Text='<%# Eval("food_descr") %>'     CssClass="f_descr" />
                                        <asp:Label       ID="lblprice"            runat="server" Text='<%# Eval("food_cost") %>'      CssClass="f_cost" />
                                        <asp:Label       ID="lbldeliverable"      runat="server" Text='<%# Eval("is_deliverable") %>' CssClass="deliver" />
                                        <asp:HiddenField ID="hidFoodID"           runat="server" Value='<%# Eval("food_id_pk") %>' />
                                        <div class="order_button">
                                            <asp:Button  ID="btnAdd"              runat="server" Text="Add to cart!" OnClick="btnAdd_Click" CssClass="btnAdd"/>
                                        </div>
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