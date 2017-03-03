using Oracle.DataAccess.Client;
using System;
using System.Configuration;
using System.Web.Services;

/// <summary>
/// Summary description for CreditCard1
/// </summary>
[WebService(Namespace = "http://csmain.studentnet.int/seproject/PalmsPP/Services/CreditCard.asmx")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class CreditCard
{
    [WebMethod]
    public string Process_Credit_Card(string CCNumber, string expirationMonthDate, string cardSecurityCode, string amount)
    {
        //check values

        // Logic for checking amount of money student has goes here.
        // To simulate, the "check" will randomly pass or fail.
        Random rnd = new Random();
        String status = rnd.Next(100) < 50 ? "Y" : "N"; // 0 <= number < 100

        return "Y";
    }

    [WebMethod]
    public string HelloWorld()
    {
        return "Hello World";
    }

    [WebMethod]
    public string HelloWorld2(string name)
    {
        return "Hello "+ name;
    }

}