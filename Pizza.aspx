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
                        <input type="button" class="btn sizeEightButton" id="eightBtn" value="8" onclick="myFunction()" />
                    </span>
                    <span class="sizeSixteenWrapper">
                        <input type="button" class="btn sizeSixteenButton" id="sixteenBtn" value="16" onclick="myFunction()" />
                    </span>

                    <!-- Toppings -->
                    <h1>Choose Your Toppings:</h1>

                    <h3>Real Meat</h3>
                    <span class="cheesePizzaWrapper">
                        <input type="button" class="btn baconToppingButton" id="cheeseBtn" value="Cheese" onclick="myFunction()"/>
                    </span>
                    <span class="peperoniPizzaWrapper">
                        <input type="button" class="btn peperoniToppingButton" id="peperoniBtn" value="Peperoni" onclick="myFunction()"/>
                    </span>
                    <span class="sausageToppingWrapper">
                        <input type="button" class="btn sausageToppingButton" id="sausageBtn" value="Sausage" onclick="myFunction()"/>
                    </span>
                    <br />
                    <span class="beefToppingWrapper">
                        <button class="btn beefToppingButton">Beef</button>
                        <input type="button" class="btn beefToppingButton" id="beefBtn" value="Beef" onclick="myFunction()"/>
                    </span>
                    <span class="italianSausageWrapper">
                        <input type="button" class="btn italianSausageToppingButton" id="italianSausageBtn" value="Italian Sausage" onclick="myFunction()"/>
                    </span>
                    <span class="CanaDianBaconToppingWrapper">
                        <input type="button" class="btn canadianBacconToppingButton" id="canadianBacconBtn" value="Canadian Sausage" onclick="myFunction()"/>
                    </span>

                    <h3>Fresh Vegetables</h3>
                    <span class="freshSlicedOnions">
                        <button class="btn freshSlicedOnionsButton">Fresh-Sliced Onions</button>
                        <input type="button" class="btn freshSlicedOnionsButton" id="freshSliceOnionsBtn" value="Fresh Sliced Onions" onclick="myFunction()"/>

                    </span>
                    <span class="greenPepper">
                        <input type="button" class="btn greenPepperButton" id="greenPepperBtn" value="Green Pepper" onclick="myFunction()"/>
                    </span>
                    <span class="romaTomatoes">
                        <input type="button" class="btn romaTomatoesButton" id="romaTomatoesBtn" value="Roma Tomatoes" onclick="myFunction()"/>
                    </span>
                    <span class="blackOlives">
                        <input type="button" class="btn blackOlivesButton" id="blackOlivesBtn" value="Black Olives" onclick="myFunction()"/>
                    </span>
                    <br />

                    <span class="jalapenoPeppers">
                        <input type="button" class="btn jalapenoPeppersButton" id="jalapenoPeppersBtn" value="Jalapeno Peppers" onclick="myFunction()"/>
                    </span>

                    <span class="bananaPeppers">
                        <input type="button" class="btn bananaPeppersButton" id="bananaPeppersBtn" value="Banana Peppers" onclick="myFunction()"/>
                    </span>

                    <span class="babyPortabella">
                        <input type="button" class="btn babyPortabellaButton" id="babyPortabellaBtn" value="Baby Portabella" onclick="myFunction()"/>
                    </span>

                    <span class="mushrooms">
                        <input type="button" class="btn mushroomsButton" id="mushroomsBtn" value="Mushrooms" onclick="myFunction()"/>
                    </span>

                    <div>
                        <button type="button" class="btn btn-danger">Add to Cart</button>
                 </div>
                </div>
            </div>
        </div>
    </div>

    <%-- Jacob, Here's where the script to handle the button listener --%>
    <script>
        function myFunction() {
            var x = document.getElementById("mushroomsBtn").value;

            //document.getElementById("demo").innerHTML = x;

            window.alert(x);
    }
</script>
</asp:Content>

