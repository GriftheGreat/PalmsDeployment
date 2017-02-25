using System.Configuration;
using System.Collections.Generic;
using System.Data;
using Oracle.DataAccess.Client;
using System;

/// <summary>
/// Summary description for Order_Element
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
            if (value.Length == 0 || value.Length == 1) { _deliverable = value; }
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
        this.Details     = null;
        this.ID          = 0;
        this.Name        = null;
        this.Price       = 0.0f;
        this.ImagePath   = null;
    }

    public Order_Element(int id)
    {
        DataTable element;
        float price;
        this.ID = id;

        element = Get_Order_Element(this.ID);

        if (element.Rows.Count == 1)
        {
            this.Deliverable = element.Rows[0]["is_deliverable"].ToString();
            this.Description = element.Rows[0]["food_descr"].ToString();
            this.ImagePath   = element.Rows[0]["image_path"].ToString();
            this.Name        = element.Rows[0]["food_name"].ToString();

            if (float.TryParse(element.Rows[0]["food_cost"].ToString(), out price))
            {
                this.Price = price;
            }
            else
            {
                this.Price = 0.0f;
            }

            foreach(DataRow row in Get_Details(this.ID).Rows)
            {
                this.Details.Add(new Detail(Convert.ToSingle(row["detail_id_pk"].ToString()), row["detail_descr"].ToString(), Convert.ToInt32(row["detail_cost"].ToString())));
            }
        }
    }

    public Order_Element(string deliverable, string description, List<Detail> details, int id, string imagePath, string name, float price)
    {
        if (deliverable.Length == 0 || deliverable.Length == 1) { this.Deliverable = deliverable; }
        this.Description = description;
        this.Details     = details;
        if (id >= 0) { _id = id; }
        this.ImagePath   = imagePath;
        this.Name        = name;
        this.Price       = price;
    }

    public DataTable Get_Order_Element(int food_id)
    {
        DataTable data = new DataTable();
        string query_string = @"SELECT f.food_id_pk, f.food_name, f.food_descr, f.food_cost, f.is_deliverable, f.image_path
                                  FROM food f
                                 WHERE f.food_id_pk = :food_id_pk";
        OracleConnection myConnection = new OracleConnection(ConfigurationManager.ConnectionStrings["SEI_DB_Connection"].ConnectionString);
        OracleCommand myCommand = new OracleCommand(query_string, myConnection);

        try
        {
            myConnection.Open();

            myCommand.Parameters.Add("food_id_pk", food_id);
            data.Load(myCommand.ExecuteReader());
        }
        finally
        {
            try
            {
                myCommand.Dispose();
            }
            catch { }

            myConnection.Close();
            myConnection.Dispose();
        }
        return data;
    }

    public DataTable Get_Details(int food_id)
    {
        DataTable data = new DataTable();
        string query_string = @"SELECT d.detail_id_pk, d.detail_descr, d.detail_cost
                                  FROM detail d
                                  JOIN food_detail_line fdl
                                    ON fdl.detail_id_fk = d.detail_id_pk
                                 WHERE fdl.food_id_fk = :food_id_fk";
        OracleConnection myConnection = new OracleConnection(ConfigurationManager.ConnectionStrings["SEI_DB_Connection"].ConnectionString);
        OracleCommand myCommand = new OracleCommand(query_string, myConnection);

        try
        {
            myConnection.Open();

            myCommand.Parameters.Add("food_id_fk", food_id);
            data.Load(myCommand.ExecuteReader());
        }
        finally
        {
            try
            {
                myCommand.Dispose();
            }
            catch { }

            myConnection.Close();
            myConnection.Dispose();
        }
        return data;
    }
}