using Oracle.DataAccess.Client;
using System.Configuration;
using System.Data;

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

    //public Detail(int id)
    //{
    //    DataTable element;
    //    float cost;
    //    this.ID = id;

    //    element = Get_Detail(this.ID);

    //    if (element.Rows.Count == 1)
    //    {
    //        this.Description = element.Rows[0]["detail_descr"].ToString();
    //        this.GroupName   = element.Rows[0]["group_name"].ToString();;

    //        if (float.TryParse(element.Rows[0]["detail_cost"].ToString(), out cost))
    //        {
    //            this.Cost = cost;
    //        }
    //        else
    //        {
    //            this.Cost = 0.0f;
    //        }
    //    }
    //}

    public Detail(bool chosen, float cost, string description, int id, string groupName)
    {
        this.Chosen      = chosen;
        this.Cost        = cost;
        this.Description = description;
        this.ID          = id;
        this.GroupName   = groupName;
    }

    //public DataTable Get_Detail(int id)
    //{
    //    DataTable data = new DataTable();
    //    string query_string = @"SELECT d.detail_id_pk, d.detail_descr, d.detail_cost, d.group_name
    //                              FROM detail d
    //                             WHERE d.detail_id_pk = :detail_id_pk";
    //    OracleConnection myConnection = new OracleConnection(ConfigurationManager.ConnectionStrings["SEI_DB_Connection"].ConnectionString);
    //    OracleCommand myCommand = new OracleCommand(query_string, myConnection);

    //    try
    //    {
    //        myConnection.Open();

    //        myCommand.Parameters.Add("detail_id_pk", id);
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
}