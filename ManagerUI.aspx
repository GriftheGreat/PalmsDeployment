<%@ Page Language="C#"
         AutoEventWireup="true"
         CodeFile="ManagerUI.aspx.cs"
         Inherits="ManagerUI"
         MasterPageFile="~/Master Pages/Manager.Master" %>

<asp:Content ID="Content" runat="server" ContentPlaceHolderID="Content">
    <div>
        <asp:GridView ID="GridView1" runat="server" ShowHeaderWhenEmpty="True"
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
            <PagerStyle backcolor="#666666" forecolor="White" horizontalalign="Center" />
            <RowStyle BackColor="#E3EAEB" />
            <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />

            <Columns>

                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Label ID="lblId" Visible="false" runat="server" Text='<%#Bind("FOOD_ID_PK")%>' />
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField>
                    <HeaderTemplate>Name</HeaderTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblName" runat="server" Text='<%#Bind("FOOD_NAME") %>' />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtName" runat="server" Text='<%#Bind("FOOD_NAME") %>' MaxLength="50" />
                        <asp:RequiredFieldValidator ID="rfvtxtName" runat="server" Text="*" ToolTip="Enter name" ControlToValidate="txtName" />
                        <asp:RegularExpressionValidator ID="revtxtName" runat="server" Text="*" ToolTip="Enter letters " ControlToValidate="txtName" ValidationExpression="^[a-zA-Z'.\s]{1,40}$" />

                    </EditItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="txtNewName" runat="server" MaxLength="50" />
                        <asp:RequiredFieldValidator ID="rfvtxtNewName" runat="server" Text="*" ToolTip="Enter name" ControlToValidate="txtNewName" />
                        <asp:RegularExpressionValidator ID="revtxtNewName" runat="server" Text="*" ToolTip="Enter letters " ControlToValidate="txtNewName" ValidationExpression="^[a-zA-Z'.\s]{1,40}$" />

                    </FooterTemplate>
                </asp:TemplateField>

                <asp:TemplateField>
                    <HeaderTemplate>Description</HeaderTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblDescr" runat="server" Text='<%#Bind("FOOD_DESCR") %>' />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtDescr" runat="server" Text='<%#Bind("FOOD_DESCR") %>' MaxLength="150" />
                        <asp:RequiredFieldValidator ID="rfvtxtDescr" runat="server" Text="*" ToolTip="Enter Description" ControlToValidate="txtDescr" />
                        <asp:RegularExpressionValidator ID="revtxtDescr" runat="server" Text="*" ToolTip="Enter food description" ControlToValidate="txtDescr" ValidationExpression="^[0-9]+$" />

                    </EditItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="txtNewDescr" runat="server" MaxLength="150" />
                        <asp:RequiredFieldValidator ID="rfvtxtNewDescr" runat="server" Text="*" ToolTip="Enter food description" ControlToValidate="txtNewDescr" />
                        <asp:RegularExpressionValidator ID="revNewtxtDescr" runat="server" Text="*" ToolTip="Enter food description" ControlToValidate="txtNewDescr" ValidationExpression="^[0-9]+$" />
                    </FooterTemplate>
                </asp:TemplateField>

                <asp:TemplateField>
                    <HeaderTemplate>Cost</HeaderTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblCost" runat="server" Text='<%#Bind("FOOD_COST") %>' />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtCost" runat="server" Text='<%#Bind("FOOD_COST") %>' MaxLength="5" />
                        <asp:RequiredFieldValidator ID="rfvtxtCost" runat="server" Text="*" ToolTip="Enter Cost" ControlToValidate="txtCost" />
                        <asp:RegularExpressionValidator ID="revtxtCost" runat="server" Text="*" ToolTip="Enter numeric value" ControlToValidate="txtCost" ValidationExpression="^[0-9]+$" />

                    </EditItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="txtNewCost" runat="server" MaxLength="10" />
                        <asp:RequiredFieldValidator ID="rfvtxtNewCost" runat="server" Text="*" ToolTip="Enter Cost" ControlToValidate="txtNewCost" />
                        <asp:RegularExpressionValidator ID="revtxtNewCost" runat="server" Text="*" ToolTip="Enter numeric value" ControlToValidate="txtNewCost" ValidationExpression="^[0-9]+$" />
                    </FooterTemplate>
                </asp:TemplateField>

                <asp:TemplateField>
                    <HeaderTemplate>IsDeliverable</HeaderTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblIsDeliverable" runat="server" Text='<%#Bind("IS_DELIVERABLE") %>' />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtIsDeliverable" runat="server" Text='<%#Bind("IS_DELIVERABLE") %>' MaxLength="1" />
                        <asp:RequiredFieldValidator ID="rfvtxtIsDeliverable" runat="server" Text="*" ToolTip="Indicate whether deliverable" ControlToValidate="txtIsDeliverable" />

                    </EditItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="txtNewIsDeliverable" runat="server" MaxLength="1" />
                        <asp:RequiredFieldValidator ID="rfvtxtNewIsDeliverable" runat="server" Text="*" ToolTip="Indicate whether deliverable" ControlToValidate="txtNewIsDeliverable" />
                    </FooterTemplate>
                </asp:TemplateField>

                <asp:TemplateField>
                    <HeaderTemplate>Photo</HeaderTemplate>
                    <ItemTemplate>
                        <asp:Image ID="imgPhoto" Width="100px" Height="100px" runat="server" text="Photo" src="<%# "Includes/images/Menu Items/" + Eval("image_path").ToString() %>" />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:FileUpload ID="fuPhoto" runat="server" ToolTip="select Employee Photo" />
                        <asp:RegularExpressionValidator ID="revfuPhoto" runat="server" Text="*" ToolTip="Image format only" ControlToValidate="fuPhoto" ValidationExpression="[a-zA-Z0_9].*\b(.jpeg|.JPEG|.jpg|.JPG|.jpe|.JPE|.png|.PNG|.mpp|.MPP|.gif|.GIF)\b" />
                    </EditItemTemplate>
                    <FooterTemplate>
                        <asp:FileUpload ID="fuNewPhoto" runat="server" ToolTip="select Employee Photo" />
                        <asp:RequiredFieldValidator ID="rfvfuNewPhoto" runat="server" ErrorMessage="*" ToolTip="Select Photo" ControlToValidate="fuNewPhoto" />
                        <asp:RegularExpressionValidator ID="revfuNewPhoto" runat="server" Text="*" ToolTip="Image formate only" ControlToValidate="fuNewPhoto" ValidationExpression="[a-zA-Z0_9].*\b(.jpeg|.JPEG|.jpg|.JPG|.jpe|.JPE|.png|.PNG)\b" />
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