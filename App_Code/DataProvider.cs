using System;
using System.Data;
using System.Net;
using System.Collections.Specialized;
using System.Collections.Generic;

public static class Data_Provider
{
    public const string mytext = " got connected!";
    public const string urlBase = "http://localhost:50168/";
    //public const string urlBase = "http://csmain.studentnet.int/seproject/PalmsPP/";

    public static class Credit_Card_Interface
    {
        public static bool Validate_Credit_Card(string data)
        {
            return true;
        }

        public static string Send_Credit_Card_Info(string CCNumber, string expirationMonthDate, string cardSecurityCode, string amount)
        {
            NameValueCollection parameters = new NameValueCollection();
            parameters.Add("CCNumber", CCNumber);
            parameters.Add("expirationMonthDate", expirationMonthDate);
            parameters.Add("cardSecurityCode", cardSecurityCode);
            parameters.Add("amount", amount);

            return sendWebRequest(parameters, urlBase + "Services/CreditCard.asmx/Process_Credit_Card");
        }

        public static bool Save_Credit_Card_Info(string token)
        {
            NameValueCollection parameters = new NameValueCollection();
            //parameters.Add("token", token);

            return sendWebRequest(parameters, urlBase + "Services/CreditCardInvoice.asmx/HelloWorld").Contains("ERROR");
        }
    }

    public static class Transact_Interface
    {
        public static bool Validate_ID_Card(string data)
        {
            return true;
        }

        public static bool Send_ID_Card_Info(string data)
        {
            NameValueCollection parameters = new NameValueCollection();
            parameters.Add("data", data);

            string result = sendWebRequest(parameters, urlBase + "");
            return result.Length > 0;
        }

        public static DataTable Get_Menu(string data)
        {
            string result;
            DataTable menu = new DataTable();
            bool isNotFirstRow = true;
            string[] rows;
            List<DataColumn> columns = new List<DataColumn>();

            NameValueCollection parameters = new NameValueCollection();
            parameters.Add("data", data);

            result = sendWebRequest(parameters, urlBase + "");


            rows = result.Split("\r\n".ToCharArray(), StringSplitOptions.RemoveEmptyEntries);

            foreach (string columnName in rows[0].Split(",".ToCharArray()))
            {
                columns.Add(new DataColumn(columnName));
            }
            menu.Columns.AddRange(columns.ToArray());

            foreach (string row in rows)
            {
                if(isNotFirstRow)
                {
                    menu.Rows.Add(row.Split(",".ToCharArray()));
                }
                else
                {
                    isNotFirstRow = true;
                }
            }
            return menu;
        }

        public static bool Send_Order_Info(string data)
        {
            NameValueCollection parameters = new NameValueCollection();
            parameters.Add("data", data);

            string result = sendWebRequest(parameters, urlBase + "");
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
            client.Dispose();
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
        return result;
    }
}