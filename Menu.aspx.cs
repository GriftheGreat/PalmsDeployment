using System;
using System.Collections;
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
    #endregion

    public List<DataTable> MenuData;
    //queries[0] = @"SELECT * FROM food";
    //queries[1] = @"SELECT * FROM food_type";
    //queries[2] = @"SELECT * FROM food_detail_line";
    //queries[3] = @"SELECT * FROM detail";

    protected void Page_Init(object sender, EventArgs e)
    {
        //Response.Write("|Page_Init::" + (MyOrder != null ? MyOrder.Type : "MyOrder=null") + "|<br />\n");
        if (MenuData == null)
        {
            MenuData = Data_Provider.Transact_Interface.Get_Menu("", Request);
        }

        if(MenuData.Count == 1 && MenuData[0].Columns.Count == 1 && MenuData[0].Rows.Count == 0)
        {
            throw new Exception(MenuData[0].Columns[0].ColumnName); // error to be caught on the error page.
        }
    }

    protected void Page_PreRender(object sender, EventArgs e)
    {
       // Response.Write("*Page_PreRender::" + (MyOrder != null ? MyOrder.Type : "MyOrder=null") + "*<br />\n");
        // ASP.NET Page Life Cycle Overview 
        // https://msdn.microsoft.com/en-us/library/ms178472.aspx
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
        foreach(DataRow row in categories.Rows)
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
                                                                                               row["food_type_name"].ToString()   != "Create Your Own Pizza")
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

        // find foodIDs corresponding to a details (yes the backward relationship)
        // do this because we need to match the food clicked with what details correspond and show them later
        foreach (DataRow row in detailsAndCorrespondingFoodIDs.Rows)
        {
            row["FoodIDs"] = " "; // preceeding space used to match
            foreach (DataRow row2 in MenuData[2].Rows)
            {
                if(row["detail_id_pk"].ToString() == row2["detail_id_fk"].ToString())
                {
                    row["FoodIDs"] += row2["food_id_fk"].ToString() + " "; // following space used to match
                }
            }
        }

        // use temp detail table with added column of foodIDs
        if (detailsAndCorrespondingFoodIDs.Rows.Count > 0)
        {
            this.rptDetailList.DataSource = detailsAndCorrespondingFoodIDs;
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
        Order tempOrder   = MyOrder;
        DataRow food      = MenuData[0].AsEnumerable().Where(row => row["food_id_pk"].ToString() == this.hidChosenFoodId.Value).CopyToDataTable().Rows[0];
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
            if(correspondingDetails.Contains(" " + ((HiddenField)item.FindControl("hidDetailID")).Value + " "))
            {
                DataRow newRow        = details.NewRow();
                newRow["chosen"]      = ((CheckBox)item.FindControl("chbChooseDetail")).Checked ? "Y" : "N";
                newRow["cost"]        = ((Label)item.FindControl("lblDetailCost")).Text.Replace("$", "");
                newRow["description"] = ((CheckBox)item.FindControl("chbChooseDetail")).Text;
                newRow["id"]          = ((HiddenField)item.FindControl("hidDetailID")).Value;
                newRow["groupName"]   = ((HiddenField)item.FindControl("hidGroupmName")).Value;
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
                                                       Convert.ToSingle(food["food_cost"].ToString()) ));
         MyOrder = tempOrder;
    }
}