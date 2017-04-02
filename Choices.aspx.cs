using System;
using System.Collections;
using System.Collections.Generic;
using System.Web.UI.WebControls;

public partial class Choices : System.Web.UI.Page
{

    #region Properties
     
    public int meal_index = 0;
    public string[] meals = new string[] {"Breakfast", "Lunch & Dinner" };

    private Order _myOrder;
    public Order MyOrder
    {
        get
        {
            return Session["order"] != null ? (Order)Session["order"] : null;
        }
        set
        {
            Session["order"] = value;
        }
    }
    #endregion

    protected void Page_Load(object sender, EventArgs e)
    {
        rptMeals.DataSource = meals;
        rptMeals.DataBind();

        if (Session["order"] != null)
        {
            MyOrder = (Order)Session["order"];
        }
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        string FoodIDtext = ((sender as Button).NamingContainer.FindControl("hidFoodID") as HiddenField).Value;
        int    FoodID;

        if (!string.IsNullOrEmpty(FoodIDtext))
        {
            if (Int32.TryParse(FoodIDtext, out FoodID) && FoodID > 0)
            {
                if (MyOrder == null)
                {
                    MyOrder = new Order(getType());
                    MyOrder.Order_Elements = new List<Order_Element>();
                }
                System.Diagnostics.Debug.WriteLine(FoodID);
                //MyOrder.Order_Elements.Add(new Order_Element(FoodID));
                Session["order"] = MyOrder;
            }
            else
            {
                // Error
            }
        }
        else
        {
            // Error
        }
    }

    private string getType()
    {
        return "Deliverable";
    }
}