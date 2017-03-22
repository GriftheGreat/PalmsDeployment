﻿using System;
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
            return Session["order"] != null ? (Order)Session["order"] : null;
        }
        set
        {
            Session["order"] = value;
            Session["orderItemNumber"] = value.Order_Elements != null ? value.Order_Elements.Count.ToString() : "0";
        }
    }
    #endregion

    public List<DataTable> MenuData;
    //queries[0] = @"SELECT * FROM food";
    //queries[1] = @"SELECT * FROM food_type";
    //queries[2] = @"SELECT * FROM food_detail_line";
    //queries[3] = @"SELECT * FROM detail";

    protected void Page_Init(object sender, EventArgs e)
    {
        if (MenuData == null)
        {
            MenuData = Data_Provider.Transact_Interface.Get_Menu("", Request);
        }

        if(MenuData.Count == 1 && MenuData[0].Columns.Count == 1 && MenuData[0].Rows.Count == 0)
        {
            throw new Exception(MenuData[0].Columns[0].ColumnName); // error to be caught on the error page.
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        //Response.Write("Page_Load<br />\n");
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

        // must select where either "PG" or "PJ"
        EnumerableRowCollection<DataRow> selectedRows = MenuData[1].AsEnumerable().Where(row => row["food_type_vendor"].ToString() == menu);
        if (selectedRows.Count() > 0)
        {
            this.rptCategories.DataSource = selectedRows.CopyToDataTable();
            this.rptCategories.DataBind();
        }

        // make temp detail table with added column of foodIDs
        DataTable detailsAndCorrespondingFoodIDs = MenuData[3];
        detailsAndCorrespondingFoodIDs.Columns.Add("FoodIDs");

        // find foodIDs corresponding to a details (yes the backward relationship)
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
            //Response.Write(((CheckBox)item.FindControl("chbChooseDetail")).Checked ? "Y" : "-");
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

        //Repeater j = ((Repeater)this.rptCategories.Items[this.rptCategories.Items.Count - 1].FindControl("rpt"));
        //j.DataSource = null;
        //j.DataBind();

        if (tempOrder == null)
        {
            tempOrder = new Order(this.hidOrderType.Value);
        }

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