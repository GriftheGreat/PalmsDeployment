using Oracle.DataAccess.Client;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Web.Script.Serialization;
using System.Web.Services;

// To allow this Web Service to be called from script, using ASP.NET AJAX, put the following line after
//              [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
//>>this here>> [System.Web.Script.Services.ScriptService]
//              public class


/// <summary>
/// The ID_Card class is for simulation purposes and should only be call by transact entities or via web services.
/// </summary>
[WebService(Namespace = "http://csmain.studentnet.int/seproject/PalmsPP/App_Code/Transact.cs")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class IDCard
{
    [WebMethod]
    public string Process_ID_Card(string Order_ID, string ID_Number, string Password, string amount)
    {
        string status;
        string result = "";

        Regex IDNumberCheck = new Regex("^[0-9]{4,6}$");
        Regex PasswordCheck = new Regex("^[0-9]{8,8}$");
        Regex amountCheck   = new Regex("^-{0,1}[0-9]*.{0,1}[0-9]{0,2}$");

        if (IDNumberCheck.IsMatch(ID_Number) &&
            PasswordCheck.IsMatch(Password) &&
            amountCheck.IsMatch  (amount))
        {
            // Logic for checking amount of money student has goes here.
            // To simulate, the "check" will randomly pass or fail.
            Random rnd = new Random();
            status = rnd.Next(100) < 75 ? "Pass" : "Fail:Balance has insufficient funds."; // 0 <= number < 100

            if (status == "Pass")
            {
                // Retain invoice
                string query_string = @"BEGIN :out := PCC_account_inv_package.createPAI(p_order_id_fk => :p_order_id_fk,
                                                                                        p_confirmation_status => :p_confirmation_status); END;";
                OracleConnection myConnection = new OracleConnection(ConfigurationManager.ConnectionStrings["SEI_DB_Connection"].ConnectionString);
                OracleCommand myCommand = new OracleCommand(query_string, myConnection);

                try
                {
                    myConnection.Open();
                    myCommand.Parameters.Add("out", OracleDbType.Int32, ParameterDirection.Output);
                    myCommand.Parameters.Add("p_order_id_fk", Order_ID);
                    myCommand.Parameters.Add("p_confirmation_status", 'Y');
                    myCommand.ExecuteNonQuery();

                    //do not need in return
                    //result = myCommand.Parameters["out"].Value.ToString();
                }
                catch (Exception ex)
                {
                    status = "";
                    result = "Fail:Could not finalize payment.\n" + ex.Message;
                }
                finally
                {
                    try
                    {
                        myCommand.Dispose();
                    }
                    catch { }

                    myConnection.Close();
                    myConnection.Dispose();
                }
            }
        }
        else
        {
            status = "Fail:Invalid ID card data.";
        }

        return status + result;
    }
}

