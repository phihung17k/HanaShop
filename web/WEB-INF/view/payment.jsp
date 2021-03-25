<%-- 
    Document   : payment
    Created on : Jan 16, 2021, 10:43:07 AM
    Author     : Win 10
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Grocery Shoppy an Ecommerce Category Bootstrap Responsive Web Template | Payment :: w3layouts</title>
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
        <!--pop-up-box-->
        <!-- price range -->
        <link rel="stylesheet" type="text/css" href="css/jquery-ui1.css">
        <!-- fonts -->
        <link href="//fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i,800" rel="stylesheet">
    </head>

    <body>
        <!-- header-bot-->
        <div class="header-bot">
            <div class="header-bot_inner_wthreeinfo_header_mid">
                <!-- header-bot-->
                <div class="col-md-4 logo_agile">
                    <h1>
                        <a href="homePage">
                            <span>G</span>rocery
                            <span>S</span>hoppy
                            <img src="images/logo2.png" alt=" ">
                        </a>
                    </h1>
                </div>
                <!-- header-bot -->
                <div class="col-md-8 header">
                    <!-- header lists -->
                    
                        <c:set var="fullname" value="${sessionScope.fullname}"/>
                        <c:if test="${not empty fullname}">
                            <form action="logout">
                                <p style="color: #219ff3">Hello, ${sessionScope.fullname}</p>
                                <input type="submit" value="Logout" />
                            </form>
                            <a href="shopHistoryPage"><button style="border: 1px solid royalblue; background-color: #FFC107; color: white">
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
                        <li>
                            <a href="cartPage">Home</a>
                            <i>|</i>
                        </li>
                        <li>Payment</li>
                    </ul>
                </div>
            </div>
        </div>
        <!-- //page -->
        <!-- payment page-->
        <div class="privacy">
            <div class="container">
                <!-- tittle heading -->
                <h3 class="tittle-w3l">Payment
                    <span class="heading-style">
                        <i></i>
                        <i></i>
                        <i></i>
                    </span>
                </h3>
                <!-- //tittle heading -->
                <div class="checkout-right">
                    <!--Horizontal Tab-->
                    <div id="parentHorizontalTab">
                        <ul class="resp-tabs-list hor_1">
                            <li>Cash on delivery (COD)</li>
                            <!--<li>Paypal Account</li>-->
                        </ul>
                        <div class="resp-tabs-container hor_1">

                            <div>
                                <div class="vertical_post check_box_agile">
                                    <h5>COD</h5>
                                    <form action="payment">
                                        Address:
                                        <input type="text" name="address" value="${sessionScope.address}" />
                                        <c:set var="addressFail" value="${sessionScope.addressFail}"/>
                                        <c:if test="${not empty addressFail}">
                                            <p style="color: red">${addressFail}</p>
                                        </c:if>
                                        <input type="submit" value="Confirm" />
                                    </form>
                                </div>
                            </div>
                            <!--paypal--------------------->
<!--                            <div>
                                <div id="tab4" class="tab-grid" style="display: block;">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <img class="pp-img" src="images/paypal.png" alt="Image Alternative text" title="Image Title">
                                            <p>Important: You will be redirected to PayPal's website to securely complete your payment.</p>
                                            <a class="btn btn-primary">Checkout via Paypal</a>
                                        </div>
                                        <div class="col-md-6 number-paymk">
                                            <form class="cc-form">
                                                <div class="clearfix">
                                                    <div class="form-group form-group-cc-number">
                                                        <label>Card Number</label>
                                                        <input class="form-control" placeholder="xxxx xxxx xxxx xxxx" type="text">
                                                        <span class="cc-card-icon"></span>
                                                    </div>
                                                    <div class="form-group form-group-cc-cvc">
                                                        <label>CVV</label>
                                                        <input class="form-control" placeholder="xxxx" type="text">
                                                    </div>
                                                </div>
                                                <div class="clearfix">
                                                    <div class="form-group form-group-cc-name">
                                                        <label>Card Holder Name</label>
                                                        <input class="form-control" type="text">
                                                    </div>
                                                    <div class="form-group form-group-cc-date">
                                                        <label>Valid Thru</label>
                                                        <input class="form-control" placeholder="mm/yy" type="text">
                                                    </div>
                                                </div>
                                                <div class="checkbox checkbox-small">
                                                    <label>
                                                        <input class="i-check" type="checkbox" checked="">Add to My Cards</label>
                                                </div>
                                                <input type="submit" class="submit" value="Proceed Payment">
                                            </form>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>-->
                    </div>
                    <!--Plug-in Initialisation-->
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
        <!-- jquery -->
        <script src="js/jquery-2.1.4.min.js"></script>
        <!-- //jquery -->
        <link rel="stylesheet" type="text/css" href="css/easy-responsive-tabs.css " />
        <script src="js/easyResponsiveTabs.js"></script>
        <script>
            $(document).ready(function () {
                //Horizontal Tab
                $('#parentHorizontalTab').easyResponsiveTabs({
                    type: 'default', //Types: default, vertical, accordion
                    width: 'auto', //auto or any width like 600px
                    fit: true, // 100% fit in a container
                    tabidentify: 'hor_1', // The tab groups identifier
                    activate: function (event) { // Callback function if tab is switched
                        var $tab = $(this);
                        var $info = $('#nested-tabInfo');
                        var $name = $('span', $info);
                        $name.text($tab.text());
                        $info.show();
                    }
                });
            });
        </script>
        <script src="js/move-top.js"></script>
        <script src="js/bootstrap.js"></script>
    </body>
</html>
