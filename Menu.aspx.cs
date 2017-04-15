using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web.UI.WebControls;

public partial class Menu : System.Web.UI.Page
{
    #region Properties
    public Order MyOrder
    {
        get
        {
            //Response.Write("*get::" + (Session["order"] != null ? "yep" : "null") + "*<br />\n");
            return Session["order"] != null ? (Order)Session["order"] : null;
        }
        set
        {
            //Response.Write("*set::" + (value != null ? "yep->"+value.Type : "null") + "*<br />\n");
            Session["order"] = value;
            Session["orderItemNumber"] = value.Order_Elements != null ? value.Order_Elements.Count.ToString() : "0";
        }
    }
    #endregion

    #region Variables
    public string currentBigCategory = "";
    public string tabToReopen = "";
    #endregion

    public List<DataTable> MenuData;
    //queries[0] = @"SELECT Food.*, TO_CHAR(food_cost, '99.99') as food_cost FROM food;";
    //queries[1] = @"SELECT * FROM food_type";
    //queries[2] = @"SELECT * FROM food_detail_line";
    //queries[3] = @"SELECT * FROM detail";

    protected void Page_Init(object sender, EventArgs e)
    {
        if (MenuData == null)
        {
            MenuData = Data_Provider.Transact_Interface.Get_Menu("", Request);
        }

        if (MenuData.Count == 1 && MenuData[0].Columns.Count == 1 && MenuData[0].Rows.Count == 0)
        {
            throw new Exception(MenuData[0].Columns[0].ColumnName); // error to be caught on the error page.
        }
    }

    protected void Page_PreRender(object sender, EventArgs e)
    {
        string menu = "PG";
        this.plhCreateYourOwnPizza.Visible = false;

        if (MyOrder != null)
        {
            this.hidOrderType.Value = MyOrder.Type;
        }

        if (Request.QueryString["menu"] == "PapaJohns")
        {
            menu = "PJ";
            this.Title = "Menu | Papa John's";
            this.plhCreateYourOwnPizza.Visible = true;
        }

        // must select where either "PG" or "PJ" and manage food type meals (PG only)
        DataTable categories = MenuData[1];

        //add a sort column
        categories.Columns.Add("sort");

        //put values in the sort column (these are for PG foods, look up the DB data)
        foreach (DataRow row in categories.Rows)
        {
            if (row["food_type_meal"].ToString() == "B")
            {
                row["sort"] = "1";
            }
            else if (row["food_type_meal"].ToString() == "L")
            {
                row["sort"] = "2";
            }
            else if (row["food_type_meal"].ToString() == "A")
            {
                row["sort"] = "3";
            }
        }

        //create the data used   ie.  SELECT ft.*, CASE ... END AS sort FROM food_type WHERE food_type_vendor = :menu AND food_type_name = 'Create Your Own Pizza' ORDER BY sort
        EnumerableRowCollection<DataRow> selectedRows = categories.AsEnumerable().Where(row => row["food_type_vendor"].ToString() == menu &&
                                                                                               row["food_type_name"].ToString() != "Create Your Own Pizza")
                                                                               .OrderBy(row => row["sort"].ToString());

        //bind data to repeater
        if (selectedRows.Count() > 0)
        {
            this.rptCategories.DataSource = selectedRows.CopyToDataTable();
            this.rptCategories.DataBind();
        }

        // make temp detail table with added column of foodIDs
        DataTable detailsAndCorrespondingFoodIDs = MenuData[3];
        detailsAndCorrespondingFoodIDs.Columns.Add("FoodIDs");
        detailsAndCorrespondingFoodIDs.Columns.Add("sort");

        // find foodIDs corresponding to a details (yes the backward relationship)
        // do this because we need to match the food clicked with what details correspond and show them later
        foreach (DataRow row in detailsAndCorrespondingFoodIDs.Rows)
        {
            row["FoodIDs"] = " "; // preceeding space used to match
            foreach (DataRow row2 in MenuData[2].Rows)
            {
                if (row["detail_id_pk"].ToString() == row2["detail_id_fk"].ToString())
                {
                    row["FoodIDs"] += row2["food_id_fk"].ToString() + " "; // following space used to match
                }
            }

            // order the details
            // 'extras' make their parents sort
            row["sort"] = row["group_name"].ToString();
            if (row["group_name"].ToString().Contains("X"))
            {
                foreach (DataRow row2 in detailsAndCorrespondingFoodIDs.Rows)
                {
                    if (row2["detail_id_pk"].ToString() == row["group_name"].ToString().Substring(0, row["group_name"].ToString().IndexOf("X")) && string.IsNullOrEmpty(row2["group_name"].ToString()))
                    {
                        row2["sort"] = row["group_name"].ToString();
                    }
                }
            }
        }

        // use temp detail table with added column of foodIDs
        if (detailsAndCorrespondingFoodIDs.Rows.Count > 0)
        {
            this.rptDetailList.DataSource = detailsAndCorrespondingFoodIDs.AsEnumerable().OrderBy(row => row["sort"]).CopyToDataTable();
            this.rptDetailList.DataBind();
        }
    }

