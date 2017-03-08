using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;

public partial class PapaJohns : System.Web.UI.Page
{
    #region Properties
    public Order MyOrder
    {
        get
        {
            return Session["order"] != null ? (Order)Session["order"] : null;
        }
        set
        {
            Session["order"] = value;
            Session["orderItemNumber"] = value.Order_Elements != null ? value.Order_Elements.Count.ToString() : "0";
        }
    }
    #endregion

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        Order  tempOrder = MyOrder;
        string FoodIDtext = ((sender as Button).NamingContainer.FindControl("hidFoodID") as HiddenField).Value;
        int FoodID;

        if (!string.IsNullOrEmpty(FoodIDtext))
        {
            if (Int32.TryParse(FoodIDtext, out FoodID) && FoodID > 0)
            {
                if (tempOrder == null)
                {
                    tempOrder = new Order(getType());
                    tempOrder.Order_Elements = new List<Order_Element>();
                }

                tempOrder.Order_Elements.Add(new Order_Element(FoodID));
                MyOrder = tempOrder;
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