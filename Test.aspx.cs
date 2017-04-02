using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Data;
using System.Web.UI.WebControls;

public partial class Test : System.Web.UI.Page
{
	protected void Page_Load(object sender, EventArgs e)
	{
        //Repeater j = ((Repeater)this.rptCategories.Items[this.rptCategories.Items.Count - 1].FindControl("rpt"));
        //j.DataSource = null;
        //j.DataBind();

        //int jj;
        //for (jj = 0; jj < 10; jj++)
        //{
        //    Response.Write("<div>"+jj.ToString()+"</div>");
        //
        //}
        //this.litControl.Text = var;


        gdvSession.DataSource = Session;
        gdvSession.DataBind();


        List<DataTable> j = Data_Provider.Transact_Interface.Get_Menu("", Request);

        this.gdvMenu1.DataSource = j[0];
        this.gdvMenu1.DataBind();

        this.gdvMenu2.DataSource = j[1];
        this.gdvMenu2.DataBind();

        this.gdvMenu3.DataSource = j[2];
        this.gdvMenu3.DataBind();

        this.gdvMenu4.DataSource = j[3];
        this.gdvMenu4.DataBind();
    }

    protected void btnClearSession_Click(object sender, EventArgs e)
    {
        Session.Clear();
        gdvSession.DataSource = Session;
        gdvSession.DataBind();
    }

    protected void btn1_Click(object sender, EventArgs e)
    {
        throw new Exception("my error", new Exception("my inner error"));
    }

    protected void btn2_Click(object sender, EventArgs e)
    {
        this.lbl2.Text = Data_Provider.Credit_Card_Interface.Send_Credit_Card_Info("1111222233334444", "05/17", "123", "Jacob Harder", "0.00", Request);//.Contains("Pass") ? "Transaction Approved" : "Transaction Denied";
    }
}

//https://msdn.microsoft.com/en-us/library/ms164642(v=vs.80).aspx
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