using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;

/// <summary>
/// Summary description for SaveCreditCard
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
// [System.Web.Script.Services.ScriptService]
public class CreditCardInvoice : System.Web.Services.WebService
{
    public string SaveCCInv()
    {
        return "CreditCardInvoice says Hello World";
    }

    [WebMethod]
    public string HelloWorld()
    {
        return "CreditCardInvoice says Hello World";
    }
}