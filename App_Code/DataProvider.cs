using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Data;
using System.Net;
using System.Text.RegularExpressions;

public static class Data_Provider
{
    public const string mytext = " got connected!";
    public const string urlBase = "http://localhost:61136/";
    //public const string urlBase = "http://csmain.studentnet.int/seproject/PalmsPP/";

    public static class Credit_Card_Interface
    {
        public static bool Validate_Credit_Card(string CCNumber, string expirationMonthDate, string cardSecurityCode, string ownerName, string amount)
        {
            Regex CCNumberCheck            = new Regex("^[0-9]{16,16}$");
            Regex expirationMonthDateCheck = new Regex("^(0[1-9]|1[0-2])\\/(0[1-9]|[1-2][0-9]|30|31)$");
            Regex cardSecurityCodeCheck    = new Regex("^[0-9]{3,4}$");
            Regex ownerNameCheck           = new Regex("^[^\\\\\\/?^!@#$%&*+=<>;:)(}{\\[\\]]*$");
            Regex amountCheck              = new Regex("^[0-9]*.{0,1}[0-9]{0,2}$");

            return CCNumberCheck.IsMatch           (CCNumber) &&
                   expirationMonthDateCheck.IsMatch(expirationMonthDate) &&
                   cardSecurityCodeCheck.IsMatch   (cardSecurityCode) &&
                   ownerNameCheck.IsMatch          (ownerName) &&
                   amountCheck.IsMatch             (amount);
        }

        public static string Send_Credit_Card_Info(string CCNumber, string expirationMonthDate, string cardSecurityCode, string ownerName, string amount)
        {
            NameValueCollection parameters = new NameValueCollection();
            parameters.Add("CCNumber",            CCNumber);
            parameters.Add("expirationMonthDate", expirationMonthDate);
            parameters.Add("cardSecurityCode",    cardSecurityCode);
            parameters.Add("ownerName",           ownerName);
            parameters.Add("amount",              amount);

            return sendWebRequest(parameters, urlBase + "Services/CreditCard.asmx/Process_Credit_Card");
        }
    }

    public static class Transact_Interface
    {
        public static bool Validate_ID_Card(string data)
        {
            return true;
        }

        public static string Save_Credit_Card_Info(string order_id, string token, string confirmation_status)
        {
            NameValueCollection parameters = new NameValueCollection();
            parameters.Add("p_cci_order_id_fk",         order_id);
            parameters.Add("p_cci_token",               token);
            parameters.Add("p_cci_confirmation_status", confirmation_status);

            return sendWebRequest(parameters, urlBase + "Services/CreditCardInvoice.asmx/createCCI");
        }

        public static string SendSave_ID_Card_Info(string Order_ID, string ID_Number, string Password)
        {
            NameValueCollection parameters = new NameValueCollection();
            parameters.Add("Order_ID", Order_ID);
            parameters.Add("ID_Number", ID_Number);
            parameters.Add("Password", Password);

            return sendWebRequest(parameters, urlBase + "Services/IDCard.asmx/Process_ID_Card");
        }

        public static List<DataTable> Get_Menu(string data)
        {
            List<DataTable> menuTables = new List<DataTable>();
            string result;
            DataTable menu;
            bool isNotFirstRow;
            string[] rows;
            List<DataColumn> columns;

            NameValueCollection parameters = new NameValueCollection();
            //parameters.Add("data", data);

            result = sendWebRequest(parameters, urlBase + "Services/Menu.asmx/Menu");

            foreach (string resultTable in result.Split(new string[] { "-;-" }, StringSplitOptions.None))
            {
                isNotFirstRow = false;
                menu = new DataTable();
                columns = new List<DataColumn>();

                if (resultTable.Contains("ERROR") || string.IsNullOrEmpty(resultTable))
                {
                    menu.Columns.Add(new DataColumn("ERROR"));
                    menu.Rows.Add(new string[] { resultTable });
                    menuTables.Add(menu);
                }
                else
                {
                    rows = resultTable.Split(new string[] { "\r\n" }, StringSplitOptions.RemoveEmptyEntries);

                    foreach (string columnName in rows[0].Split(new string[] { "-,-" }, StringSplitOptions.None))
                    {
                        columns.Add(new DataColumn(columnName));
                    }
                    menu.Columns.AddRange(columns.ToArray());

                    foreach (string row in rows)
                    {
                        if (isNotFirstRow)
                        {
                            menu.Rows.Add(row.Split(new string[] { "-,-" }, StringSplitOptions.None));
                        }
                        else
                        {
                            isNotFirstRow = true;
                        }
                    }
                    menuTables.Add(menu);
                }
            }
            return menuTables;
        }

        public static bool Send_Order_Info(Order data)
        {
            //data. pull apart
            NameValueCollection parameters = new NameValueCollection();
            //parameters.Add("data", data);

            string result = sendWebRequest(parameters, urlBase + "Services/Order.asmx/_");
            return result.Length > 0;
        }
    }

    private static string sendWebRequest(NameValueCollection data, string url)
    {
        string result = "";
        byte[] resultBytes;
        WebClient client = new WebClient();

        //client.Headers.Add(HttpRequestHeader.Host, "localhost");
        //client.Headers.Add(HttpRequestHeader.Accept, "application/json, text/javascript, */*; q=0.01");

        try
        {
            resultBytes = client.UploadValues(url, "POST", data);

            foreach (byte b in resultBytes)
            {
                result += (char)b;
            }
        }
        catch (Exception ex)
        {
            result = "ERROR<br />" + result + "<br />";
            while (ex != null)
            {
                result += ex.Message + "<br /><br />";
                ex = ex.InnerException;
            }
            foreach (string k in data)
            {
                foreach (string v in data.GetValues(k))
                {
                    result += k + ", " + v + "<br />";
                }
            }
        }
        finally
        {
            try
            {
                client.Dispose();
            }
            catch (Exception) { }
        }
        //return result =
        //< !--? xml version = "1.0" encoding = "utf-8" ? -->
        //< string xmlns = "..." > ... </string>
        //WHERE FIRST ... IS LIKE http://csmain.studentnet.int/seproject/PalmsPP/Services/CreditCard.asmx AND SECOND ... = DATA

        result = result.Substring(result.IndexOf(">") + 1); //REMOVES < !--? xml version = "1.0" encoding = "utf-8" ? -->
        result = result.Substring(result.IndexOf(">") + 1); //REMOVES < string xmlns = "..." >

        return result.Remove(result.LastIndexOf("<")); //REMOVES </string>
    }
}