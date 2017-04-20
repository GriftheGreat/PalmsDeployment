using System;

public partial class ThankYou : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["orderNumber"] != null && Session["ASAPTime"] != null)
        {
            this.lblOrderNumber.Text = Session["orderNumber"].ToString();
            this.lblASAPTime.Text += Session["ASAPTime"].ToString();
            this.lblASAPTime.Visible = !string.IsNullOrEmpty(this.lblASAPTime.Text);
            Session.Remove("orderNumber");
            Session.Remove("ASAPTime");
        }
        else
        {
            Response.Redirect(URL.root(Request) + "Cart.aspx", true);
        }
    }
}