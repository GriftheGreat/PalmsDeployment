<%@ Page Language="C#"
         AutoEventWireup="true"
         CodeFile="Default.aspx.cs"
         Inherits="_Default"
         MasterPageFile="~/Master Pages/Default.Master" %>

<%@ MasterType VirtualPath="~/Master Pages/Default.Master" %>

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="Styles">
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="Scripts">
</asp:Content>

<asp:Content ID="Content" runat="server" ContentPlaceHolderID="Content">


    <div id="myCarousel" class="carousel slide" data-interval="4000" data-ride="carousel">
    	<!-- Carousel indicators -->
        <ol class="carousel-indicators">
            <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
            <li data-target="#myCarousel" data-slide-to="1"></li>
            <li data-target="#myCarousel" data-slide-to="2"></li>
        </ol>  
            <%--<div class="carouselWrapper">--%>
        <div class="carousel-inner">
             
                    <div class="item active carouselWrapper">
                        <img src=<%= "\"" + URL.root(Request) + "Includes/images/slideShow/slide1.jpg\"" %> alt="First Slide" class="slideImages" />
                        <div class="carousel-caption slideShowCaption">
                            <h2>Fresh Garden Food</h2>
                            <p>Food is good for you, so why not enjoy it to the fullest. - Ralph Etienne</p>
                        </div>
                    </div>
                    <div class="item carouselWrapper">
                        <img src=<%= "\"" + URL.root(Request) + "Includes/images/slideShow/slide2.jpeg\"" %> alt="second Slide" class="slideImages" />
                        <div class="carousel-caption slideShowCaption">
                            <h2>Fresh Garden Salad</h2>
                            <p>"What a yummy, fresh, freedom in a bowl..." - Unknown</p>
                        </div>
                    </div>
                    <div class="item carouselWrapper">
                        <img src=<%= "\"" + URL.root(Request) + "Includes/images/slideShow/slide3.jpg\"" %> class="slideImages" />
                        <div class="carousel-caption slideShowCaption">
                            <h2>Fresh Garden Pizza</h2>
                            <p>"We all need to make time for a pizza once in a while..." - Unknown</p>
                        </div>
                    </div>
            </div>
         <%--</div>--%>
        <!-- Carousel controls -->
        <a class="carousel-control left" href="#myCarousel" data-slide="prev">
            <span class="glyphicon glyphicon-chevron-left"></span>
        </a>
        <a class="carousel-control right" href="#myCarousel" data-slide="next">
            <span class="glyphicon glyphicon-chevron-right"></span>
        </a>
    </div>

    



</asp:Content>