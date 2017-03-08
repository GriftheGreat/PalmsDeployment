<%@ Page Language="C#"
         AutoEventWireup="true"
         CodeFile="Pizza.aspx.cs"
         Inherits="Pizza"
         MasterPageFile="~/Master Pages/Default.Master" %>

<%@ MasterType VirtualPath="~/Master Pages/Default.Master" %>

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="Styles">
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="Scripts">
</asp:Content>

<asp:Content ID="Content" runat="server" ContentPlaceHolderID="Content">
    <!-- Trigger the modal with a button -->
    <button type="button" class="btn btn-info btn-lg modalButton" data-toggle="modal" data-target="#myModal">Create Your Own</button>
    <!-- Modal -->
    <div id="myModal" class="modal fade text-center" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h3 class="modal-title">Create Your Own</h3>
                </div>

                <div class="modal-body">

                    <!-- Sizes -->
                    <h1>Select size:</h1>
                    <span class="sizeEightWrapper">
                        <button class="btn sizeEightButton">8"</button>
                    </span>
                    <span class="sizeSixteenWrapper">
                        <button class="btn sizeSixteenButton">16"</button>
                    </span>

                    <!-- Types -->
                    <!--<h1>Select type:</h1>
                    <span class="cheesePizzaWrapper">
                        <button class="btn cheesePizzaButton">Cheese</button>
                    </span>
                    <span class="sausagePizzaWrapper">
                        <button class="btn sausagePizzaButton">Sausage</button>
                    </span>
                    <span class="peperoniPizzaWrapper">
                        <button class="btn peperoniPizzaButton">Peperoni</button>
                    </span>-->

                    <!-- Toppings -->
                    <h1>Choose Your Toppings:</h1>

                    <h3>Real Meat</h3>
                    <span class="cheesePizzaWrapper">
                        <button class="btn baconToppingButton">Bacon</button>
                    </span>
                    <span class="peperoniPizzaWrapper">
                        <button class="btn peperoniToppingButton">Peperoni</button>
                    </span>
                    <span class="sausageToppingWrapper">
                        <button class="btn sausageToppingButton">Sausage</button>
                    </span>
                    <br />
                    <span class="beefToppingWrapper">
                        <button class="btn beefToppingButton">Beef</button>
                    </span>
                    <span class="italianSausageWrapper">
                        <button class="btn italianSausageToppingButton">Italian Sausage</button>
                    </span>
                    <span class="CanaDianBaconToppingWrapper">
                        <button class="btn canadianBacconToppingButton">Canadian Bacon</button>
                    </span>

                    <h3>Fresh Vegetables</h3>
                    <span class="freshSlicedOnions">
                        <button class="btn freshSlicedOnionsButton">Fresh-Sliced Onions</button>
                    </span>
                    <span class="greenPepper">
                        <button class="btn greenPepperButton">Green Pepper</button>
                    </span>
                    <span class="romaTomatoes">
                        <button class="btn romaTomatoesButton">Roma Tomatoes</button>
                    </span>
                    <span class="blackOlives">
                        <button class="btn blackOlivesButton">Black Olives</button>
                    </span>
                    <br />

                    <span class="jalapenoPeppers">
                        <button class="btn jalapenoPeppersButton">Jalapeno Peppers</button>
                    </span>

                    <span class="bananaPeppers">
                        <button class="btn bananaPeppersButton">Banana Peppers</button>
                    </span>

                    <span class="babyPortabella">
                        <button class="btn babyPortabellaButton">Baby Portabella</button>
                    </span>

                    <span class="mushrooms">
                        <button class="btn mushroomsButton">Mushrooms</button>
                    </span>

                    <div>
                        <button type="button" class="btn btn-danger">Add to Cart</button>
                 </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>