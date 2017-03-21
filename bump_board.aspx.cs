using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Oracle.DataAccess.Client;
using System.Configuration;


enum tabs
{
    FRONT_WINDOW,
    BACK_WINDOW,
    ICE_CREAM,
    FRIER,
    SALAD,
    PIZZA
}
public partial class _Bump_Board : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        DataTable data = new DataTable();
        string query_string = @"SELECT customer_fname, customer_lname, order_num, order_id_pk
                                FROM &quot;order&quot;
                                WHERE &quot;order&quot;.order_status = 'N'";
        OracleConnection myConnection = new OracleConnection(ConfigurationManager.ConnectionStrings["SEI_DB_Connection"].ConnectionString);
        OracleCommand myCommand = new OracleCommand(query_string, myConnection);

        try
        {
            myConnection.Open();
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
        for (int index = 1; index <= 8; index++)
        {
            data.Rows.Add(data.NewRow());
        }
        this.repeat_orderbox.DataSource = data;
        this.repeat_orderbox.DataBind();

    }

    protected void Page_Init(object sender, EventArgs e)
    {
    }

    protected void front_window_Click(object sender, EventArgs e)
    {
        tab_multi_view.ActiveViewIndex = (int)tabs.FRONT_WINDOW;
    }
    protected void back_window_Click(object sender, EventArgs e)
    {
        tab_multi_view.ActiveViewIndex = (int)tabs.BACK_WINDOW;
    }
    protected void ice_cream_Click(object sender, EventArgs e)
    {
        tab_multi_view.ActiveViewIndex = (int)tabs.ICE_CREAM;
    }
    protected void frier_Click(object sender, EventArgs e)
    {
        tab_multi_view.ActiveViewIndex = (int)tabs.FRIER;
    }
    protected void salad_Click(object sender, EventArgs e)
    {
        tab_multi_view.ActiveViewIndex = (int)tabs.SALAD;
    }
    protected void pizza_Click(object sender, EventArgs e)
    {
        tab_multi_view.ActiveViewIndex = (int)tabs.PIZZA;
    }
}
