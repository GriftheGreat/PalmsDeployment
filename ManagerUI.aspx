<%@ Page Language="C#"
         AutoEventWireup="true"
         CodeFile="ManagerUI.aspx.cs"
         Inherits="ManagerUI"
         MasterPageFile="~/Master Pages/Manager.Master" %>

<asp:Content ID="Content" runat="server" ContentPlaceHolderID="Content">
    <div>
        <asp:GridView ID="FoodGrid" runat="server" ShowHeaderWhenEmpty="True"
            AutoGenerateColumns="False" OnRowDeleting="RowDeleting"
            OnRowCancelingEdit="cancelRecord" OnRowEditing="editRecord"
            OnRowUpdating="updateRecord" CellPadding="4"
            EnableModelValidation="True" GridLines="None" Width="1297px"
            ForeColor="#333333" BorderStyle="None">
            <RowStyle HorizontalAlign="Center" />
            <AlternatingRowStyle BackColor="White" />
            <EditRowStyle BackColor="#7C6F57" />
            <FooterStyle BackColor="#1C5E55" ForeColor="White" Font-Bold="True" />
            <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#E3EAEB" />
            <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />

            <Columns>

                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Label ID="lblId" Visible="false" runat="server" Text='<%# Eval("FOOD_ID_PK")%>' />
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField>
                    <HeaderTemplate>Name</HeaderTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblName" runat="server" Text='<%# Eval("FOOD_NAME") %>' />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtName" runat="server" Text='<%# Bind("FOOD_NAME") %>' MaxLength="50" />
                        <asp:RequiredFieldValidator ID="rfvtxtName" runat="server" Text="Invalid entry" ToolTip="Enter name" ControlToValidate="txtName" />
                        <asp:RegularExpressionValidator ID="revtxtName" runat="server" Text="Invalid entry" ToolTip="Enter letters " ControlToValidate="txtName" ValidationExpression="[a-zA-Z'.\s]{1,50}$" />
                    </EditItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="txtNewName" runat="server" MaxLength="50" />
                        <asp:RequiredFieldValidator ID="rfvtxtNewName" runat="server" Text="Invalid entry" ToolTip="Enter name" ControlToValidate="txtNewName" />
                        <asp:RegularExpressionValidator ID="revtxtNewName" runat="server" Text="Invalid entry" ToolTip="Enter letters " ControlToValidate="txtNewName" ValidationExpression="[a-zA-Z'.\s]{1,50}$" />
                    </FooterTemplate>
                </asp:TemplateField>

                <asp:TemplateField>
                    <HeaderTemplate>Food Type</HeaderTemplate>
                    <ItemTemplate>
                        <asp:DropDownList ID="foodTypeDDL" runat="server" DataSourceID="sqlFoodType" DataTextField="food_type_name" DataValueField="food_type_id_pk" SelectedValue='<%# Bind("food_type_id_fk") %>' />
                        <asp:SqlDataSource ID="sqlFoodType" runat="server"  ConnectionString="<%$ ConnectionStrings:SEI_DB_Connection.connectionString %>" ProviderName="<%$ ConnectionStrings:SEI_DB_Connection.providerName %>" SelectCommand="SELECT food_type_id_pk, food_type_name FROM food_type" />
                    </ItemTemplate>
                    <EditItemTemplate>
                         <asp:DropDownList ID="newFoodTypeDDL" runat="server" DataSourceID="newSqlFoodType" DataTextField="food_type_name" DataValueField="food_type_id_pk" SelectedValue='<%# Bind("food_type_id_fk") %>' />
                        <asp:SqlDataSource ID="newSqlFoodType" runat="server"  ConnectionString="<%$ ConnectionStrings:SEI_DB_Connection.connectionString %>" ProviderName="<%$ ConnectionStrings:SEI_DB_Connection.providerName %>" SelectCommand="SELECT food_type_id_pk, food_type_name FROM food_type" />
                    </EditItemTemplate>
                    <FooterTemplate>
                        <asp:DropDownList ID="insertFoodTypeDDL" runat="server" DataSourceID="insertSqlFoodType" DataTextField="food_type_name" DataValueField="food_type_id_pk" />
                        <asp:SqlDataSource ID="insertSqlFoodType" runat="server"  ConnectionString="<%$ ConnectionStrings:SEI_DB_Connection.connectionString %>" ProviderName="<%$ ConnectionStrings:SEI_DB_Connection.providerName %>" SelectCommand="SELECT food_type_id_pk, food_type_name FROM food_type" />
                    </FooterTemplate>
                </asp:TemplateField>

                <asp:TemplateField>
                    <HeaderTemplate>Description</HeaderTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblDescr" runat="server" Text='<%# Eval("FOOD_DESCR") %>' />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtDescr" runat="server" Text='<%# Bind("FOOD_DESCR") %>' MaxLength="150" Width="20em" TextMode="MultiLine" />
                        <asp:RequiredFieldValidator ID="rfvtxtDescr" runat="server" Text="Invalid entry" ToolTip="Enter Description" ControlToValidate="txtDescr" />
                    </EditItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="txtNewDescr" runat="server" MaxLength="150" ViewStateMode="Enabled" />
                        <asp:RequiredFieldValidator ID="rfvtxtNewDescr" runat="server" Text="Invalid entry" ToolTip="Enter food description" ControlToValidate="txtNewDescr" />
                    </FooterTemplate>
                </asp:TemplateField>

                <asp:TemplateField>
                    <HeaderTemplate>Cost</HeaderTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblCost" runat="server" Text='<%# Eval("FOOD_COST") %>' />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtCost" runat="server" Text='<%# Bind("FOOD_COST") %>' MaxLength="5" />
                        <asp:RequiredFieldValidator ID="rfvtxtCost" runat="server" Text="Invalid entry" ToolTip="Enter Cost" ControlToValidate="txtCost" />
                        <asp:RegularExpressionValidator ID="revtxtCost" runat="server" Text="Invalid entry" ToolTip="Enter numeric value" ControlToValidate="txtCost" ValidationExpression="^[0-9.]*$" />
                    </EditItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="txtNewCost" runat="server" MaxLength="5" />
                        <asp:RequiredFieldValidator ID="rfvtxtNewCost" runat="server" Text="Invalid entry" ToolTip="Enter Cost" ControlToValidate="txtNewCost" />
                        <asp:RegularExpressionValidator ID="revtxtNewCost" runat="server" Text="Invalid entry" ToolTip="Enter numeric value" ControlToValidate="txtNewCost" ValidationExpression="^[0-9.]*$" />
                    </FooterTemplate>
                </asp:TemplateField>

                <asp:TemplateField>
                    <HeaderTemplate>Deliverable</HeaderTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblIsDeliverable" runat="server" Text='<%# Eval("IS_DELIVERABLE") %>' />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtIsDeliverable" runat="server" Text='<%# Bind("IS_DELIVERABLE") %>' MaxLength="1" Width="1em" />
                        <asp:RequiredFieldValidator ID="rfvtxtIsDeliverable" runat="server" Text="Invalid entry" ToolTip="Indicate whether deliverable" ControlToValidate="txtIsDeliverable" />
                    </EditItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="txtNewIsDeliverable" runat="server" MaxLength="1" Width="1em" />
                        <asp:RequiredFieldValidator ID="rfvtxtNewIsDeliverable" runat="server" Text="Invalid entry" ToolTip="Indicate whether deliverable" ControlToValidate="txtNewIsDeliverable" />
                    </FooterTemplate>
                </asp:TemplateField>

                <asp:TemplateField>
                    <HeaderTemplate>Photo</HeaderTemplate>
                    <ItemTemplate>
                        <%# string.IsNullOrEmpty(Eval("image_path").ToString()) ? "" : "<img class=\"card-image\" src=\"Includes/images/Menu Items/" + Eval("image_path").ToString() +"\" />"  %>
                    </ItemTemplate>

                    <EditItemTemplate>
                        <asp:TextBox ID="Photo" runat="server" ToolTip="Select Photo" Text='<%# Eval("image_path") %>' Width="20em"/>
                        <asp:RegularExpressionValidator ID="revfuPhoto" runat="server" Text="Invalid Entry" ToolTip="Image formate only" ControlToValidate="Photo" ValidationExpression="[a-zA-Z0_9/].*\b(.jpeg|.JPEG|.jpg|.JPG|.jpe|.JPE|.png|.PNG)\b" />
                    </EditItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="NewPhoto" runat="server" ToolTip="select Photo" />
                        <asp:RegularExpressionValidator ID="revNewPhoto" runat="server" Text="Invalid Entry" ToolTip="Image formate only" ControlToValidate="NewPhoto" ValidationExpression="[a-zA-Z0_9/].*\b(.jpeg|.JPEG|.jpg|.JPG|.jpe|.JPE|.png|.PNG)\b" />
                    </FooterTemplate>
                </asp:TemplateField>

                <asp:TemplateField>
                    <HeaderTemplate>Operation</HeaderTemplate>
                    <ItemTemplate>
                        <asp:Button ID="btnEdit" runat="server" CommandName="Edit" Text="Edit" />
                        <asp:Button ID="btnDelete" runat="server" CommandName="Delete" Text="Delete" CausesValidation="true" OnClientClick="return confirm('Are you sure?')" />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:Button ID="btnUpdate" runat="server" CommandName="Update" Text="Update" />
                        <asp:Button ID="btnCancel" runat="server" CommandName="Cancel" Text="Cancel" CausesValidation="false" />
                    </EditItemTemplate>

                    <FooterTemplate>
                        <asp:Button ID="btnNewInsert" runat="server" Text="Insert" OnClick="InsertNewRecord" />
                        <asp:Button ID="btnNewCancel" runat="server" Text="Cancel" OnClick="AddNewCancel" CausesValidation="false" />
                    </FooterTemplate>
                </asp:TemplateField>
            </Columns>
            <EmptyDataTemplate>
                No record available
            </EmptyDataTemplate>
        </asp:GridView>
        <br />
        <asp:Button ID="btnAdd" runat="server" Text="Add New Record" OnClick="AddNewRecord" />
    </div>
</asp:Content>