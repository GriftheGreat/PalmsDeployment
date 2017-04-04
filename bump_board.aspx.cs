using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Oracle.DataAccess.Client;
using System.Configuration;


[System.Web.Script.Services.ScriptService]
public partial class _Bump_Board : Page
{
    public enum window_display
    {
        FRONT_WINDOW,
        BACK_WINDOW,
        ICE_CREAM,
        FRIER,
        SALAD,
        PIZZA,
    };
    protected void Page_Load(object sender, EventArgs e)
    {
        string output = get_more_orders(8, 1);
        this.litOrder_boxes.Text = output;
    }

    [WebMethod]
    public static void bump_order(int order_id)
    {
        string query_string = @"UPDATE ""order"" 
                                   SET order_status = 'Y'
                                 WHERE order_id_pk = " + order_id.ToString();
        OracleConnection myConnection = new OracleConnection(ConfigurationManager.ConnectionStrings["SEI_DB_Connection"].ConnectionString);
        OracleCommand myCommand = new OracleCommand(query_string, myConnection);
        try
        {
            myConnection.Open();
            try
            {
                myCommand.ExecuteNonQuery();
                query_string = "COMMIT";
                myCommand.ExecuteNonQuery();
            }
            catch { }
            finally
            {
                try
                {
                    myCommand.Dispose();
                }
                catch { }
            }
        }
        catch (Exception ex)
        {

        }
        finally
        {
            myConnection.Close();
            myConnection.Dispose();
        }
    }

    [WebMethod]
    public static string get_more_orders(int order_number_boundary, int window_number)
    {
        int order_box_number = 0;
        DataTable data = new DataTable();
        DataTable data2 = new DataTable();
        DataTable data3 = new DataTable();
        string output = "";
        string query_string1;
        string query_string2;
        string food_type;
        string query_string;


        switch (window_number)
        {
            case 1:
                food_type = "";
                break;
            case 2:
                food_type = @"AND (food_type_id_pk = 1 
                            OR food_type_id_pk = 2
                            OR food_type_id_pk = 3
                            OR food_type_id_pk = 4
                            OR food_type_id_pk = 5
                            OR food_type_id_pk = 6
                            OR food_type_id_pk = 8
                            OR food_type_id_pk = 9
                            OR food_type_id_pk = 10
                            OR food_type_id_pk = 11)";
                break;
            case 3:
                food_type = "AND food_type_id_pk = 13";
                break;
            case 4:
                food_type = "AND food_type_id_pk = 12";
                break;
            case 5:
                food_type = "AND food_type_id_pk = 7";
                break;
            case 6:
                food_type = @"AND (food_type_id_pk = 14 
                            OR food_type_id_pk = 15
                            OR food_type_id_pk = 16
                            OR food_type_id_pk = 17
                            OR food_type_id_pk = 18)";
                break;
            default:
                food_type = "";
                break;
        }


        query_string = @"SELECT customer_fname, customer_lname, order_num, order_id_pk
                           FROM ""order""
                          WHERE ""order"".order_status = 'N'
                     AND EXISTS (SELECT food_name, order_element_id_pk, food_type_id_pk
                                   FROM food
                                   JOIN order_element
                                     ON order_element.food_id_fk = food.food_id_pk
                                   JOIN food_type
                                     ON food.food_type_id_fk = food_type.food_type_id_pk
                                  WHERE order_id_fk = order_id_pk " + food_type + ")";
        OracleConnection myConnection = new OracleConnection(ConfigurationManager.ConnectionStrings["SEI_DB_Connection"].ConnectionString);
        OracleCommand myCommand = new OracleCommand(query_string, myConnection);

        try
        {
            myConnection.Open();

            #region order
            try
            {
                data.Load(myCommand.ExecuteReader());
            }
            finally
            {
                try
                {
                    myCommand.Dispose();
                }
                catch { }
            }
            data.Constraints.Clear();
            data.Columns["order_id_pk"].AllowDBNull = true;
            for (int index = 1; index <= 8; index++)
            {
                data.Rows.Add(data.NewRow());
            }
                #endregion

                foreach (DataRow row in data.Rows)
                {
                    order_box_number++;
                    output +=
                        @"<div class=""orderBox""><div class=""orderBoxElement"">
                        <div class=""order_info"" order-id="""" >
                            <input type=""hidden"" id=""hid1"" order_id='" + row["order_id_pk"].ToString() + @"' />
                            <span id=""box1"" class=""box_number"">" + order_box_number.ToString() + @"</span>
                            <span class=""order_line"">" + row["customer_fname"].ToString() + @"</span>
                            <span class=""order_line"">" + row["customer_lname"].ToString() + @"</span>
                            <span class=""order_line"">" + row["order_num"].ToString() + @"</span>
                        </div>";

                #region food JOIN order_element
                query_string1 = @"SELECT food_name, order_element_id_pk, food_type_id_pk
                                FROM food
                                JOIN order_element
                                ON order_element.food_id_fk = food.food_id_pk
                                JOIN food_type
                                ON food.food_type_id_fk = food_type.food_type_id_pk
                                WHERE order_element.order_id_fk = :order_id_pk " + food_type;

                OracleCommand myCommand2 = new OracleCommand(query_string1, myConnection);
                myCommand2.Parameters.Add("order_id_pk", row["order_id_pk"].ToString());

                try
                {
                    data2.Clear();
                    data2.Load(myCommand2.ExecuteReader());
                }
                finally
                {
                    try
                    {
                        myCommand2.Dispose();
                    }
                    catch { }
                }
                #endregion

                foreach (DataRow row2 in data2.Rows)
                {
                    output +=
                        @"<div class=""food_item"">
                            <input type=""hidden"" id=""hid2"" order_element_id='" + row2["order_element_id_pk"].ToString() + @"' />                         
                            <span class=""food_line"" > " + row2["food_name"].ToString() + @"</span>
                        </div>";

                    #region detail JOIN order_detail
                    query_string2 = @"SELECT detail_descr
                                    FROM detail
                                    JOIN order_detail
                                    ON order_detail.detail_id_fk = detail.detail_id_pk
                                WHERE order_element_id_fk = :order_element_id_pk";

                    OracleCommand myCommand3 = new OracleCommand(query_string2, myConnection);
                    myCommand3.Parameters.Add("order_element_id_pk", row2["order_element_id_pk"].ToString());
                    try
                    {
                        data3.Clear();
                        data3.Load(myCommand3.ExecuteReader());
                    }
                    finally
                    {
                        try
                        {
                            myCommand3.Dispose();
                        }
                        catch { }
                    }
                    #endregion

                    foreach (DataRow row3 in data3.Rows)
                    {
                        output +=
                            @"<div class=""detail"">
                                <span class=""detail_line"">" + row3["detail_descr"].ToString() + @"</span>                          
                            </div>";
                    }
                }
                output += "</div></div>"; // close orderElementBox and orderBox
            }
        }
        catch (Exception ex)
        {
            output = "<div>Error</div>";
        }
        finally
        {
            myConnection.Close();
            myConnection.Dispose();
        }
        return output;
    }

    protected void Page_Init(object sender, EventArgs e)
    {
    }
}
