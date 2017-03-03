using System;
using System.Web.UI.WebControls;

public partial class Choices : System.Web.UI.Page
{
    Order myOrder;

    protected void Page_Load(object sender, EventArgs e)
    {
        if(Session["order"] != null)
        {
            myOrder = (Order)Session["order"];
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
                if (myOrder == null)
                {
                    myOrder = new Order(getType());
                }

                myOrder.Order_Elements.Add(new Order_Element(FoodID));
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