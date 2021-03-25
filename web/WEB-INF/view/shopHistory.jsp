<%-- 
    Document   : shopHistory
    Created on : Jan 17, 2021, 8:40:42 AM
    Author     : Win 10
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Shop History Page</title>
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
        <!--date-->
        <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" 
              integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
        <script src="https://unpkg.com/gijgo@1.9.13/js/gijgo.min.js" type="text/javascript"></script>
        <link href="https://unpkg.com/gijgo@1.9.13/css/gijgo.min.css" rel="stylesheet" type="text/css" />
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
                                <p style="color: #219ff3">Hello, ${sessionScope.fullname}</p>
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
                        <li>Shop History</li>
                    </ul>
                </div>
            </div>
        </div>
        <!-- //page -->
        <!-- checkout page -->
        <div class="privacy">
            <div class="container">
                <!-- tittle heading -->
                <h3 class="tittle-w3l">Shop History
                    <span class="heading-style">
                        <i></i>
                        <i></i>
                        <i></i>
                    </span>
                </h3>
                <form action="searchHistory" method="POST">
                    <div class="search-hotel">
                        <input type="date" max="${sessionScope.maxDate}" name="date" value="${sessionScope.currentDate}"/>
                        <!--<input id="datepicker" type="" width="270px" readonly="" value="" name="date"/>-->
                        <c:if test="${not empty sessionScope.errorDate}">
                            <p style="color: #cf0000">${sessionScope.errorDate}</p>
                        </c:if>
                        <input type="search" placeholder="Product name..." name="search" value="${sessionScope.searchHistory}"/>
                        <input class="w3-btn w3-block w3-orange" type="submit" value="Search"/>
                    </div>
                </form>
                <div class="checkout-right">
                    <div class="table-responsive">
                        <c:set var="listPurchasedItem" value="${sessionScope.listPurchasedItem}"/>
                        <c:if test="${not empty listPurchasedItem}">
                            <table class="timetable_sub">
                                <thead>
                                    <tr>
                                        <th>Invoice Id</th>
                                        <th>Item Name</th>
                                        <th>Price</th>
                                        <th>Buy Time</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="item" items="${listPurchasedItem}"><!--map như mảng 2 chiều-->
                                        <tr class="rem1">
                                            <td class="invert">${item.invoiceId}</td>
                                            <td class="invert">${item.itemName}</td> <!--Name-->
                                            <td class="invert">${item.itemPrice}</td>
                                            <td class="invert">${item.buyTime}</td><!--Price-->
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:if>
                        <c:if test="${empty listPurchasedItem}">
                            <p style="font-size: 20px; color: #cf0000;">Your shopping history is empty!!!</p>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
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
        <script>
            $('#datepicker').datepicker({
                uiLibrary: 'bootstrap'
            });
        </script>
        <script src="js/jquery-2.1.4.min.js"></script>
        <script src="js/move-top.js"></script>
        <script src="js/bootstrap.js"></script>
    </body>
</html>
