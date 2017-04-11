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


    <div id="myCarousel" class="carousel slide" data-interval="3000" data-ride="carousel">
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
<%--         	            <div class="carousel-caption slideShowCaption">
                            <h3>First slide label</h3>
                            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
                        </div>--%>
                    </div>
                    <div class="item carouselWrapper">
                        <img src=<%= "\"" + URL.root(Request) + "Includes/images/slideShow/slide2.jpeg\"" %> alt="second Slide" class="slideImages" />
<%--                        <div class="carousel-caption slideShowCaption">
                            <h3>Second slide label</h3>
                            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
                        </div>--%>
                    </div>
                    <div class="item carouselWrapper">
                        <img src=<%= "\"" + URL.root(Request) + "Includes/images/slideShow/slide3.jpg\"" %> class="slideImages" />
<%--                        <div class="carousel-caption slideShowCaption">
                            <h3>Third slide label</h3>
                            <p>Praesent commodo cursus magna, vel scelerisque nisl consectetur.</p>
                        </div>--%>
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

    <div class="container-fluid bottomInfo">
    <div class="row ">
        <div class="col-sm-4 col-md-4">
            <div class="thumbnail">
                <img src=<%= "\"" + URL.root(Request) + "Includes/images/palmsImage.png\"" %> alt="First Thumbnail" class="firstThumbnail"/>
<%--                <div class="caption">
                    <h3>Thumbnail label</h3>
                    <p>...</p>
                    <%--<p><a href="#" class="btn btn-primary" role="button">Button</a> <a href="#" class="btn btn-default" role="button">Button</a></p>
                </div>--%>
            </div>
        </div>
        <div class="col-sm-4 col-md-4">
            <div class="thumbnail">
                <img src=<%= "\"" + URL.root(Request) + "Includes/images/papaJohnImage.png\"" %> alt="Second Thumbnail" class="secondThumbnail"/>
<%--                <div class="caption">
                    <h3>Thumbnail label</h3>
                    <p>...</p>
                    <p><a href="#" class="btn btn-primary" role="button">Button</a> <a href="#" class="btn btn-default" role="button">Button</a></p>
                </div>--%>
            </div>
        </div>

        <div class="col-sm-4 col-md-4">
            <div class="thumbnail">
                <img src=<%= "\"" + URL.root(Request) + "Includes/images/palmsImage.png\"" %> alt="Third Thumbnail" class="thirdThumbnail"/>
            </div>
        </div>
    </div>
</div>



</asp:Content>