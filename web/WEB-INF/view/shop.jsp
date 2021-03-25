<%-- 
    Document   : shop
    Created on : Jan 11, 2021, 10:57:05 AM
    Author     : Win 10
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <title>HanaShop - Shop</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
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
        <!--pop-up-box-->
        <!--<link href="css/popuo-box.css" rel="stylesheet" type="text/css" media="all" />-->
        <!--//pop-up-box-->
        <!-- price range -->
        <link rel="stylesheet" type="text/css" href="css/jquery-ui1.css">
        <!-- fonts -->
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i,800" rel="stylesheet">
    </head>
    <body>
        <c:set var="fullname" value="${sessionScope.fullname}"/>
        <c:set var="isAdmin" value="${sessionScope.isAdmin}"/>
        <div class="header-bot">
            <div class="header-bot_inner_wthreeinfo_header_mid">
                <div class="col-md-4 logo_agile">
                    <h1>
                        <a href="homePage">
                            <span>H</span>ana
                            <span>S</span>hop
                            <img src="images/logo2.png" alt=" ">
                        </a>
                    </h1>
                </div>
                <div class="col-md-8 header">
                    <ul>
                        <c:if test="${empty fullname}">
                            <li style="border: 1px solid royalblue; padding:auto 0px auto 0px;">    
                                <a href="loginPage?pageBeforeLogin=shopPage" >
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
        <div class="page-head_agile_info_w3l">
        </div>
        <!-- page -->
        <div class="services-breadcrumb">
            <div class="agile_inner_breadcrumb">
                <div class="container">
                    <ul class="w3_short">
                        <li>
                            <a href="homePage">Home</a>
                            <i>|</i>
                        </li>
                        <li>Shopping Products</li>
                    </ul>
                </div>
            </div>
        </div>
        <!-- //page -->
        <!-- top Products -->
        <div class="ads-grid">
            <div class="container">
                <!-- tittle heading -->
                <h3 class="tittle-w3l">Shopping Products
                    <span class="heading-style">
                        <i></i>
                        <i></i>
                        <i></i>
                    </span>
                </h3>
                <!-- //tittle heading -->
                <!-- product left -->
                <div class="side-bar col-md-3">
                    <form action="search" method="POST">
                        <input class="w3-btn w3-block w3-orange" type="submit" value="Search">
                        <div class="search-hotel">
                            <h3 class="agileits-sear-head">Search Here..</h3>
                            <input type="search" placeholder="Product name..." name="search" value="${sessionScope.searchValue}">
                        </div>
                        <!-- price range -->
                        <div class="range">
                            <h3 class="agileits-sear-head">Price range</h3>
                            <ul class="dropdown-menu6">
                                <li>
                                    <div id="slider-range"></div>
                                    <input type="text" id="amount" style="border: 0; color: #ffffff; font-weight: normal;" name="range"/>
                                </li>
                            </ul>
                        </div>
                        <!-- //price range -->
                        <!-- food preference -->
                        <div class="left-side">
                            <h3 class="agileits-sear-head">Category</h3>
                            <ul>
                                <c:set var="listCategory" value="${sessionScope.listCategory}"/>
                                <c:forEach var="category" items="${listCategory}">
                                    <c:set var="checkedCategory" value="${sessionScope.checkedCategory}"/>
                                    <c:if test="${checkedCategory eq category}">
                                        <li>
                                            <input type="radio" class="checked" name="itemCategory" value="${category}" checked="checked">
                                            <span class="span">${category}</span>
                                        </li>
                                    </c:if>
                                    <c:if test="${checkedCategory ne category}">
                                        <li>
                                            <input type="radio" class="checked" name="itemCategory" value="${category}">
                                            <span class="span">${category}</span>
                                        </li>
                                    </c:if>
                                </c:forEach>
                            </ul>
                        </div>
                    </form>
                    <c:if test="${not empty fullname && isAdmin == false}">
                        <form action="viewCart">
                            <input class="w3-btn w3-block w3-orange" type="submit" value="View Your Cart">
                        </form>
                    </c:if>
                    <!-- //food preference -->
                </div>
                <!-- //product left -->
                <!-- product right -->
                <div class="agileinfo-ads-display col-md-9 w3l-rightpro">
                    <div class="wrapper">
                        <!-- first section -->
                        <div class="product-sec1">
                            <c:set var="listItem" value="${sessionScope.listItem}"/>
                            <c:if test="${not empty listItem}">
                                <c:forEach var="item" items="${listItem}"> 
                                    <div class="col-xs-4 product-men" style="margin-bottom: 10px;">
                                        <div class="men-pro-item simpleCart_shelfItem">
                                            <div class="men-thumb-item">
                                                <img src="images/${item.image}" alt="">
                                            </div>
                                            <div class="item-info-product ">
                                                <h4>
                                                    <a href="itemPage?itemId=${item.itemId}">${item.itemName}</a>
                                                </h4>
                                                <p>Remain: ${item.quantity}</p>
                                                <p>Expire: ${item.expirationDate}</p>
                                                <div class="info-product-price">
                                                    <span class="item_price">${item.price}VND/${item.unit}</span>
                                                </div>
                                                <c:if test="${not empty fullname && isAdmin == false}">
                                                    <div class="snipcart-details top_brand_home_details item_add single-item hvr-outline-out">
                                                        <form action="addToCart" method="POST">
                                                            <fieldset>
                                                                <input type="hidden" name="itemId" value="${item.itemId}" />
                                                                <input type="submit" name="submit" value="Add to cart" class="button" />
                                                            </fieldset>
                                                        </form>
                                                    </div>
                                                </c:if>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:if>
                            <c:if test="${empty listItem}">
                                <h3>Sorry, no product matching your selection was found</h3>
                            </c:if>
                            <div class="clearfix"></div>
                        </div>
                        <!-- //first section -->
                    </div>
                        <ul class="pagination">
                            <c:set var="searchValue" value="${sessionScope.searchValue}"/>
                            <c:set var="maxMoney" value="${sessionScope.maxMoney}"/>
                            <c:set var="checkedCategory" value="${sessionScope.checkedCategory}"/>
                            
                            <c:set var="numOfPage" value="${sessionScope.numOfPage}"/>
                            <c:forEach begin="1" end="${numOfPage}" step="1" varStatus="counter">
                                <c:if test="${(not empty searchValue) or (not empty maxMoney) or (not empty checkedCategory)}"><!--search-->
                                    <li class="page-item" style="background-color: #03a9f4;">
                                        <a class="page-link" href="search?page=${counter.count}">${counter.count}</a>
                                    </li>
                                </c:if>
                                <c:if test="${(empty searchValue) and ( empty maxMoney) and ( empty checkedCategory)}"><!--shopPage-->
                                    <li class="page-item" style="background-color: #03a9f4;">
                                        <a class="page-link" href="shopPage?page=${counter.count}">${counter.count}</a>
                                    </li>
                                </c:if>
                            </c:forEach>
                        </ul>
                    
                </div>
                <!-- //product right -->
            </div>
        </div>
        <!-- //top products -->
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
        <script src="js/jquery-ui.js"></script>
        <script>
            //<![CDATA[ 
            $(window).load(function () {
                $("#slider-range").slider({
                    range: true,
                    min: 0,
                    max: 500000,
                    <c:set var="minMoney" value="${sessionScope.minMoney}"/>
                    <c:set var="maxMoney" value="${sessionScope.maxMoney}"/>
                    <c:if test="${not empty minMoney and not empty maxMoney}">
                        values: [${minMoney}, ${maxMoney}],
                    </c:if>
                    <c:if test="${empty minMoney or empty maxMoney}">
                        values: [0, 500000],
                    </c:if>
                    slide: function (event, ui) {
                        $("#amount").val(ui.values[0] + "VND" + " - " + ui.values[1] + "VND");
                    }
                });
                $("#amount").val($("#slider-range").slider("values", 0) + "VND" + " - " + $("#slider-range").slider("values", 1) + "VND");

            }); //]]>
        </script>
        <!-- //price range (top products) -->
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
        <!-- //end-smooth-scrolling -->
        <!-- for bootstrap working -->
        <script src="js/bootstrap.js"></script>
        <!-- //for bootstrap working -->
    </body>
</html>
