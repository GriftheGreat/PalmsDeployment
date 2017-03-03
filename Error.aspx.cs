using System;
using System.Web;

public partial class Errors : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // Create safe error messages.
        string generalErrorMsg = "A problem has occurred on this web site. Please try again. If this error continues, please contact support.";
        string httpErrorMsg = "An HTTP error occurred.";
        string unhandledErrorMsg = "The error was unhandled by application code (or no error occurred).";

        // Display safe error message.
        this.FriendlyErrorMsg.Text = generalErrorMsg;

        // Get the last error from the server.
        Exception ex = Server.GetLastError();

        // Get the error number passed as a querystring value.
        if (!String.IsNullOrEmpty(Request.QueryString["msg"]))
        {
            switch (Request.QueryString["msg"])
            {
                case "400":
                    FriendlyErrorMsg.Text = httpErrorMsg + " Bad Request.";
                    ex = new HttpException(400, httpErrorMsg + " Bad Request.", ex);
                    break;
                case "401":
                    FriendlyErrorMsg.Text = httpErrorMsg + " Unauthorized.";
                    ex = new HttpException(401, httpErrorMsg + " Unauthorized.", ex);
                    break;
                case "403":
                    FriendlyErrorMsg.Text = httpErrorMsg + " Forbidden.";
                    ex = new HttpException(403, httpErrorMsg + " Forbidden.", ex);
                    break;
                case "404":
                    FriendlyErrorMsg.Text = httpErrorMsg + " Page Not Found.";
                    ex = new HttpException(404, httpErrorMsg + " Page Not Found.", ex);
                    break;
                case "407":
                    FriendlyErrorMsg.Text = httpErrorMsg + " Proxy Authentication Fequired.";
                    ex = new HttpException(407, httpErrorMsg + " Proxy Authentication Fequired.", ex);
                    break;
                case "408":
                    FriendlyErrorMsg.Text = httpErrorMsg + " Request Timeout.";
                    ex = new HttpException(408, httpErrorMsg + " Request Timeout.", ex);
                    break;

                case "500":
                    FriendlyErrorMsg.Text = httpErrorMsg + " Internal Server Error.";
                    ex = new HttpException(500, httpErrorMsg + " Internal Server Error.", ex);
                    break;
                default:
                    if (Request.QueryString["msg"].Substring(0, 1) == "4")
                    {
                        FriendlyErrorMsg.Text = httpErrorMsg + " Client Error " + Request.QueryString["msg"];
                    }
                    else if (Request.QueryString["msg"].Substring(0, 1) == "5")
                    {
                        FriendlyErrorMsg.Text = httpErrorMsg + " Server Error " + Request.QueryString["msg"];
                    }
                    ex = new HttpException(httpErrorMsg + " Error " + Request.QueryString["msg"], ex);
                    break;
            }
        }

        // If the exception no longer exists, create a generic exception.
        if (ex == null)
        {
            ex = new Exception(unhandledErrorMsg);
        }

        // Show error details to only you (developer). LOCAL ACCESS ONLY.
        if (Request.IsLocal)
        {
            // Detailed Error Message.
            ErrorDetailedMsg.Text = ex.Message;

            // Show local access details.
            DetailedErrorPanel.Visible = true;

            if (ex.InnerException != null)
            {
                InnerMessage.Text = ex.GetType().ToString() + "<br/>" +
                    ex.InnerException.Message;
                InnerTrace.Text = ex.InnerException.StackTrace;
            }
            else
            {
                InnerMessage.Text = ex.GetType().ToString();
                if (ex.StackTrace != null)
                {
                    InnerTrace.Text = ex.StackTrace.ToString().TrimStart();
                }
            }
        }

        // Clear the error from the server.
        Server.ClearError();
    }
}