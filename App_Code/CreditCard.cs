using System;
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
        //DateTime j = new DateTime()
        Regex CCNumberCheck            = new Regex("^[0-9]{16,16}$");
        Regex expirationMonthDateCheck = new Regex("^(0[1-9]|1[0-2])\\/[0-9]{2,2}$");
        Regex cardSecurityCodeCheck    = new Regex("^[0-9]{3,4}$");
        Regex ownerNameCheck           = new Regex("^[^\\\\\\/?^!@#$%&*+=<>;:)(}{\\[\\]]+$");
        Regex amountCheck              = new Regex("^-{0,1}[0-9]*\\.{0,1}[0-9]{0,2}$");
        Convert.ToDateTime(expirationMonthDate);

        if (CCNumberCheck.IsMatch           (CCNumber) &&
            expirationMonthDateCheck.IsMatch(expirationMonthDate) &&
            cardSecurityCodeCheck.IsMatch   (cardSecurityCode) &&
            ownerNameCheck.IsMatch          (ownerName) &&
            amountCheck.IsMatch             (amount) &&
            (expirationMonthDate.CompareTo(DateTime.Today.ToString("MM/yy"))) >= 0)
        {
            // Logic for checking amount of money student has goes here.
            // To simulate, the "check" will randomly pass or fail.
            Random rnd = new Random();
            token = rnd.Next(100) < 75 ? "Pass" : "Fail:Balance has insufficient funds."; // 0 <= number < 100
        }
        else
        {
            token = "Fail:Invalid credit card data.";
        }
        return token + "\nownerName=" + ownerName + ":amount=" + amount;
    }
}