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
                    <HeaderTemplate>Id</HeaderTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblId" runat="server" Text='<%#Bind("id")%>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField>
                    <HeaderTemplate>Name</HeaderTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblName" runat="server" Text='<%#Bind("name") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtName" runat="server" Text='<%#Bind("name") %>' MaxLength="50"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvtxtName" runat="server" Text="*" ToolTip="Enter name" ControlToValidate="txtName"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revtxtName" runat="server" Text="*" ToolTip="Enter letters " ControlToValidate="txtName" ValidationExpression="^[a-zA-Z'.\s]{1,40}$"></asp:RegularExpressionValidator>

                    </EditItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="txtNewName" runat="server" MaxLength="50"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvtxtNewName" runat="server" Text="*" ToolTip="Enter name" ControlToValidate="txtNewName"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revtxtNewName" runat="server" Text="*" ToolTip="Enter letters " ControlToValidate="txtNewName" ValidationExpression="^[a-zA-Z'.\s]{1,40}$"></asp:RegularExpressionValidator>

                    </FooterTemplate>
                </asp:TemplateField>

                <asp:TemplateField>
                    <HeaderTemplate>Description</HeaderTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblDescr" runat="server" Text='<%#Bind("Descr") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtDescr" runat="server" Text='<%#Bind("Descr") %>' MaxLength="2"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvtxtDescr" runat="server" Text="*" ToolTip="Enter Description" ControlToValidate="txtDescr"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revtxtDescr" runat="server" Text="*" ToolTip="Enter food description" ControlToValidate="txtDescr" ValidationExpression="^[0-9]+$"></asp:RegularExpressionValidator>

                    </EditItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="txtNewDescr" runat="server" MaxLength="2"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvtxtNewDescr" runat="server" Text="*" ToolTip="Enter Descr" ControlToValidate="txtNewDescr"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revNewtxtDescr" runat="server" Text="*" ToolTip="Enter food description" ControlToValidate="txtNewDescr" ValidationExpression="^[0-9]+$"></asp:RegularExpressionValidator>
                    </FooterTemplate>
                </asp:TemplateField>

                <asp:TemplateField>
                    <HeaderTemplate>Cost</HeaderTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblCost" runat="server" Text='<%#Bind("Cost") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtCost" runat="server" Text='<%#Bind("Cost") %>' MaxLength="5"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvtxtCost" runat="server" Text="*" ToolTip="Enter Cost" ControlToValidate="txtCost"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revtxtCost" runat="server" Text="*" ToolTip="Enter numeric value" ControlToValidate="txtCost" ValidationExpression="^[0-9]+$"></asp:RegularExpressionValidator>

                    </EditItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="txtNewCost" runat="server" MaxLength="10"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvtxtNewCost" runat="server" Text="*" ToolTip="Enter Cost" ControlToValidate="txtNewCost"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revtxtNewCost" runat="server" Text="*" ToolTip="Enter numeric value" ControlToValidate="txtNewCost" ValidationExpression="^[0-9]+$"></asp:RegularExpressionValidator>
                    </FooterTemplate>
                </asp:TemplateField>

                <asp:TemplateField>
                    <HeaderTemplate>IsDeliverable</HeaderTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblIsDeliverable" runat="server" Text='<%#Bind("IsDeliverable") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtIsDeliverable" runat="server" Text='<%#Bind("IsDeliverable") %>' MaxLength="20"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvtxtIsDeliverable" runat="server" Text="*" ToolTip="Indicate whether deliverable" ControlToValidate="txtIsDeliverable"></asp:RequiredFieldValidator>

                    </EditItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="txtNewIsDeliverable" runat="server" MaxLength="20"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvtxtNewIsDeliverable" runat="server" Text="*" ToolTip="Indicate whether deliverable" ControlToValidate="txtNewIsDeliverable"></asp:RequiredFieldValidator>
                    </FooterTemplate>
                </asp:TemplateField>

                <asp:TemplateField>
                    <HeaderTemplate>Photo</HeaderTemplate>
                    <ItemTemplate>
                        <asp:Image ID="imgPhoto" Width="100px" Height="100px" runat="server" text="Photo" ImageUrl='<%#Bind("photopath") %>' />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:FileUpload ID="fuPhoto" runat="server" ToolTip="select Employee Photo" />
                        <asp:RegularExpressionValidator ID="revfuPhoto" runat="server" Text="*" ToolTip="ImDescr formate only" ControlToValidate="fuPhoto" ValidationExpression="[a-zA-Z0_9].*\b(.jpeg|.JPEG|.jpg|.JPG|.jpe|.JPE|.png|.PNG|.mpp|.MPP|.gif|.GIF)\b"></asp:RegularExpressionValidator>
                    </EditItemTemplate>
                    <FooterTemplate>
                        <asp:FileUpload ID="fuNewPhoto" runat="server" ToolTip="select Employee Photo" />
                        <asp:RequiredFieldValidator ID="rfvfuNewPhoto" runat="server" ErrorMessage="*" ToolTip="Select Photo" ControlToValidate="fuNewPhoto"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revfuNewPhoto" runat="server" Text="*" ToolTip="ImDescr formate only" ControlToValidate="fuNewPhoto" ValidationExpression="[a-zA-Z0_9].*\b(.jpeg|.JPEG|.jpg|.JPG|.jpe|.JPE|.png|.PNG|.mpp|.MPP|.gif|.GIF)\b"></asp:RegularExpressionValidator>
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