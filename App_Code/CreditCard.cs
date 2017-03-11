using Oracle.DataAccess.Client;
using System;
using System.Configuration;
using System.Web.Services;
using System.Text.RegularExpressions;

/// <summary>
/// The CreditCard class is for simulation purposes and should only be called through it's coresponding service ('CreditCard.asmx').
/// </summary>
[WebService(Namespace = "http://csmain.studentnet.int/seproject/PalmsPP/Services/CreditCard.asmx")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
//[System.Web.Script.Services.ScriptService]
public class CreditCard
{
    [WebMethod]
    public string Process_Credit_Card(string CCNumber, string expirationMonthDate, string ownerName, string cardSecurityCode, string amount)
    {
        string token;

        Regex CCNumberCheck            = new Regex("^[0-9]{16,16}$");
        Regex expirationMonthDateCheck = new Regex("^(0[1-9]|1[0-2])\\/(0[1-9]|[1-2][0-9]|30|31)$");
        Regex cardSecurityCodeCheck    = new Regex("^[0-9]{3,4}$");
        Regex ownerNameCheck           = new Regex("^[^\\\\\\/?^!@#$%&*+=<>;:)(}{\\[\\]]*$");
        Regex amountCheck              = new Regex("^[0-9]*.{0,1}[0-9]{0,2}$");

        if (CCNumberCheck.IsMatch           (CCNumber) &&
            expirationMonthDateCheck.IsMatch(expirationMonthDate) &&
            cardSecurityCodeCheck.IsMatch   (cardSecurityCode) &&
            ownerNameCheck.IsMatch          (ownerName) &&
            amountCheck.IsMatch             (amount))
        {
            // Logic for checking amount of money student has goes here.
            // To simulate, the "check" will randomly pass or fail.
            Random rnd = new Random();
            token = rnd.Next(100) < 50 ? "Pass:" : "Fail:balance has insufficient funds:"; // 0 <= number < 100
        }
        else
        {
            token = "Fail:one or more check(s) failed:";
        }
        return token + CCNumber + ";" + expirationMonthDate + ";" + ownerName + ";" + cardSecurityCode + ";" + amount;
    }
}