/// <summary>
/// The Bump_Board class is for simulation purposes and should only be call by transact entities or via web services.
/// </summary>
[WebService(Namespace = "http://csmain.studentnet.int/seproject/PalmsPP/App_Code/Transact.cs")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class Bump_Board
{
    [WebMethod]
    public static char Complete_Order(Int64 orderNumber)
    {
        String query_string = @"BEGIN
                                    updateOrder(p_order_id_pk => :p_order_id_pk
                                                p_order_ready => :p_order_ready);
                                END;";
        OracleConnection myConnection = new OracleConnection(ConfigurationManager.ConnectionStrings["SEI_DB_Connection"].ConnectionString);
        OracleCommand myCommand = new OracleCommand(query_string, myConnection);

        try
        {
            myConnection.Open();
            myCommand.Parameters.Add("p_order_id_pk", orderNumber);
            myCommand.Parameters.Add("p_order_ready", "Y");
            myCommand.ExecuteNonQuery();
        }
        finally
        {
            try
            {
                myCommand.Dispose();
            }
            catch { }

            myConnection.Close();
            myConnection.Dispose();
        }

        return 'Y';
    }
}

/// <summary>
/// The Menu_Data class is for simulation purposes and should only be call by transact entities or via web services.
/// </summary>
[WebService(Namespace = "http://csmain.studentnet.int/seproject/PalmsPP/App_Code/Transact.cs")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class Menu_Data
{
    [WebMethod]
    public string Menu()
    {
        string[] queries = new string[4];
        queries[0] = @"SELECT Food.*, TO_CHAR(food_cost, '99.99') as food_cost_1 FROM food";
        queries[1] = @"SELECT * FROM food_type";
        queries[2] = @"SELECT * FROM food_detail_line";
        queries[3] = @"SELECT * FROM detail";

        DataTable menu = new DataTable();
        StringBuilder sb = new StringBuilder();
        OracleConnection myConnection = new OracleConnection(ConfigurationManager.ConnectionStrings["SEI_DB_Connection"].ConnectionString);
        OracleCommand myCommand;

        try
        {
            myConnection.Open();

            foreach (string query in queries)
            {
                menu = new DataTable();
                myCommand = new OracleCommand(query, myConnection);

                if (sb.Length > 0)
                {
                    sb.Append("-;-");
                }

                try
                {
                    menu.Load(myCommand.ExecuteReader());

                    IEnumerable<string> columnNames = menu.Columns.Cast<DataColumn>().Select(column => column.ColumnName);
                    sb.AppendLine(string.Join("-,-", columnNames));
                    //AppendLine puts "\r\n" between rows

                    foreach (DataRow row in menu.Rows)
                    {
                        IEnumerable<string> fields = row.ItemArray.Select(field => field.ToString());
                        sb.AppendLine(string.Join("-,-", fields));
                    }
                }
                catch (Exception ex)
                {
                    sb.AppendLine("ERROR");
                    sb.AppendLine(ex.Message);
                }
                finally
                {
                    try
                    {
                        myCommand.Dispose();
                    }
                    catch { }
                }
            }
        }
        catch (Exception ex)
        {
            while (sb.ToString().Split(new string[] { "-;-" }, StringSplitOptions.None).Length < queries.Length)
            {
                if (sb.Length > 0)
                {
                    sb.Append("-;-");
                }

                sb.AppendLine("ERROR");
                sb.AppendLine(ex.Message);
            }
        }
        finally
        {
            myConnection.Close();
            myConnection.Dispose();
        }
        return sb.ToString();
    }
}

/// <summary>
/// The CreditCardInvoice class is for simulation purposes and should only be call by transact entities or via web services.
/// </summary>
[WebService(Namespace = "http://csmain.studentnet.int/seproject/PalmsPP/App_Code/Transact.cs")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class CreditCardInvoice
{
    [WebMethod]
    public string createCCI(string p_cci_order_id_fk, string p_cci_token, string p_cci_confirmation_status)
    {
        string result;
        string query_string = "BEGIN :out := credit_card_inv_package.createCCI(p_cci_order_id_fk => :p_cci_order_id_fk, p_cci_token => :p_cci_token, p_cci_confirmation_status => :p_cci_confirmation_status); END;";
        OracleConnection myConnection = new OracleConnection(ConfigurationManager.ConnectionStrings["SEI_DB_Connection"].ConnectionString);
        OracleCommand myCommand = new OracleCommand(query_string, myConnection);

        try
        {
            myConnection.Open();
            myCommand.Parameters.Add("out", OracleDbType.Int32, ParameterDirection.Output);
            myCommand.Parameters.Add("p_cci_order_id_fk", p_cci_order_id_fk);
            myCommand.Parameters.Add("p_cci_token", p_cci_token);
            myCommand.Parameters.Add("p_cci_confirmation_status", p_cci_confirmation_status);
            myCommand.ExecuteNonQuery();

                            //do not need in return
            result = "Pass";// + myCommand.Parameters["out"].Value.ToString();
        }
        catch (Exception ex)
        {
            result = "Fail:Could not finalize payment.\n" + ex.Message;
        }
        finally
        {
            try
            {
                myCommand.Dispose();
            }
            catch { }

            myConnection.Close();
            myConnection.Dispose();
        }
        return result;
    }
}

/// <summary>
/// The TimeSlots class is for simulation purposes and should only be call by transact entities or via web services. (client AJAX too)
/// </summary>
[WebService(Namespace = "http://csmain.studentnet.int/seproject/PalmsPP/App_Code/Transact.cs")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
[System.Web.Script.Services.ScriptService]
public class TimeSlots : System.Web.Services.WebService
{
    [WebMethod]
    public string getTimeSlots()
    {
        DataTable menu = new DataTable();
        StringBuilder sb = new StringBuilder();

        string query = @"SELECT 'ASAP' AS time_slot, 'ASAP' AS time_slot_id_pk, 1 AS sort
                           FROM dual
                          UNION
                         SELECT DISTINCT ts.time_slot_start_time || '-' || ts.time_slot_end_time AS time_slot, TO_CHAR(ts.time_slot_id_pk), 2 AS sort
                           FROM ticket tk
                           JOIN time_slot ts
                             ON ts.time_slot_id_pk = tk.time_slot_id_fk
                          WHERE TO_CHAR(ts.time_slot_date, 'YYYYMMDD') = TO_CHAR(SYSDATE, 'YYYYMMDD')--today
                            AND NOT EXISTS(SELECT 'yes'
                                              FROM ""order""
                                             WHERE ""order"".ticket_id_fk = tk.ticket_id_pk) --no orders have used that ticket yet
                       ORDER BY sort";
        OracleConnection myConnection = new OracleConnection(ConfigurationManager.ConnectionStrings["SEI_DB_Connection"].ConnectionString);
        OracleCommand myCommand = new OracleCommand(query, myConnection);

        try
        {
            myConnection.Open();
            menu.Load(myCommand.ExecuteReader());

            IEnumerable<string> columnNames = menu.Columns.Cast<DataColumn>().Select(column => column.ColumnName);
            sb.AppendLine(string.Join("-,-", columnNames));
            //AppendLine puts "\r\n" between rows

            foreach (DataRow row in menu.Rows)
            {
                IEnumerable<string> fields = row.ItemArray.Select(field => field.ToString());
                sb.AppendLine(string.Join("-,-", fields));
            }
        }
        catch (Exception ex)
        {
            sb.AppendLine("ERROR");
            sb.AppendLine(ex.Message);
        }
        finally
        {
            myConnection.Close();
            myConnection.Dispose();
        }
        return sb.ToString();
    }
}

/// <summary>
/// The Order_Data class is for simulation purposes and should only be call by transact entities or via web services.
/// </summary>
[WebService(Namespace = "http://csmain.studentnet.int/seproject/PalmsPP/App_Code/Transact.cs")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class Order_Data
{
    #region classes
    private class Webapp_Order
    {
        public string CustomerFirstName;
        public string CustomerLastName;
        public string Cost;
        public string Location;
        public string Time;
        public string TimeSlot;
        public string Type;
        public List<Webapp_Order_Element> Foods;
    }

    private class Webapp_Order_Element
    {
        public string ID;
        public List<Webapp_Detail> Details;
    }

    private class Webapp_Detail
    {
        public string ID;
    }
    #endregion classes


    [WebMethod]
    public string createOrder(string data)
    {
        string webappOrderID = "";
        string currentWebappOrderElementID = "";
        string result = "";
        JavaScriptSerializer serializer = new JavaScriptSerializer();
        Webapp_Order webappOrder = serializer.Deserialize<Webapp_Order>(data);

        #region queries
        string query_string1 = @"BEGIN :out1 := order_package.placeOrder(p_customer_fname    => :p_customer_fname,
                                                                         p_customer_lname    => :p_customer_lname,
                                                                         p_order_cost        => :p_order_cost,
                                                                         p_order_placed_time => TO_DATE(:p_order_placed_time, 'YYYYMMDD HH24:MI:SS'), --yyyyMMdd HH:mm:ss
                                                                         p_time_slot         => :p_time_slot,           --format:  '##:##-##:##'
                                                                         p_location_text     => :p_location_text); END;";

        string query_string2 = @"BEGIN :out2 := order_element_package.createOrderElement(p_food_id_fk          => :p_food_id_fk,
                                                                                         p_order_id_fk         => :p_order_id_fk,
                                                                                         p_order_element_ready => :p_order_element_ready); END;";

        string query_string3 = @"BEGIN :out3 := order_detail_package.createOrderDetail(p_order_element_id_fk => :p_order_element_id_fk,
                                                                                       p_detail_id_fk        => :p_detail_id_fk); END;";
        #endregion queries
        OracleConnection myConnection = new OracleConnection(ConfigurationManager.ConnectionStrings["SEI_DB_Connection"].ConnectionString);
        //OracleTransaction j = myConnection.BeginTransaction();
        OracleCommand myCommand1 = new OracleCommand(query_string1, myConnection);
        OracleCommand myCommand2 = new OracleCommand(query_string2, myConnection);
        OracleCommand myCommand3 = new OracleCommand(query_string3, myConnection);

        try
        {
            myConnection.Open();
            #region create order, create order elements, and order elements details
            try
            {
                myCommand1.Parameters.Add("out1", OracleDbType.Varchar2, ParameterDirection.Output).Size = 100;
                myCommand1.Parameters.Add("p_customer_fname",    webappOrder.CustomerFirstName);
                myCommand1.Parameters.Add("p_customer_lname",    webappOrder.CustomerLastName);
                myCommand1.Parameters.Add("p_order_cost",        webappOrder.Cost);
                myCommand1.Parameters.Add("p_order_placed_time", webappOrder.Time);
                myCommand1.Parameters.Add("p_time_slot",         webappOrder.TimeSlot);
                myCommand1.Parameters.Add("p_location_text",     webappOrder.Location.Replace("-apo-", "'"));
                myCommand1.ExecuteNonQuery();

                webappOrderID = myCommand1.Parameters["out1"].Value.ToString();
                result += "Pass:" + webappOrderID;

                #region create order elements and order elements details
                foreach (Webapp_Order_Element food in webappOrder.Foods)
                {
                    try
                    {
                        myCommand2.Parameters.Clear();
                        myCommand2.Parameters.Add("out2", OracleDbType.Int32, ParameterDirection.Output);
                        myCommand2.Parameters.Add("p_food_id_fk",          food.ID);
                        myCommand2.Parameters.Add("p_order_id_fk",         webappOrderID.Split(":,".ToCharArray())[1].Trim(" \"".ToCharArray()));
                        myCommand2.Parameters.Add("p_order_element_ready", "N");
                        myCommand2.ExecuteNonQuery();

                        currentWebappOrderElementID = myCommand2.Parameters["out2"].Value.ToString();
                        result += "\n\nPass";

                        #region create order[ elements] details
                        foreach (Webapp_Detail detail in food.Details)
                        {
                            try
                            {
                                myCommand3.Parameters.Clear();
                                myCommand3.Parameters.Add("out3", OracleDbType.Int32, ParameterDirection.Output);
                                myCommand3.Parameters.Add("p_detail_id_fk",        detail.ID);
                                myCommand3.Parameters.Add("p_order_element_id_fk", currentWebappOrderElementID);
                                myCommand3.ExecuteNonQuery();

                                result += "\n\nPass";
                            }
                            catch (Exception ex)
                            {
                                result += "\n\nERROR with Detail\n" + ex.Message;
                            }
                            finally
                            {
                                try
                                {
                                    myCommand3.Dispose();
                                }
                                catch { }
                            }
                        }
                        #endregion create order elements details
                    }
                    catch (Exception ex)
                    {
                        result += "\n\nERROR with Element\n" + ex.Message;
                    }
                    finally
                    {
                        try
                        {
                            myCommand2.Dispose();
                        }
                        catch { }
                    }
                }
                #endregion create order elements and order elements details
            }
            catch (Exception ex)
            {
                result += "ERROR with Order\n" + ex.Message;
            }
            finally
            {
                try
                {
                    myCommand1.Dispose();
                }
                catch { }
            }
            #endregion create order, create order elements, and order elements details
        }
        catch (Exception ex)
        {
            result += "ERROR\n" + ex.Message;
        }
        finally
        {
            myConnection.Close();
            myConnection.Dispose();
        }

        if(result.Contains("ERROR"))
        {
            result = "Fail:" + result.Replace("Pass:", "") + ".";
            if (result.Contains("ORA-20002") || result.Contains("ORA-20001"))
            {
                result = "Fail:" + result.Substring(result.IndexOf(":",10) + 1);
            }
        }

        return result;
    }
}