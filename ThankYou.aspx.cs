using System;
using System.Text.RegularExpressions;

public partial class ThankYou : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(Session["orderNumber"] != null && Session["ASAPTime"] != null)
        {
            string time = Session["ASAPTime"].ToString();
            this.lblOrderNumber.Text = Session["orderNumber"].ToString();
            //this.lblASAPTime.Text += Session["ASAPTime"].ToString();
            //this.lblASAPTime.Visible = !string.IsNullOrEmpty(this.lblASAPTime.Text);
            Regex digits = new Regex(@"[0-9]{1,2}");
            MatchCollection matches = digits.Matches(time);
            time = "";
            int match_count = 0;
            int current_match_int;
            foreach (Match match in matches)
            {
                match_count += 1;
                if (match_count <= 2)
                {
                    current_match_int = Int32.Parse(match.ToString());
                    if (current_match_int > 12)
                    {
                        current_match_int -= 12;
                    }
                    time += current_match_int.ToString();
                    if (match_count == 1) time += ":";
                }
            }
            Session.Remove("orderNumber");
            Session.Remove("ASAPTime");
        }
        else
        {
            Response.Redirect(URL.root(Request) + "Cart.aspx", true);
        }
    }
}