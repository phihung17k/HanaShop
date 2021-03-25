<%-- 
    Document   : item
    Created on : Jan 16, 2021, 10:28:22 PM
    Author     : Win 10
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Item Page</title>
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
        <!--//tags -->
        <link href="css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
        <link href="css/style.css" rel="stylesheet" type="text/css" media="all" />
        <link href="css/font-awesome.css" rel="stylesheet">
        <!-- price range -->
        <link rel="stylesheet" type="text/css" href="css/jquery-ui1.css">
        <!-- flexslider -->
        <link rel="stylesheet" href="css/flexslider.css" type="text/css" media="screen" />
        <!-- fonts -->
        <link href="//fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i,800" rel="stylesheet">
    </head>

    <body>
        <!-- //top-header -->
        <!-- header-bot-->
        <div class="header-bot">
            <div class="header-bot_inner_wthreeinfo_header_mid">
                <!-- header-bot-->
                <div class="col-md-4 logo_agile">
                    <h1>
                        <a href="homePage">
                            <span>H</span>ana
                            <span>S</span>hop
                            <img src="images/logo2.png" alt=" ">
                        </a>
                    </h1>
                </div>
                <!-- header-bot -->
                <div class="col-md-8 header">
                    <ul>
                        <c:set var="fullname" value="${sessionScope.fullname}"/>
                        <c:set var="isAdmin" value="${sessionScope.isAdmin}"/>
                        <c:if test="${empty fullname}">
                            <li style="border: 1px solid royalblue;">    
                                <a href="loginPage?pageBeforeLogin=itemPage" >
                                    <span class="fa fa-unlock-alt" aria-hidden="true"></span> Sign In </a>
                            </li>
                        </c:if>
                        <c:if test="${not empty fullname}">
                            <form action="logout">
                                <p style="color: #219ff3">Hello, ${sessionScope.fullname}</p>
                                <input type="submit" value="Logout" />
                            </form>
                            <c:if test="${isAdmin == false}">
                                <a href="shopHistoryPage">
                                    <button style="border: 1px solid royalblue; background-color: #FFC107;color: white">
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
        <!-- shop locator (popup) -->

        <!-- banner-2 -->
        <div class="page-head_agile_info_w3l">

        </div>
        <!-- //banner-2 -->
        <!-- page -->
        <div class="services-breadcrumb">
            <div class="agile_inner_breadcrumb">
                <div class="container">
                    <ul class="w3_short">
                        <li>
                            <a href="homePage">Home</a>
                            <i>|</i>
                        </li>
                        <li>
                            <a href="shopPage">Shop Page</a>
                            <i>|</i>
                        </li>
                        <li>Item Page</li>
                    </ul>
                </div>
            </div>
        </div>
        <!-- //page -->
        <!-- Single Page -->
        <div class="banner-bootom-w3-agileits">
            <div class="container">
                <!-- tittle heading -->
                <h3 class="tittle-w3l">Item Page
                    <span class="heading-style">
                        <i></i>
                        <i></i>
                        <i></i>
                    </span>
                </h3>
                <!-- //tittle heading -->
                <c:set var="item" value="${sessionScope.singleItem}"/>
                <div class="col-md-5 single-right-left ">
                    <div class="grid images_3_of_2">
                        <div class="flexslider">
                            <ul class="slides">
                                <li data-thumb="images/${item.image}">
                                    <div class="thumb-image">
                                        <img src="images/${item.image}" data-imagezoom="true" class="img-responsive" alt=""> </div>
                                </li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                </div>
                <div class="col-md-7 single-right-left simpleCart_shelfItem">
                    <h3>${item.itemName}</h3>
                    <p>
                        <span class="item_price">${item.price}VND/${item.unit}</span>
                    </p>
                    <div class="single-infoagile">
                        <ul>
                            <li>
                                Cash on Delivery Eligible.
                            </li>
                            <li>
                                Shipping Speed to Delivery.
                            </li>
                            <li>
                                The remaining amount is ${item.quantity}
                            </li>
                            <li>
                                Expiration date is ${item.expirationDate}
                            </li>
                        </ul>
                    </div>
                    <div class="product-single-w3l">
                        <p>
                            <i class="fa fa-hand-o-right" aria-hidden="true"></i>Category: 
                            <label>${item.category}</label> </p>
                        <ul>
                            <li>
                               ${item.description}
                            </li>
                        </ul>
                        <p>
                            <i class="fa fa-refresh" aria-hidden="true"></i>All items are
                            <label>non-returnable.</label>
                        </p>
                    </div>
                    <div class="occasion-cart">
                        <c:set var="fullname" value="${sessionScope.fullname}"/>
                        <c:set var="isAdmin" value="${sessionScope.isAdmin}"/>
                        <c:if test="${not empty fullname && isAdmin==false}">
                            <div class="snipcart-details top_brand_home_details item_add single-item hvr-outline-out">
                                <form action="addToCart" method="post">
                                    <fieldset>
                                        <input type="hidden" name="itemId" value="${item.itemId}" />
                                        <input type="hidden" name="thisPage" value="itemPage" />
                                        <input type="submit" name="submit" value="Add to cart" class="button" />
                                    </fieldset>
                                </form>
                            </div>
                        </c:if>
                    </div>
                </div>
                <div class="clearfix"> </div>
            </div>
        </div>
        <!-- //Single Page -->
        <!-- footer -->
        <footer>
            <div class="container">
                <!-- footer first section -->
                <p class="footer-main">
                    <span>"HanaShop"</span> is a place to fill your emotions with new foods, drinks and experiences</p>
            </div>
        </footer>
        <!-- //footer -->
        <!-- copyright -->
        <div class="copy-right">
            <div class="container">
                <p>© 2017 Grocery Shoppy. All rights reserved | Design by
                    <a href="http://w3layouts.com"> W3layouts.</a>
                </p>
            </div>
        </div>
        <!-- //copyright -->

        <!-- js-files -->
        <!-- jquery -->
        <script src="js/jquery-2.1.4.min.js"></script>
        <!-- //jquery -->

        <!-- start-smooth-scrolling -->
        <script src="js/move-top.js"></script>
        <script src="js/easing.js"></script>
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

        <!-- imagezoom -->
        <script src="js/imagezoom.js"></script>
        <!-- //imagezoom -->

        <!-- FlexSlider -->
        <script src="js/jquery.flexslider.js"></script>
        <script>
            // Can also be used with $(document).ready()
            $(window).load(function () {
                $('.flexslider').flexslider({
                    animation: "slide",
                    controlNav: "thumbnails"
                });
            });
        </script>
        <!-- for bootstrap working -->
        <script src="js/bootstrap.js"></script>
        <!-- //for bootstrap working -->
        <!-- //js-files -->

    </body>
</html>
