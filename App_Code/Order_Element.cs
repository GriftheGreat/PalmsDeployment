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

    public float CalculateCost()
    {
        float cost = this.Price;
        foreach (Detail detail in this.Details)
        {
            if (detail.Chosen)
            {
                cost += detail.Cost;
            }
        }
        return cost;
    }
}