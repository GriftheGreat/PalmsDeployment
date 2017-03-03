using System;
using System.Collections.Generic;

/// <summary>
/// Summary description for Order
/// </summary>
public class Order
{
    #region Properties
    // can we dynamically check DB varchar2 length of field?
    private string _customerFirstName;
    public  string CustomerFirstName
    {
        get
        {
            return _customerFirstName;
        }
        set
        {
            _customerFirstName = value;
        }
    }

    // can we dynamically check DB varchar2 length of field?
    private string _customerLastName;
    public  string CustomerLastName
    {
        get
        {
            return _customerLastName;
        }
        set
        {
            _customerLastName = value;
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
        //REMOVED
        //set
        //{
        //    if (value >= 0) { _id = value; }
        //}
    }

    // What type?
    private string _location;
    public  string Location
    {
        get
        {
            return _location;
        }
        set
        {
            _location = value;
        }
    }

    private int _number;
    public  int Number
    {
        get
        {
            return _number;
        }
        //REMOVED
        //set
        //{
        //    _number = value;
        //}
    }

    private List<Order_Element> _order_Elements;
    public  List<Order_Element> Order_Elements
    {
        get
        {
            return _order_Elements;
        }
        set
        {
            _order_Elements = value;
        }
    }

    // What type?
    private string _status;
    public  string Status
    {
        get
        {
            return _status;
        }
        set
        {
            _status = value;
        }
    }

    private DateTime _time;
    public  DateTime Time
    {
        get
        {
            return _time;
        }
        set
        {
            _time = value;
        }
    }

    // What type?
    private string _type;
    public  string Type
    {
        get
        {
            return _type;
        }
        set
        {
            if (value == null) { throw new Exception("Order Type cannot be null."); } else { _type = value; };
        }
    }
    #endregion End Properties
    //
    // TODO: Add /// comments to each Property
    // Gets and Sets ... bla bla bla
    //

    public Order(string type)
    {
        this.CustomerFirstName = null;
        this.CustomerLastName  = null;
        _id                    = 0;
        this.Location          = null;
        _number                = 0;
        this.Order_Elements    = null;
        this.Status            = null;
        this.Time              = DateTime.Now;
        this.Type              = type;
    }

    //public Order(int id)
    //{
    //    this.ID = id;
    //
    // TODO: Load data...
    //
    //    this.CustomerFirstName = null;
    //    this.CustomerLastName  = null;
    //    this.Location          = null;
    //    this.Number            = 0;
    //    while(.Read())
    //    {
    //        this.Order_Elements.Add(new Order_Element(Convert.ToInt32(myReader["id"].ToString()) ));
    //    }
    //    this.Status            = null;
    //    this.Time              = DateTime.Now;
    //    this.Type              = null;
    //}
}