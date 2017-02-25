using System;
using System.Data;
using System.Web.UI.WebControls;
using System.Net;
using System.Collections.Specialized;
using Oracle.DataAccess.Client;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void L()
    {
        String query_string = "BEGIN create_record(:p_1); END;";
        OracleConnection myConnection = new OracleConnection("");
        OracleCommand myCommand = new OracleCommand(query_string, myConnection);

        try
        {
            myConnection.Open();

            myCommand.Parameters.Add("p_1", true);
            myCommand.ExecuteNonQuery();


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
    }

//https://msdn.microsoft.com/en-us/library/ms164642(v=vs.80).aspx
//
// and WebApplication1 !!! :)
//
//<pages>
//   <namespaces>
//      <add namespace="System" />
//      <add namespace="System.Collections" />
//      <add namespace="System.Collections.Specialized" />
//      <add namespace="System.Configuration" />
//      <add namespace="System.Text" />
//      <add namespace="System.Text.RegularExpressions" />
//      <add namespace="System.Web" />
//      <add namespace="System.Web.Caching" />
//      <add namespace="System.Web.SessionState" />
//      <add namespace="System.Web.Security" />
//      <add namespace="System.Web.Profile" />
//      <add namespace="System.Web.UI" />
//      <add namespace="System.Web.UI.WebControls" />
//      <add namespace="System.Web.UI.WebControls.WebParts" />
//      <add namespace="System.Web.UI.HtmlControls" />
//   </namespaces>
//   <!-- Other elements -->
//</pages>

    protected void btnHI_click(object sender, EventArgs e)
    {
        using (WebClient wb = new WebClient())
        {
            NameValueCollection data = new NameValueCollection();
            //data["id"]       = "myID";
            //data["password"] = "myPassword";
            //data["amount"]   = "theAmount";
            data["fname"] = "Ryan";

            byte[] response = wb.UploadValues("http://www.w3schools.com/asp/showasp.asp?filename=demo_simpleform", "POST", data);
            Response.Write(response);
        }
        //http://www.w3schools.com/asp/showasp.asp?filename=demo_simpleform
    }
}