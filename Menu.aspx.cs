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
            MenuData = Data_Provider.Transact_Interface.Get_Menu("");
        }

        if(MenuData.Count == 1 && MenuData[0].Columns.Count == 1 && MenuData[0].Rows.Count == 0)
        {
            throw new Exception(MenuData[0].Columns[0].ColumnName); // error to be caught on the error page.
        }
    }

    protected void Page_Load(object sender, EventArgs e)
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

        // must select where either "PG" or "PJ"
        EnumerableRowCollection<DataRow> selectedRows = MenuData[1].AsEnumerable().Where(row => row["food_type_vendor"].ToString() == menu);
        if (selectedRows.Count() > 0)
        {
            this.rptCategories.DataSource = selectedRows.CopyToDataTable();
            this.rptCategories.DataBind();
        }

        // put all details in repeater (no where clause needed)
        if (selectedRows.Count() > 0)
        {
            this.rptDetailList.DataSource = MenuData[3];
            this.rptDetailList.DataBind();
        }
        //**************************************
        // DataTable food_detail_line
        //**************************************
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
        Order  tempOrder = MyOrder;
        string FoodIDtext = this.hidChosenFoodId.Value;
        int    FoodID;
        Response.Write(this.hidOrderType.Value);

        if (!string.IsNullOrEmpty(FoodIDtext))
        {
            if (Int32.TryParse(FoodIDtext, out FoodID) && FoodID > 0)
            {
                if (tempOrder == null)
                {
                    tempOrder = new Order(this.hidOrderType.Value);
                    tempOrder.Order_Elements = new List<Order_Element>();
                }
                tempOrder.Order_Elements.Add(new Order_Element(FoodID));
                MyOrder = tempOrder;
            }
            else
            {
                // Error
            }
        }
        else
        {
            // Error
        }
    }
}