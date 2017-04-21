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
        string token = "";

        Regex CCNumberCheck            = new Regex("^[0-9]{16,16}$");
        Regex expirationMonthDateCheck = new Regex("^(0[1-9]|1[0-2])\\/[0-9]{2,2}$");
        Regex cardSecurityCodeCheck    = new Regex("^[0-9]{3,4}$");
        Regex ownerNameCheck           = new Regex("^[^\\\\\\/?^!@#$%&*+=<>;:)(}{\\[\\]]+$");
        Regex amountCheck              = new Regex("^-{0,1}[0-9]*\\.{0,1}[0-9]{0,2}$");

        try
        {

            int expirationMonth = Convert.ToInt32(expirationMonthDate.Substring(0, 2));
            // if (expirationYear < 30) 20nn; else 19nn 
            int expirationYear = System.Globalization.CultureInfo.CurrentCulture.Calendar.ToFourDigitYear(Convert.ToInt32(expirationMonthDate.Substring(3)));

            if(expirationMonth == 12)
            {
                expirationYear += 1;
            }
            else
            {
                expirationMonth += 1;
            }

            DateTime cardExpiration = new DateTime(expirationYear, expirationMonth, 1);

            #region
            if (!CCNumberCheck.IsMatch(CCNumber))
            {
                token += (token.Length > 0 ? ",<br />" : "") + "Please give a credit card number of 16 numbers";
            }

            if (!expirationMonthDateCheck.IsMatch(expirationMonthDate))
            {
                token += (token.Length > 0 ? ",<br />" : "") + "Please give a expiration date that is a two digit month, slach ('/'), and two digit year";
            }

            if (!cardSecurityCodeCheck.IsMatch(cardSecurityCode))
            {
                token += (token.Length > 0 ? ",<br />" : "") + "Please give a security code of 3 or 4 numbers";
            }

            if (!ownerNameCheck.IsMatch(ownerName))
            {
                token += (token.Length > 0 ? ",<br />" : "") + "Please do not include symbols in name";
            }

            if (cardExpiration < DateTime.Today)
            {
                token += (token.Length > 0 ? ",<br />" : "") + "Cannot process order using a card with an expiration date of " + cardExpiration.Year.ToString();
            }
            #endregion

            if (CCNumberCheck.IsMatch(CCNumber) &&
            expirationMonthDateCheck.IsMatch(expirationMonthDate) &&
            cardSecurityCodeCheck.IsMatch(cardSecurityCode) &&
            ownerNameCheck.IsMatch(ownerName) &&
            amountCheck.IsMatch(amount) &&
            cardExpiration >= DateTime.Today)
            {
                // Logic for checking amount of money student has goes here.
                // To simulate, the "check" will randomly pass or fail.
                Random rnd = new Random();
                token = rnd.Next(100) < 75 ? "Pass" : "Fail:Balance has insufficient funds."; // 0 <= number < 100
            }
            else
            {
                token = "Fail:" + token + ".";
            }
        }
        catch(Exception ex)
        {
            token = "Fail:Invalid credit card data." + ex.Message;
        }
        return token + "\nownerName=" + ownerName + ", amount=" + amount;
    }
}