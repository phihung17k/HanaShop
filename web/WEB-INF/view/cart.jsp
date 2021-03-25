<%-- 
    Document   : cart
    Created on : Jan 14, 2021, 12:19:49 PM
    Author     : Win 10
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Cart Page</title>
        <!--/tags -->
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
        <!-- fonts -->
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i,800" rel="stylesheet">
        <!--button-->
        <link href="css/button.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <!-- header-bot-->
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
                     <c:set var="fullname" value="${sessionScope.fullname}"/>
                        <c:if test="${not empty fullname}">
                            <form action="logout">
                                <p style="color: #219ff3">Hello, ${fullname}</p>
                                <input type="submit" value="Logout" />
                            </form>
                            <a href="shopHistoryPage">
                                <button style="border: 1px solid royalblue; background-color: #FFC107; color: white">
                                    Shop history
                                </button>
                            </a>    
                        </c:if>
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
                        <li>
                            <a href="shopPage">Shop Page</a>
                            <i>|</i>
                        </li>
                        <li>Cart</li>
                    </ul>
                </div>
            </div>
        </div>
        <!-- //page -->
        <!-- checkout page -->
        <div class="privacy">
            <div class="container">
                <!-- tittle heading -->
                <h3 class="tittle-w3l">Your Cart
                    <span class="heading-style">
                        <i></i>
                        <i></i>
                        <i></i>
                    </span>
                </h3>
                <!-- //tittle heading -->
                <c:set var="emptyCart" value="${emptyCart}"/>
                <c:if test="${empty emptyCart}">
                    <div class="checkout-right">
                        <div class="table-responsive">
                            <table class="timetable_sub">
                                <thead>
                                    <tr>
                                        <th>Item Name</th>
                                        <th>Amount</th>
                                        <th>Price</th>
                                        <th>Total</th>
                                        <th>Remove</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:set var="mapItem" value="${sessionScope.itemsInCart}"/>
                                    <c:forEach var="map" items="${mapItem}"><!--map như mảng 2 chiều-->
                                        <c:set var="item" value="${map.key}"/><!--key: item-->
                                        <tr class="rem1">
                                            <td class="invert-image">${item.itemName}</td> <!--Name-->
                                            <td class="invert">
                                                <div class="quantity">
                                                    <div class="quantity-select">
                                                        <a href="viewCart?itemId=${item.itemId}&sign=minus">
                                                            <div class="entry value-minus">&nbsp;</div>
                                                        </a>
                                                        <div class="entry value">
                                                            <span>${map.value}</span><!--value: quantity-->
                                                        </div>
                                                        <a href="viewCart?itemId=${item.itemId}&sign=plus">
                                                            <div class="entry value-plus">&nbsp;</div>
                                                        </a>
                                                    </div>
                                                </div>
                                            </td>
                                            <td class="invert">${item.price}</td><!--Price-->
                                            <td class="invert">${map.value * item.price}</td><!--total Price of item-->
                                            <td class="invert" >
                                                <div class="rem"> 
                                                    <a href="viewCart?itemId=${item.itemId}&remove=true" 
                                                        onclick="return confirm('Do you want remove this item in your cart?')">
                                                        <div class="close1" >
                                                            <img src="images/delete.png" alt="img" style="width:28px; height: 28px;"/>
                                                        </div>
                                                    </a>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:set var="totalPrice" value="${sessionScope.totalPrice}"/>
                                    <tr>
                                        <td colspan="5" style="font-weight: bold; font-size: 20px">
                                            Total price: ${totalPrice}
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </c:if>
                <c:if test="${not empty emptyCart}">
                    <h3>Your cart is empty!!!</h3>
                </c:if>
                <c:set var="redundantItems" value="${sessionScope.redundantItems}"/>
                <c:if test="${not empty redundantItems}">
                    <h3 style="color: #FF5722"> There's only 
                    <c:forEach var="item" items="${redundantItems}">
                        ${item.value} ${item.key},  
                    </c:forEach>
                    </h3>
                </c:if>
                <a href="shopPage">
                    <button class="button1" style="vertical-align:middle"><span>Buy more</span></button>
                </a>
                <br/>
                <a href="checkout">
                    <button class="button2" style="vertical-align:middle"><span>Checkout</span></button>
                </a>
                
            </div>
        </div>
        <!-- //checkout page -->
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
        <!--quantity-->
        <script>
            $('.value-plus').on('click', function () {
                var divUpd = $(this).parent().find('.value'),
                        newVal = parseInt(divUpd.text(), 10) + 1;
                divUpd.text(newVal);
            });

            $('.value-minus').on('click', function () {
                var divUpd = $(this).parent().find('.value'),
                        newVal = parseInt(divUpd.text(), 10) - 1;
                if (newVal >= 1)
                    divUpd.text(newVal);
            });
        </script>
        <!-- start-smooth-scrolling -->
        <script src="js/move-top.js"></script>
        <!-- for bootstrap working -->
        <script src="js/bootstrap.js"></script>
        <!-- //for bootstrap working -->
        <!-- //js-files -->
    </body>
</html>
