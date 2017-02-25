using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

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
        set
        {
            if (value >= 0) { _id = value; }
        }
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
        set
        {
            _number = value;
        }
    }

    private List<Order_Element> _order_Element;
    public  List<Order_Element> Order_Element
    {
        get
        {
            return _order_Element;
        }
        set
        {
            _order_Element = value;
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
            _type = value;
        }
    }
    #endregion End Properties
    //
    // TODO: Add /// comments to each Property
    // Gets and Sets ... bla bla bla
    //

    //
    // TODO: get new id and new number
    //
    public Order()
    {
        this.CustomerFirstName = null;
        this.CustomerLastName  = null;
        this.ID                = 0;
        this.Location          = null;
        this.Number            = 0;
        this.Order_Element     = null;
        this.Status            = null;
        this.Time              = DateTime.Now;
        this.Type              = null;
    }

    //public Order(int id)
    //{
    //    this.CustomerFirstName = null;
    //    this.CustomerLastName = null;
    //    this.ID = 0;
    //    this.Location = null;
    //    this.Number = 0;
    //    this.Order_Element = new List<global::Order_Element>();
    //    this.Status = null;
    //    this.Time = DateTime.Now;
    //    this.Type = null;
    //}

    //public Order(string firstName, string lastName, int id, string location, int number, List<Order_Element> orderElements, string status, DateTime time, string type)
    //{
    //    this.CustomerFirstName = firstName;
    //    this.CustomerLastName  = lastName;
    //    this.ID                = id;
    //    this.Location          = location;
    //    this.Number            = number;
    //    this.Order_Element     = orderElements;
    //    this.Status            = status;
    //    this.Time              = time;
    //    this.Type              = type;
    //}
}