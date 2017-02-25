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
                    myOrder = new Order();
                }

                //myOrder.Order_Element.Add(new Order_Element("", "", new List<Detail>, FoodID, "", "", 0.0f));
                //https://github.com/GriftheGreat/PalmsDeployment.git
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
}