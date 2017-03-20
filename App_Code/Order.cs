using System;
using System.Collections.Generic;

/// <summary>
/// Summary description for Order
/// </summary>
public class Order
{
    #region Properties
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
        this.Location          = null;
        this.Order_Elements    = new List<Order_Element>();
        this.Status            = null;
        this.Time              = DateTime.Now;
        this.Type              = type;
    }
}