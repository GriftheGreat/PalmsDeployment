using System;
using System.IO;
using System.Data;
using System.Linq;
using System.Configuration;
using Oracle.DataAccess.Client;
using System.Web.UI.WebControls;

public partial class ManagerUI : System.Web.UI.Page
{
    #region Properties
    private DataTable _dt;
    private string imgEditPath;

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
        string query_string           = @"SELECT   * 
                                              FROM food
                                          ORDER BY food_name";
        OracleConnection myConnection = new OracleConnection(ConfigurationManager.ConnectionStrings["SEI_DB_Connection"].ConnectionString);
        OracleCommand myCommand       = new OracleCommand(query_string, myConnection);

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
            dt = Get_Food();
            GridView1.DataSource = dt;
            GridView1.DataBind();
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
        // Get the image path for remove old image after update record
        Image imgEditPhoto  = GridView1.Rows[e.NewEditIndex].FindControl("imgPhoto") as Image;
        imgEditPath = imgEditPhoto.ImageUrl;
        // Get the current row index for edit record
        GridView1.EditIndex = e.NewEditIndex;
        FillGridView();
    }

    /// <summary>
    /// Cancel the operation (e.g. edit)
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void cancelRecord(object sender, GridViewCancelEditEventArgs e)
    {
        GridView1.EditIndex = -1;
        FillGridView();
    }

    /// <summary>
    /// Add new row into DataTable if no record found in Table
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void AddNewRecord(object sender, EventArgs e)
    {
        try
        {
            if (dt.Rows.Count > 0)
            {
                GridView1.EditIndex = -1;
                GridView1.ShowFooter = true;
                FillGridView();
            }
            else
            {
                GridView1.ShowFooter = true;
                DataRow dr = dt.NewRow();
                dr["Name"]                = "0";
                dr["Description"]         = 0;
                dr["Cost"]                = 0;
                dr["IsDeliverable"]       = "0";
                dr["photopath"]           = "0";
                dt.Rows.Add(dr);
                GridView1.DataSource      = dt;
                GridView1.DataBind();
                GridView1.Rows[0].Visible = false;
            }
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
        GridView1.ShowFooter = false;
        FillGridView();
    }

    /// <summary>
    /// Insert New Record
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void InsertNewRecord(object sender, EventArgs e)
    {
        try
        {
            string strName = dt.Rows[0]["name"].ToString();
            if (strName == "0")
            {
                dt.Rows[0].Delete();
                // GlobalClass.adap.Update(dt);   An OracleDataApater created to "push" changes up to the database.
            }
            TextBox txtName          = GridView1.FooterRow.FindControl("txtNewName") as TextBox;
            TextBox txtDescr         = GridView1.FooterRow.FindControl("txtNewDescr") as TextBox;
            TextBox txtCost          = GridView1.FooterRow.FindControl("txtNewCost") as TextBox;
            TextBox txtIsDeliverable = GridView1.FooterRow.FindControl("txtNewIsDeliverable") as TextBox;
            FileUpload fuPhoto       = GridView1.FooterRow.FindControl("fuNewPhoto") as FileUpload;
            Guid FileName            = Guid.NewGuid();
            fuPhoto.SaveAs(Server.MapPath("~/Includes/images/" + FileName));
            DataRow dr               = dt.NewRow();
            dr["name"]               = txtName.Text.Trim();
            dr["descr"]              = txtDescr.Text.Trim();
            dr["cost"]               = txtCost.Text.Trim();
            dr["photopath"]          = "~/Includes/Images/" + FileName;
            dt.Rows.Add(dr);
            dt.AcceptChanges();
            GridView1.ShowFooter = false;
            FillGridView();
        }
        catch
        {
            Response.Write("<script> alert('Record not added...') </script>");
        }

    }
    /// <summary>
    /// Update the record
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void updateRecord(object sender, GridViewUpdateEventArgs e)
    {
        try
        {
            TextBox txtName          = GridView1.Rows[e.RowIndex].FindControl("txtName") as TextBox;
            TextBox txtAge           = GridView1.Rows[e.RowIndex].FindControl("txtAge") as TextBox;
            TextBox txtCost          = GridView1.Rows[e.RowIndex].FindControl("txtCost") as TextBox;
            TextBox txtIsDeliverable = GridView1.Rows[e.RowIndex].FindControl("txtIsDeliverable") as TextBox;
            FileUpload fuPhoto       = GridView1.Rows[e.RowIndex].FindControl("fuPhoto") as FileUpload;
            Guid FileName            = Guid.NewGuid();
            if (fuPhoto.FileName != "")
            {
                fuPhoto.SaveAs(Server.MapPath("~/Images/" + FileName + ".png"));
                dt.Rows[GridView1.Rows[e.RowIndex].RowIndex]["photopath"] = "~/Images/" + FileName + ".png";
                File.Delete(Server.MapPath(imgEditPath));
            }
            dt.Rows[GridView1.Rows[e.RowIndex].RowIndex]["name"]           = txtName.Text.Trim();
            dt.Rows[GridView1.Rows[e.RowIndex].RowIndex]["age"]            = Convert.ToInt32(txtAge.Text.Trim());
            dt.Rows[GridView1.Rows[e.RowIndex].RowIndex]["cost"]           = Convert.ToInt32(txtCost.Text.Trim());
            dt.Rows[GridView1.Rows[e.RowIndex].RowIndex]["is deliverable"] = txtIsDeliverable.Text.Trim();
            dt.AcceptChanges();
            GridView1.EditIndex = -1;
            FillGridView();
        }
        catch
        {
            Response.Write("<script> alert('Record updation fail...') </script>");
        }
    }

    /// <summary>
    /// Delete Record
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        try
        {
            dt.Rows[GridView1.Rows[e.RowIndex].RowIndex].Delete();
            dt.AcceptChanges();
            // Get the image path for removing deleted's record image from server folder
            Image imgPhoto = GridView1.Rows[e.RowIndex].FindControl("imgPhoto") as Image;
            File.Delete(Server.MapPath(imgPhoto.ImageUrl));
            FillGridView();
        }
        catch
        {
            Response.Write("<script> alert('Record not deleted...') </script>");
        }
    }
}