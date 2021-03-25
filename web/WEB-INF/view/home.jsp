<%-- 
    Document   : home
    Created on : Jan 6, 2021, 9:11:38 PM
    Author     : Win 10
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <title>HanaShop - Home</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <script>
            addEventListener("load", function () {
                setTimeout(hideURLbar, 0);
            }, false);

            function hideURLbar() {
                window.scrollTo(0, 1);
            }
        </script>
        <link href="css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
        <link href="css/style.css" rel="stylesheet" type="text/css" media="all" />
        <link href="css/font-awesome.css" rel="stylesheet">
        <!--<link href="css/popuo-box.css" rel="stylesheet" type="text/css" media="all" />-->
        <link rel="stylesheet" type="text/css" href="css/jquery-ui1.css"/>
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i,800" rel="stylesheet"/>
    </head>
    <body
        <div class="header-bot">
            <div class="header-bot_inner_wthreeinfo_header_mid">
                <div class="col-md-4 logo_agile">
                    <h1>
                        <a href="index.html">
                            <span>H</span>ana
                            <span>S</span>hop
                            <img src="images/logo2.png" alt=" ">
                        </a>
                    </h1>
                </div>
                <div class="col-md-8 header">
                    <ul>
                        <c:set var="fullname" value="${sessionScope.fullname}"/>
                        <c:if test="${empty fullname}">
                            <li style="border: 1px solid royalblue; padding:auto 0px auto 0px;">    
                                <a href="loginPage?pageBeforeLogin=homePage" >
                                    <span class="fa fa-unlock-alt" aria-hidden="true"></span> Sign In </a>
                            </li>
                        </c:if>
                        <c:if test="${not empty fullname}">
                            <form action="logout">
                                <p style="color: #219ff3">Hello, ${sessionScope.fullname}</p>
                                <input type="submit" value="Logout" />
                            </form>
                            <c:set var="isAdmin" value="${sessionScope.isAdmin}"/>
                            <c:if test="${isAdmin == false}">
                                <a href="shopHistoryPage">
                                    <button style="border: 1px solid royalblue; background-color: #FFC107; color: white">
                                        Shop history
                                    </button>
                                </a>  
                            </c:if>
                            <c:if test="${isAdmin == true}">
                                <a href="adminTablePage" style="text-decoration: none;">
                                    <button style="background-color: #FFC107; color: #000;">
                                        Return admin table page
                                    </button>
                                </a>
                            </c:if>
                        </c:if>
                    </ul>
                    <div class="clearfix"></div>
                </div>
                <div class="clearfix"></div>
            </div>
        </div>
        <div id="myCarousel" class="carousel slide" data-ride="carousel">
            <ol class="carousel-indicators">
                <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                <li data-target="#myCarousel" data-slide-to="1" class=""></li>
                <li data-target="#myCarousel" data-slide-to="2" class=""></li>
                <li data-target="#myCarousel" data-slide-to="3" class=""></li>
            </ol>
            <div class="carousel-inner" role="listbox">
                <div class="item active">
                    <div class="container">
                        <div class="carousel-caption">
                            <h3>Big
                                <span>Save</span>
                            </h3>
                            <p>Get flat
                                <span>10%</span> Cashback</p>
                            <a class="button2" href="shopPage">Shop Now </a>
                        </div>
                    </div>
                </div>
                <div class="item item2">
                    <div class="container">
                        <div class="carousel-caption">
                            <h3>Healthy
                                <span>Saving</span>
                            </h3>
                            <p>Get Upto
                                <span>30%</span> Off</p>
                            <a class="button2" href="shopPage">Shop Now </a>
                        </div>
                    </div>
                </div>
                <div class="item item3">
                    <div class="container">
                        <div class="carousel-caption">
                            <h3>Big
                                <span>Deal</span>
                            </h3>
                            <p>Get Best Offer Upto
                                <span>20%</span>
                            </p>
                            <a class="button2" href="shopPage">Shop Now </a>
                        </div>
                    </div>
                </div>
                <div class="item item4">
                    <div class="container">
                        <div class="carousel-caption">
                            <h3>Today
                                <span>Discount</span>
                            </h3>
                            <p>Get Now
                                <span>40%</span> Discount</p>
                            <a class="button2" href="shopPage">Shop Now </a>
                        </div>
                    </div>
                </div>
            </div>
            <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
                <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                <span class="sr-only">Previous</span>
            </a>
            <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
                <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                <span class="sr-only">Next</span>
            </a>
        </div>
        <footer>
            <div class="container">
                <p class="footer-main">
                    <span>"HanaShop"</span> is a place to fill your emotions with new foods, drinks and experiences</p>
            </div>
        </footer>
        <div class="copy-right">
            <div class="container">
                <p>© 2021 HanaShop. All rights reserved | Design by
                    <a href="http://w3layouts.com"> W3layouts.</a>
                </p>
            </div>
        </div>
        <script src="js/jquery-2.1.4.min.js"></script>
        <script>
            jQuery(document).ready(function ($) {
                $(".scroll").click(function (event) {
                    event.preventDefault();

                    $('html,body').animate({
                        scrollTop: $(this.hash).offset().top
                    }, 1000);
                });
            });
        </script>
        <script src="js/bootstrap.js"></script>
    </body>
</html>
