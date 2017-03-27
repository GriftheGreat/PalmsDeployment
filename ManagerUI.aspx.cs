using System;
using System.IO;
using System.Data;
using System.Configuration;
using Oracle.DataAccess.Client;
using System.Web.UI.WebControls;

public partial class ManagerUI : System.Web.UI.Page
{
    #region Properties
    private DataTable _dt;

    public DataTable dt
    {
        get
        {
            return Session["Food_Table"] != null ? (DataTable)Session["Food_Table"] : null;
        }
        set
        {
            Session["Food_Table"] = value;
        }
    }
    #endregion

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Food_Table"] != null)
        {
            dt = (DataTable)Session["Food_Table"];
        }
        if (!IsPostBack)
        {
            // Call FillGridView Method
            FillGridView();
        }
    }

    public DataTable Get_Food()
    {
        DataTable data = new DataTable();
        string query_string = @"SELECT   * 
                                          FROM     food
                                          ORDER BY food_name";
        OracleConnection myConnection = new OracleConnection(ConfigurationManager.ConnectionStrings["SEI_DB_Connection"].ConnectionString);
        OracleCommand myCommand = new OracleCommand(query_string, myConnection);

        try
        {
            myConnection.Open();
            data.Load(myCommand.ExecuteReader());
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
        return data;
    }
    /// <summary>
    /// Fill record into GridView
    /// </summary>
    public void FillGridView()
    {
        try
        {
            FoodGrid.DataSource = dt = Get_Food();
            FoodGrid.DataBind();
        }
        catch
        {
            Response.Write("<script> alert('Connection String Error...') </script>");
        }
    }
    /// <summary>
    /// Edit record
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void editRecord(object sender, GridViewEditEventArgs e)
    {
        // Get the current row index for edit record
        FoodGrid.EditIndex = e.NewEditIndex;
        FillGridView();
    }

    /// <summary>
    /// Cancel the operation (e.g. edit)
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void cancelRecord(object sender, GridViewCancelEditEventArgs e)
    {
        FoodGrid.EditIndex = -1;
        FillGridView();
    }

    /// <summary>
    /// Controls button that adds a record
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void AddNewRecord(object sender, EventArgs e)
    {
        try
        {
            FoodGrid.EditIndex = -1;
            FoodGrid.ShowFooter = true;
            FillGridView();
        }
        catch
        {
            Response.Write("<script> alert('Row not added in DataTable...') </script>");
        }
    }

    /// <summary>
    /// Cancel new added record
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void AddNewCancel(object sender, EventArgs e)
    {
        FoodGrid.ShowFooter = false;
        FillGridView();
    }

    /// <summary>
    /// Controls the button that finalizes the record addition
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void InsertNewRecord(object sender, EventArgs e)
    {
        // Retrive new changes from text boxes
        TextBox txtNewName = FoodGrid.FooterRow.FindControl("txtNewName") as TextBox;
        DropDownList insertFoodTypeDDL = FoodGrid.FooterRow.FindControl("insertFoodTypeDDL") as DropDownList;
        TextBox txtNewDescr = FoodGrid.FooterRow.FindControl("txtNewDescr") as TextBox;
        TextBox txtNewCost = FoodGrid.FooterRow.FindControl("txtNewCost") as TextBox;
        TextBox txtNewIsDeliverable = FoodGrid.FooterRow.FindControl("txtNewIsDeliverable") as TextBox;
        TextBox NewPhoto = FoodGrid.FooterRow.FindControl("NewPhoto") as TextBox;

        // Update database and rebind DataTable
        string query_string = @"BEGIN :out := food_package.createFood(p_food_type_id_fk => :p_food_type_id_fk,
                                                                      p_food_name       => :p_food_name,
                                                                      p_food_descr      => :p_food_descr,
                                                                      p_food_cost       => :p_food_cost,
                                                                      p_is_deliverable  => :p_is_deliverable,
                                                                      p_image_path      => :p_image_path); END;";

        OracleConnection myConnection = new OracleConnection(ConfigurationManager.ConnectionStrings["SEI_DB_Connection"].ConnectionString);
        OracleCommand myCommand = new OracleCommand(query_string, myConnection);
        try
        {
            myConnection.Open();
            myCommand.Parameters.Add("out", OracleDbType.Int32, ParameterDirection.Output);
            myCommand.Parameters.Add("p_food_type_id_fk", insertFoodTypeDDL.SelectedValue);
            myCommand.Parameters.Add("p_food_name", txtNewName.Text.Trim());
            myCommand.Parameters.Add("p_food_descr", txtNewDescr.Text.Trim());
            myCommand.Parameters.Add("p_food_cost", Convert.ToDecimal(txtNewCost.Text.Trim()));
            myCommand.Parameters.Add("p_is_deliverable", txtNewIsDeliverable.Text.Trim());
            myCommand.Parameters.Add("p_image_path", NewPhoto.Text.Trim());
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
        FoodGrid.ShowFooter = false;
        FillGridView();
    }

    /// <summary>
    /// Update the record
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void updateRecord(object sender, GridViewUpdateEventArgs e)
    {
        // Create fields with current data
        TextBox txtName = FoodGrid.Rows[e.RowIndex].FindControl("txtName") as TextBox;
        DropDownList FoodTypeDDL = FoodGrid.Rows[e.RowIndex].FindControl("newFoodTypeDDL") as DropDownList;
        TextBox txtDescr = FoodGrid.Rows[e.RowIndex].FindControl("txtDescr") as TextBox;
        TextBox txtCost = FoodGrid.Rows[e.RowIndex].FindControl("txtCost") as TextBox;
        TextBox txtIsDeliverable = FoodGrid.Rows[e.RowIndex].FindControl("txtIsDeliverable") as TextBox;
        TextBox txtPhotoPath = FoodGrid.Rows[e.RowIndex].FindControl("Photo") as TextBox;

        // Update database and rebind DataTable
        string query_string = @"BEGIN food_package.updateFood(p_food_id_pk      => :p_food_id_pk,
                                                              p_food_type_id_fk => :food_type_id_fk,
                                                              p_food_name       => :p_food_name,
                                                              p_food_descr      => :p_food_descr,
                                                              p_food_cost       => :p_food_cost,
                                                              p_is_deliverable  => :p_is_deliverable,
                                                              p_image_path      => :p_image_path); END;";
        OracleConnection myConnection = new OracleConnection(ConfigurationManager.ConnectionStrings["SEI_DB_Connection"].ConnectionString);
        OracleCommand myCommand = new OracleCommand(query_string, myConnection);
        try
        {
            myConnection.Open();
            myCommand.Parameters.Add("p_food_id_pk", dt.Rows[FoodGrid.Rows[e.RowIndex].RowIndex]["food_id_pk"]);
            myCommand.Parameters.Add("p_food_type_id_fk", FoodTypeDDL.SelectedValue);
            myCommand.Parameters.Add("p_food_name", txtName.Text.Trim());
            myCommand.Parameters.Add("p_food_descr", txtDescr.Text.Trim());
            myCommand.Parameters.Add("p_food_cost", Convert.ToDecimal(txtCost.Text.Trim()));
            myCommand.Parameters.Add("p_is_deliverable", txtIsDeliverable.Text.Trim());
            myCommand.Parameters.Add("p_image_path", txtPhotoPath.Text.Trim());
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
        FoodGrid.EditIndex = -1;

        // Refresh the UI display
        FillGridView();
    }

    /// <summary>
    /// Delete Record
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        string query_string = @"BEGIN food_package.deleteFood(p_food_id_pk => :p_food_id_pk); END;";
        OracleConnection myConnection = new OracleConnection(ConfigurationManager.ConnectionStrings["SEI_DB_Connection"].ConnectionString);
        OracleCommand myCommand = new OracleCommand(query_string, myConnection);
        try
        {
            myConnection.Open();
            myCommand.Parameters.Add("p_food_id_pk", dt.Rows[FoodGrid.Rows[e.RowIndex].RowIndex]["food_id_pk"]);
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
        FillGridView();
    }
}