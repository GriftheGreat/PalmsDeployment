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
            status = rnd.Next(100) < 50 ? "Pass" : "Fail:Balance has insufficient funds."; // 0 <= number < 100

            if (status == "Pass")
            {
                // Retain invoice
                string query_string = "BEGIN :out := TIA_invoice_package.createInvoice(p_order_id_fk => :p_order_id_fk, p_confirmation_status => :p_confirmation_status); END;";
                OracleConnection myConnection = new OracleConnection(ConfigurationManager.ConnectionStrings["SEI_DB_Connection"].ConnectionString);
                OracleCommand myCommand = new OracleCommand(query_string, myConnection);

                try
                {
                    myConnection.Open();
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
        queries[0] = @"SELECT * FROM food";
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
        string webappOrderID = "0";
        string currentWebappOrderElementID = "0";
        string result = "";
        JavaScriptSerializer serializer = new JavaScriptSerializer();
        Webapp_Order webappOrder = serializer.Deserialize<Webapp_Order>(data);

        #region queries
        string query_string1 = @"BEGIN :out := createOrder(p_location_id_fk    => :p_location_id_fk   
                                                           p_ticket_id_fk      => :p_ticket_id_fk     
                                                           p_order_num         => :p_order_num        ;--error order number should be gotten in package by coalesce(max(number of today), 0) + 1
                                                           p_customer_fname    => :p_customer_fname   
                                                           p_customer_lname    => :p_customer_lname   
                                                           p_order_cal_time    => :p_order_cal_time   
                                                           p_order_cost        => :p_order_cost       
                                                           p_order_ready       => :p_order_ready      
                                                           p_order_placed_time => :p_order_placed_time); END;";
        string query_string2 = @"BEGIN :out := createOrder(
                                                           ); END;";
        //createOrderElement(p_food_id_fk          order_element.food_id_fk%TYPE,
        //                   p_order_id_fk         order_element.order_id_fk%TYPE,
        //                   p_order_element_ready order_element.order_element_ready%TYPE)
        //RETURN order_element.order_element_id_pk%TYPE

        //createOrderDetail(p_order_element_id_fk order_detail.order_element_id_fk%TYPE,
        //                  p_detail_id_fk        order_detail.detail_id_fk%TYPE)
        //RETURN order_detail.order_detail_id_pk%TYPE
        string query_string3 = @"BEGIN :out := createOrder(
                                                           ); END;";
        #endregion queries
        OracleConnection myConnection = new OracleConnection(ConfigurationManager.ConnectionStrings["SEI_DB_Connection"].ConnectionString);
        //OracleTransaction j = myConnection.BeginTransaction();
        OracleCommand myCommand1 = new OracleCommand(query_string1, myConnection);
        OracleCommand myCommand2 = new OracleCommand(query_string2, myConnection);
        OracleCommand myCommand3 = new OracleCommand(query_string3, myConnection);

        try
        {
            myConnection.Open();
//?
            #region create order, create order elements, and order elements details
            try
            {
                myCommand1.Parameters.Add("out", OracleDbType.Int32, ParameterDirection.Output);
                myCommand1.Parameters.Add("p_customer_fname",    webappOrder.CustomerFirstName);
                myCommand1.Parameters.Add("p_customer_lname",    webappOrder.CustomerLastName);
                myCommand1.Parameters.Add("p_order_cost",        webappOrder.Cost);
                myCommand1.Parameters.Add("p_order_status",      "N");
                myCommand1.Parameters.Add("p_order_placed_time", webappOrder.Time);
                myCommand1.Parameters.Add("p_location_id_fk",    webappOrder.Location);
                //myCommand1.Parameters.Add("p_ticket_id_fk",      p_ticket_id_fk);
                //myCommand1.Parameters.Add("p_order_num",         p_order_num);
                //myCommand1.Parameters.Add("p_order_cal_time",    p_order_cal_time);
                myCommand1.ExecuteNonQuery();

                webappOrderID = myCommand1.Parameters["out"].Value.ToString();
//???????????????????????
                result += "Pass:";// + myCommand1.Parameters["out"].Value.ToString();

//?
                #region create order elements and order elements details
                foreach (Webapp_Order_Element food in webappOrder.Foods)
                {
                    try
                    {
                        myCommand2.Parameters.Add("out", OracleDbType.Int32, ParameterDirection.Output);
                        myCommand2.Parameters.Add("", food.ID);
                        myCommand2.Parameters.Add("", webappOrderID);
                        myCommand2.ExecuteNonQuery();

                        currentWebappOrderElementID = myCommand2.Parameters["out"].Value.ToString();
//???????????????????????
                        result += "\n\nPass:";// + myCommand2.Parameters["out"].Value.ToString();

//?
                        #region create order[ elements] details
                        foreach (Webapp_Detail detail in food.Details)
                        {
                            try
                            {
                                myCommand3.Parameters.Add("out", OracleDbType.Int32, ParameterDirection.Output);
                                myCommand3.Parameters.Add("", detail.ID);
                                myCommand3.Parameters.Add("", currentWebappOrderElementID);
                                myCommand3.ExecuteNonQuery();

//???????????????????????
                                result += "\n\nPass:";// + myCommand3.Parameters["out"].Value.ToString();
                            }
                            catch (Exception ex)
                            {
                                result += "\n\nERROR\n" + ex.Message;
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
                        result += "\n\nERROR\n" + ex.Message;
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
                result += "ERROR\n" + ex.Message;
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
        return result;
    }
}

//updateOrder(p_order_id_pk       "order".order_id_pk%TYPE,
//deleteOrder(p_order_id_pk "order".order_id_pk%TYPE);
//updateOrderElement(p_order_element_id_pk order_element.order_element_id_pk%TYPE,
//deleteOrderElement(p_order_element_id_pk order_element.order_element_id_pk%TYPE);
//updateOrderDetail(p_order_detail_id_pk order_detail.order_detail_id_pk%TYPE,
//deleteOrderDetail(p_order_detail_id_pk order_detail.order_detail_id_pk%TYPE);
//updateCCI(p_cci_id_pk credit_card_inv.cci_id_pk%TYPE,
//deleteCCI(p_cci_id_pk credit_card_inv.cci_id_pk%TYPE);


//createTimeSlot(p_time_slot_date time_slot.time_slot_date%TYPE,
//updateTimeSlot(p_time_slot_id_pk time_slot.time_slot_id_pk%TYPE,
//deleteTimeSlot(p_time_slot_id_pk time_slot.time_slot_id_pk%TYPE);
//createTicket(p_time_slot_id_fk ticket.time_slot_id_fk%TYPE)
//updateTicket(p_ticket_id_pk ticket.ticket_id_pk%TYPE,
//deleteTicket(p_ticket_id_pk ticket.ticket_id_pk%TYPE);
//
//createLocation(p_location_name  "location".location_name%TYPE,
//updateLocation(p_location_id_pk "location".location_id_pk%TYPE,
//deleteLocation(p_location_id_pk "location".location_id_pk%TYPE);
//createFoodType(p_food_type_name food_type.food_type_name%TYPE,
//updateFoodType(p_food_type_id_pk food_type.food_type_id_pk%TYPE,
//deleteFoodType(p_food_type_id_pk food_type.food_type_id_pk%TYPE);
//createFood(p_food_type_id_fk food.food_type_id_fk%TYPE,
//updateFood(p_food_id_pk food.food_id_pk%TYPE,
//deleteFood(p_food_id_pk food.food_id_pk%TYPE);
//createFoodDetailLine(p_detail_id_fk food_detail_line.detail_id_fk%TYPE,
//updateFoodDetailLine(p_fdl_id_pk food_detail_line.fdl_id_pk%TYPE,
//deleteFoodDetailLine(p_fdl_id_pk food_detail_line.fdl_id_pk%TYPE);
//createDetail(p_detail_descr detail.detail_descr%TYPE,
//updateDetail(p_detail_id_pk detail.detail_id_pk%TYPE,
//deleteDetail(p_detail_id_pk detail.detail_id_pk%TYPE);


public class Database_Queries
{
}

//public void time_slot()
//{
//}

public static class Manager
{
}