using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1.Master_Pages
{
    public partial class Default : System.Web.UI.MasterPage
    {
        protected void Page_PreRender(object sender, EventArgs e)
        {
            if (Session["orderItemNumber"] != null)
            {
                this.Item_Count.InnerHtml = Session["orderItemNumber"].ToString();
            }
        }
    }
}