    protected void rptCategories_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        #region Big Categories
        //this section requires the categories to be ordered by the "sort" column
        if (!(Request.QueryString["menu"] == "PapaJohns"))
        {
            if (e.Item.ItemIndex == 0)
            {
                e.Item.FindControl("plhBigCategoryStart").Visible = true;
                currentBigCategory = ((DataRowView)e.Item.DataItem)["food_type_meal"].ToString();
            }
            else if (currentBigCategory != ((DataRowView)e.Item.DataItem)["food_type_meal"].ToString() && ((DataRowView)e.Item.DataItem)["food_type_meal"].ToString() == "A")
            {
                // sort column makes sure this is done at last item being bound
                e.Item.FindControl("plhBigCategoryEnd").Visible = true;
                e.Item.FindControl("plhNormalHeader").Visible = false;
                e.Item.FindControl("plhBigHeader").Visible = true;
                currentBigCategory = ((DataRowView)e.Item.DataItem)["food_type_meal"].ToString();
            }
            else if (currentBigCategory != ((DataRowView)e.Item.DataItem)["food_type_meal"].ToString())
            {
                e.Item.FindControl("plhBigCategoryMiddle").Visible = true;
                currentBigCategory = ((DataRowView)e.Item.DataItem)["food_type_meal"].ToString();
            }
        }
        #endregion

        Repeater rpt = ((Repeater)e.Item.FindControl("rptFood"));
        EnumerableRowCollection<DataRow> selectedRows = MenuData[0].AsEnumerable().Where(row => row["food_type_id_fk"].ToString() == ((DataRowView)e.Item.DataItem)["food_type_id_pk"].ToString())
                                                                                  .OrderBy(row => row["food_name"].ToString());
        if (selectedRows.Count() > 0)
        {
            rpt.DataSource = selectedRows.CopyToDataTable();
            rpt.DataBind();
        }
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        string correspondingDetails = " "; // preceeding space used to match
        Order tempOrder = MyOrder;
        DataRow food = MenuData[0].AsEnumerable().Where(row => row["food_id_pk"].ToString() == this.hidChosenFoodId.Value).CopyToDataTable().Rows[0];
        DataTable details = new DataTable();
        details.Columns.Add("chosen");
        details.Columns.Add("cost");
        details.Columns.Add("description");
        details.Columns.Add("id");
        details.Columns.Add("groupName");

        // find all details allowed for chosen food
        foreach (DataRow row in MenuData[2].Rows)
        {
            if (row["food_id_fk"].ToString() == this.hidChosenFoodId.Value)
            {
                correspondingDetails += row["detail_id_fk"].ToString() + " "; // following space used to match
            }
        }

        foreach (RepeaterItem item in this.rptDetailList.Items)
        {
            if (correspondingDetails.Contains(" " + ((HiddenField)item.FindControl("hidDetailID")).Value + " "))
            {
                DataRow newRow = details.NewRow();
                newRow["chosen"]      = ((CheckBox)item.FindControl("chbChooseDetail")).Checked ? "Y" : "N";
                newRow["cost"]        = ((Label)item.FindControl("lblDetailCost")).Text.Replace("$", "");
                newRow["description"] = ((CheckBox)item.FindControl("chbChooseDetail")).Text;
                newRow["id"]          = ((HiddenField)item.FindControl("hidDetailID")).Value;
                newRow["groupName"]   = ((HiddenField)item.FindControl("hidGroupName")).Value;
                details.Rows.Add(newRow);
            }
        }

        if (tempOrder == null)
        {
            tempOrder = new Order(this.hidOrderType.Value);
        }

        tempOrder.Location = (this.hidOrderType.Value == "PickUp" ? "Palm's Grille" : "");
        tempOrder.TimeSlot = (this.hidOrderType.Value == "PickUp" ? "ASAP" : "");

        tempOrder.Order_Elements.Add(new Order_Element(food["is_deliverable"].ToString(),
                                                       Convert.ToInt32(this.hidChosenFoodId.Value),
                                                       food["image_path"].ToString(),
                                                       food["food_descr"].ToString(),
                                                       details,
                                                       food["food_name"].ToString(),
                                                       Convert.ToSingle(food["food_cost"].ToString())));
        MyOrder = tempOrder;

