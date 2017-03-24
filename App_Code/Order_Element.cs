using Oracle.DataAccess.Client;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;

/// <summary>
/// A food on an order.
/// </summary>
public class Order_Element
{
    #region Properties
    // On error do what?
    private string _deliverable;
    public  string Deliverable
    {
        get
        {
            return _deliverable;
        }
        set
        {
            _deliverable = value;
        }
    }

    // can we dynamically check DB varchar2 length of field?
    private string _description;
    public  string Description
    {
        get
        {
            return _description;
        }
        set
        {
            _description = value;
        }
    }

    private List<Detail> _details;
    public  List<Detail> Details
    {
        get
        {
            return _details;
        }
        set
        {
            _details = value;
        }
    }

    // On error do what?
    private int _id;
    public  int ID
    {
        get
        {
            return _id;
        }
        set
        {
            if (value >= 0) { _id = value; }
        }
    }

    // can we dynamically check DB varchar2 length of field?
    private string _imagePath;
    public  string ImagePath
    {
        get
        {
            return _imagePath;
        }
        set
        {
            _imagePath = value;
        }
    }

    // can we dynamically check DB varchar2 length of field?
    private string _name;
    public  string Name
    {
        get
        {
            return _name;
        }
        set
        {
            _name = value;
        }
    }

    private float _price;
    public  float Price
    {
        get
        {
            return _price;
        }
        set
        {
            _price = value;
        }
    }
    #endregion End Properties
    //
    // TODO: Add /// comments to each Property
    // Gets and Sets ... bla bla bla
    //

    public Order_Element()
    {
        this.Deliverable = null;
        this.Description = null;
        this.Details     = new List<Detail>();
        this.ID          = 0;
        this.ImagePath   = null;
        this.Name        = null;
        this.Price       = 0.0f;
    }

    public Order_Element(string deliverable, int id, string imagePath, string description, DataTable details, string name, float price)
    {
        this.Deliverable = deliverable;
        this.Description = description;
        this.Details     = new List<Detail>();
        this.ID          = id;
        this.ImagePath   = imagePath;
        this.Name        = name;
        this.Price       = price;

        foreach(DataRow row in details.Rows)
        {
            //float cost, string description, int id, string groupName
            this.Details.Add(new Detail(row["chosen"].ToString() == "Y",
                                        Convert.ToSingle(row["cost"].ToString()),
                                        row["description"].ToString(),
                                        Convert.ToInt32(row["id"].ToString()),
                                        row["groupName"].ToString() ));
        }
    }

    //public DataTable Get_Order_Element(int food_id)
    //{
    //    DataTable data = new DataTable();
    //    string query_string = @"SELECT f.food_id_pk, f.food_name, f.food_descr, f.food_cost, f.is_deliverable, f.image_path
    //                              FROM food f
    //                             WHERE f.food_id_pk = :food_id_pk";
    //    OracleConnection myConnection = new OracleConnection(ConfigurationManager.ConnectionStrings["SEI_DB_Connection"].ConnectionString);
    //    OracleCommand myCommand = new OracleCommand(query_string, myConnection);

    //    try
    //    {
    //        myConnection.Open();

    //        myCommand.Parameters.Add("food_id_pk", food_id);
    //        data.Load(myCommand.ExecuteReader());
    //    }
    //    finally
    //    {
    //        try
    //        {
    //            myCommand.Dispose();
    //        }
    //        catch { }

    //        myConnection.Close();
    //        myConnection.Dispose();
    //    }
    //    return data;
    //}

    //public DataTable Get_Details(int food_id)
    //{
    //    DataTable data = new DataTable();
    //    string query_string = @"SELECT d.detail_id_pk, d.detail_descr, d.detail_cost, d.group_name
    //                              FROM detail d
    //                              JOIN food_detail_line fdl
    //                                ON fdl.detail_id_fk = d.detail_id_pk
    //                             WHERE fdl.food_id_fk = :food_id_fk";
    //    OracleConnection myConnection = new OracleConnection(ConfigurationManager.ConnectionStrings["SEI_DB_Connection"].ConnectionString);
    //    OracleCommand myCommand = new OracleCommand(query_string, myConnection);

    //    try
    //    {
    //        myConnection.Open();

    //        myCommand.Parameters.Add("food_id_fk", food_id);
    //        data.Load(myCommand.ExecuteReader());
    //    }
    //    finally
    //    {
    //        try
    //        {
    //            myCommand.Dispose();
    //        }
    //        catch { }

    //        myConnection.Close();
    //        myConnection.Dispose();
    //    }
    //    return data;
    //}

    internal float CalculateCost()
    {
        float cost = this.Price;
        foreach (Detail detail in this.Details)
        {
            cost += detail.Cost;
        }
        return cost;
    }
}