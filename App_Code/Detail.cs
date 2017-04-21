/// <summary>
/// Summary description for Detail
/// </summary>
public class Detail
{
    #region Properties
    private bool _chosen;
    public  bool Chosen
    {
        get
        {
            return _chosen;
        }
        set
        {
            _chosen = value;
        }
    }

    private float _cost;
    public float Cost
    {
        get
        {
            return _cost;
        }
        set
        {
            _cost = value;
        }
    }

    private string _description;
    public string Description
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

    // On error do what?
    private int _id;
    public int ID
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

    private string _groupName;
    public string GroupName
    {
        get
        {
            return _groupName;
        }
        set
        {
            _groupName = value;
        }
    }
    #endregion End Properties
    //
    // TODO: Add /// comments to each Property
    // Gets and Sets ... bla bla bla
    //

    public Detail()
    {
        this.Chosen      = false;
        this.Cost        = 0.0f;
        this.Description = null;
        this.ID          = 0;
        this.GroupName   = "";
    }

    public Detail(bool chosen, float cost, string description, int id, string groupName)
    {
        this.Chosen      = chosen;
        this.Cost        = cost;
        this.Description = description;
        this.ID          = id;
        this.GroupName   = groupName;
    }
}