        tabToReopen = this.hidChosenFoodId.Value;
    }

    protected void AddPizzaToCart_Click(object sender, EventArgs e)
    {
        Order tempOrder = MyOrder;
        DataRow newRow;
        DataTable details = new DataTable();
        details.Columns.Add("chosen");
        details.Columns.Add("cost");
        details.Columns.Add("description");
        details.Columns.Add("id");
        details.Columns.Add("groupName");

        #region did
        #region sizes
        newRow = details.NewRow();
        newRow["chosen"]      = (this.CYOP_1.Attributes["value"] == "true" ? "Y" : "N");
        newRow["cost"]        = "-6.5";
        newRow["description"] = this.CYOP_1.InnerHtml;
        newRow["id"]          = "177";
        newRow["groupName"]   = "size";
        details.Rows.Add(newRow);

        newRow = details.NewRow();
        newRow["chosen"]      = (this.CYOP_2.Attributes["value"] == "true" ? "Y" : "N");
        newRow["cost"]        = "0";
        newRow["description"] = this.CYOP_2.InnerHtml;
        newRow["id"]          = "178";
        newRow["groupName"]   = "size";
        details.Rows.Add(newRow);
        #endregion

        #region crusts
        newRow = details.NewRow();
        newRow["chosen"]      = (this.CYOP_3.Attributes["value"] == "true" ? "Y" : "N");
        newRow["cost"]        = "0";
        newRow["description"] = this.CYOP_3.InnerHtml;
        newRow["id"]          = "51";
        newRow["groupName"]   = "cru";
        details.Rows.Add(newRow);

        newRow = details.NewRow();
        newRow["chosen"]      = (this.CYOP_4.Attributes["value"] == "true" ? "Y" : "N");
        newRow["cost"]        = "0";
        newRow["description"] = this.CYOP_4.InnerHtml;
        newRow["id"]          = "77";
        newRow["groupName"]   = "cru";
        details.Rows.Add(newRow);

        newRow = details.NewRow();
        newRow["chosen"]      = (this.CYOP_5.Attributes["value"] == "true" ? "Y" : "N");
        newRow["cost"]        = "1";
        newRow["description"] = this.CYOP_5.InnerHtml;
        newRow["id"]          = "191";
        newRow["groupName"]   = "cru";
        details.Rows.Add(newRow);
        #endregion

        #region meats
        newRow = details.NewRow();
        newRow["chosen"]      = (this.CYOP_6.Attributes["value"] == "true" ? "Y" : "N");
        newRow["cost"]        = "0";
        newRow["description"] = this.CYOP_6.InnerHtml;
        newRow["id"]          = "40";
        newRow["groupName"]   = "";
        details.Rows.Add(newRow);

        newRow = details.NewRow();
        newRow["chosen"]      = (this.CYOP_7.Attributes["value"] == "true" ? "Y" : "N");
        newRow["cost"]        = "0";
        newRow["description"] = this.CYOP_7.InnerHtml;
        newRow["id"]          = "72";
        newRow["groupName"]   = "";
        details.Rows.Add(newRow);

        newRow = details.NewRow();
        newRow["chosen"]      = (this.CYOP_8.Attributes["value"] == "true" ? "Y" : "N");
        newRow["cost"]        = "1";
        newRow["description"] = this.CYOP_8.InnerHtml;
        newRow["id"]          = "75";
        newRow["groupName"]   = "";
        details.Rows.Add(newRow);

        newRow = details.NewRow();
        newRow["chosen"]      = (this.CYOP_9.Attributes["value"] == "true" ? "Y" : "N");
        newRow["cost"]        = "0";
        newRow["description"] = this.CYOP_9.InnerHtml;
        newRow["id"]          = "74";
        newRow["groupName"]   = "";
        details.Rows.Add(newRow);

        newRow = details.NewRow();
        newRow["chosen"]      = (this.CYOP_10.Attributes["value"] == "true" ? "Y" : "N");
        newRow["cost"]        = "0";
        newRow["description"] = this.CYOP_10.InnerHtml;
        newRow["id"]          = "64";
        newRow["groupName"]   = "";
        details.Rows.Add(newRow);
        #endregion

        // 177	8"	-6.5	size
        // 178	16"	0	size

        // 51	Thin Crust	0	cru
        // 77	Pan Crust	0	cru
        // 191	Stuffed Crust	1	cru

        // 40	Bacon	0	
        // 72	Beef	0	
        // 75	Canadian Bacon	0	
        // 74	Italian Sausage	0	
        // 64	Pepperoni	0	
        #endregion
        // 50	Black Olives	0	
        // 62	Fresh-Sliced Onions	0	
        // 63	Green Peppers	0	
        // 65	Roma Tomatoes	0	
        // 67	Jalapeno	0	
        // 68	Banana Peppers	0	
        // 69	Baby portabello Mushrooms	0	

        // 84	Ranch Sauce	0	sau
        // 85	BBQ Sauce	0	sau
        // 89	Spinach Alfredo Sauce	0	sau
        // 183	Original Pizza Sauce	0	sau
        //...


        ////121	17	Create Your Own		11.99	Y		Pizza

        if (tempOrder == null)
        {
            tempOrder = new Order(this.hidOrderType.Value);
        }

        tempOrder.Location = (this.hidOrderType.Value == "PickUp" ? "Palm's Grille" : "");
        tempOrder.TimeSlot = (this.hidOrderType.Value == "PickUp" ? "ASAP" : "");

        //tempOrder.Order_Elements.Add(new Order_Element("Y",
        //                                               8888,
        //                                               "",
        //                                               "",
        //                                               details,
        //                                               "Create Your Own",
        //                                               99.99f));
        MyOrder = tempOrder;
    }
}