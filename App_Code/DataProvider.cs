﻿using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Data;
using System.Net;
using System.Text.RegularExpressions;
using System.Web;

public static class Data_Provider
{
    public static class Credit_Card_Interface
    {
        public static bool Validate_Credit_Card(string CCNumber, string expirationMonthDate, string cardSecurityCode, string ownerName, string amount)
        {
            Regex CCNumberCheck            = new Regex("^[0-9]{16,16}$");
            Regex expirationMonthDateCheck = new Regex("^(0[1-9]|1[0-2])\\/[0-9]{2,2}$");
            Regex cardSecurityCodeCheck    = new Regex("^[0-9]{3,4}$");
            Regex ownerNameCheck           = new Regex("^[^\\\\\\/?^!@#$%&*+=<>;:)(}{\\[\\]]+$");
            Regex amountCheck              = new Regex("^-{0,1}[0-9]*\\.{0,1}[0-9]{0,2}$");

            return CCNumberCheck.IsMatch           (CCNumber) &&
                   expirationMonthDateCheck.IsMatch(expirationMonthDate) &&
                   cardSecurityCodeCheck.IsMatch   (cardSecurityCode) &&
                   ownerNameCheck.IsMatch          (ownerName) &&
                   amountCheck.IsMatch             (amount);
        }

        public static string Send_Credit_Card_Info(string CCNumber, string expirationMonthDate, string cardSecurityCode, string ownerName, string amount, HttpRequest request)
        {
            NameValueCollection parameters = new NameValueCollection();
            parameters.Add("CCNumber",            CCNumber);
            parameters.Add("expirationMonthDate", expirationMonthDate);
            parameters.Add("cardSecurityCode",    cardSecurityCode);
            parameters.Add("ownerName",           ownerName);
            parameters.Add("amount",              amount);

            return sendWebRequest(parameters, URL.root(request) + "Services/CreditCard.asmx/Process_Credit_Card");
        }
    }

    public static class Transact_Interface
    {
        //public static bool Validate_ID_Card(string data)
        //{
        //    return true;
        //}

        public static string Save_Credit_Card_Info(string Customer_Name, string Order_Time, string token, string confirmation_status, HttpRequest request)
        {
            NameValueCollection parameters = new NameValueCollection();
            parameters.Add("Customer_Name", Customer_Name);
            parameters.Add("Order_Time", Order_Time);
            parameters.Add("p_cci_token",               token);
            parameters.Add("p_cci_confirmation_status", confirmation_status);

            return sendWebRequest(parameters, URL.root(request) + "Services/CreditCardInvoice.asmx/createCCI");
        }

        public static string SendSave_ID_Card_Info(string Customer_Name, string Order_Time, string ID_Number, string Password, string amount, HttpRequest request)
        {
            NameValueCollection parameters = new NameValueCollection();
            parameters.Add("Customer_Name", Customer_Name);
            parameters.Add("Order_Time", Order_Time);
            parameters.Add("ID_Number", ID_Number);
            parameters.Add("Password", Password);
            parameters.Add("amount", amount);

            return sendWebRequest(parameters, URL.root(request) + "Services/IDCard.asmx/Process_ID_Card");
        }

        public static List<DataTable> Get_Menu(string unused, HttpRequest request)
        {
            List<DataTable> menuTables = new List<DataTable>();
            string result;
            string[] rows;
            DataTable menu;
            bool isNotFirstRow;
            List<DataColumn> columns;

            NameValueCollection parameters = new NameValueCollection();
            //parameters.Add("data", data);

            result = sendWebRequest(parameters, URL.root(request) + "Services/Menu.asmx/Menu");

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

        public static string Send_Order_Info(Order order, HttpRequest request)
        {
            string data = "{'CustomerFirstName' : '" + order.CustomerFirstName                         + @"',
                            'CustomerLastName' : '"  + order.CustomerLastName                          + @"',
                            'Cost' : '"              + Math.Round(order.CalculateCost(), 2).ToString() + @"',
                            'Location' : '"          + order.Location.Replace("'", "-apo-")            + @"',
                            'Time' : '"              + order.Time.ToString("yyyyMMdd HH:mm:ss")        + @"',
                            'TimeSlot' : '"          + order.TimeSlot                                  + @"',
                            'Type' : '"              + order.Type                                      + @"',
                            'Foods' : [";

            foreach(Order_Element food in order.Order_Elements)
            {
                data += "{'ID' : '"      + food.ID.ToString() + @"',
                          'Details' : [";

                foreach (Detail detail in food.Details)
                {
                    if (detail.Chosen)
                    {
                        data += "{'ID' : '" + detail.ID.ToString() + @"'},";
                    }
                }
                data = data.TrimEnd(",".ToCharArray()) + "]},"; // Details
            }
            data = data.TrimEnd(",".ToCharArray()) + "]}"; // Foods

            NameValueCollection parameters = new NameValueCollection();
            parameters.Add("data", data);

            return sendWebRequest(parameters, URL.root(request) + "Services/Order.asmx/createOrder");
        }

        public static DataTable Get_Times(string unused, HttpRequest request)
        {
            string result;
            string[] rows;
            DataTable menu = new DataTable();
            bool isNotFirstRow = false;
            List<DataColumn> columns = new List<DataColumn>();

            NameValueCollection parameters = new NameValueCollection();
            //parameters.Add("data", data);

            result = sendWebRequest(parameters, URL.root(request) + "Services/TimeSlots.asmx/getTimeSlots");

            if (result.Contains("ERROR") || string.IsNullOrEmpty(result))
            {
                menu.Columns.Add(new DataColumn("time_slot_id_pk"));
                menu.Columns.Add(new DataColumn("time_slot"));
                menu.Rows.Add(new string[] { "1", result });
            }
            else
            {
                rows = result.Split(new string[] { "\r\n" }, StringSplitOptions.RemoveEmptyEntries);

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
            }
            return menu;
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

    public static string correctPrices(string badPrice)
    {
        return Convert.ToSingle(badPrice).ToString("0.00").Insert(Convert.ToSingle(badPrice).ToString("0.00").IndexOf("-") + 1, "$");
    }
}

/// <summary>
/// URL class for getting the url to the root of this web project.
/// </summary>
public static class URL
{
    /// <summary>
    /// Returns
    /// "http://localhost:#####" + "/" + "";
    /// OR
    /// "http://csmain.studentnet.int" + "/seproject/PalmsPP" + "/";
    /// WHERE ##### is the local host port number that IIS Express makes for the debugger.
    /// </summary>
    /// <param name="request">The System.Web.HttpRequest of the web page that holds key URL information.</param>
    /// <returns>The base URL to this project ending in the root's '/'</returns>
    public static string root(HttpRequest request)
    {
        string URL = request.Url.GetLeftPart(UriPartial.Authority) + request.ApplicationPath;
        return URL + (URL[URL.Length - 1] == '/' ? "" : "/");
    }
}