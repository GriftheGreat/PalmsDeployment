using System;
using System.Data;
using System.Web.UI.WebControls;

public partial class Test : System.Web.UI.Page
{
	protected void Page_Load(object sender, EventArgs e)
	{
		this.me.Text = "Jacob" + DataProvider.mytext;
        this.lbl1.Text = null;
        this.lbl1.Text = this.lbl1.Text.Length.ToString();

    }

    protected void Label4_DataBinding(object sender, EventArgs e)
	{
		Label lbl4 = (Label) sender;
		RepeaterItem container = (RepeaterItem)lbl4.NamingContainer;
		lbl4.Text = ((DataRowView)container.DataItem)[0].ToString(); // column 0
	}

    protected void btn1_Click(object sender, EventArgs e)
    {
        throw new Exception("my error", new Exception("my inner error"));
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