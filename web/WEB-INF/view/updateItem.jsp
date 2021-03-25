<%-- 
    Document   : updateItem
    Created on : Jan 20, 2021, 7:51:56 AM
    Author     : Win 10
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>HanaShop - Admin Update</title>
        <link href="css/admin_styles.css" rel="stylesheet" type="text/css"/>
        <!--<link href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css" rel="stylesheet" crossorigin="anonymous" />-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/js/all.min.js" crossorigin="anonymous"></script>
    </head>
    <body class="sb-nav-fixed">
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <a class="navbar-brand" href="homePage">HanaShop</a>
            <button class="btn btn-link btn-sm order-1 order-lg-0" id="sidebarToggle" href="#"><i class="fas fa-bars"></i></button>
            <!-- Navbar Search-->
            <form class="d-none d-md-inline-block form-inline ml-auto mr-0 mr-md-3 my-2 my-md-0">
               
            </form>
            <!-- Navbar-->
            <ul class="navbar-nav ml-auto ml-md-0">
                <li class="nav-item dropdown">
                    <c:set var="fullname" value="${sessionScope.fullname}"/>
                    <a class="nav-link dropdown-toggle" id="userDropdown" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
                    <div class="dropdown-menu dropdown-menu-right" aria-labelledby="userDropdown">
                        
                        <a class="dropdown-item" href="#">${fullname}</a>
                        <div class="dropdown-divider"></div>
                        <form action="logout" method="POST">
                            <a class="dropdown-item" href="logout">Logout</a>
                        </form>
                    </div>
                </li>
            </ul>
        </nav>
        <div id="layoutSidenav">
            <div id="layoutSidenav_nav">
                <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                    <div class="sb-sidenav-menu">
                        <div class="nav">
                            <a class="nav-link" href="shopPage">
                                <div class="sb-nav-link-icon"><i class="fas fa-chart-area"></i></div>
                                Shop Page
                            </a>
                            <a class="nav-link" href="createPage">
                                <div class="sb-nav-link-icon"><i class="fas fa-chart-area"></i></div>
                                Create Item
                            </a>
                            <a class="nav-link" href="adminTablePage">
                                <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
                                Tables
                            </a>
                            <a class="nav-link" href="createPage">
                                <div class="sb-nav-link-icon"><i class="fas fa-chart-area"></i></div>
                                Create Item
                            </a>
                        </div>
                    </div>
                </nav>
            </div>
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid">
                        <h1 class="mt-4">Update Item</h1>
                        <div class="card mb-4">
                            <c:set var="item" value="${sessionScope.itemForUpdate}"/>
                            <c:set var="error" value="${sessionScope.error}"/>
                            <form action="updateItem" method="POST" enctype="multipart/form-data">
                                Item Name: <input type="text" name="itemName" value="${item.itemName}" />
                                <c:if test="${not empty error.nameEmptyError}">
                                    <p style="color: tomato">${error.nameEmptyError}</p>
                                </c:if>
                                <br/><br/>
                                Image: <img src="images/${item.image}" style="width: 50px; height: 50px;"/>
                                <input type="file" name="fileImage" value="" accept="png|jpg"/><br/><br/>
                                Price: <input type="text" name="price" value="${item.price}" />
                                <c:if test="${not empty error.priceEmptyError}">
                                    <p style="color: tomato">${error.priceEmptyError}</p>
                                </c:if>
                                <c:if test="${not empty error.priceInputInvalidError}">
                                    <p style="color: tomato">${error.priceInputInvalidError}</p>
                                </c:if>
                                <br/><br/>
                                <div>Category: 
                                    <select name="category">
                                        <c:forEach var="category" items="${sessionScope.listCategory}">
                                                <option value="${category}">${category}</option>
                                        </c:forEach>
                                    </select>
                                </div><br/>
                                Quantity: <input type="text" name="quantity" value="${item.quantity}" />
                                <c:if test="${not empty error.quantityEmptyError}">
                                    <p style="color: tomato">${error.quantityEmptyError}</p>
                                </c:if>
                                <c:if test="${not empty error.quantityInputInvalidError}">
                                    <p style="color: tomato">${error.quantityInputInvalidError}</p>
                                </c:if>
                                <br/><br/>
                                Expiration Date: 
                                <input type="date" name="exDate" value="${sessionScope.expirationDate}" />
                                <c:if test="${not empty error.dateLessCurrentDateError}">
                                    <p style="color: tomato">${error.dateLessCurrentDateError}</p>
                                </c:if>
                                <br/>
                                <div>Status:
                                    <select name="status">
                                        <c:forEach var="status" items="${sessionScope.listStatus}">
                                                <option value="${status}">${status}</option>
                                        </c:forEach>
                                    </select>
                                </div><br/>
                                <input type="hidden" name="itemId" value="${item.itemId}" />
                                <input type="submit" value="Update" />
                            </form>           
                        </div>
                    </div>
                </main>
                <footer class="py-4 bg-light mt-auto">
                    <div class="container-fluid">
                        <div class="d-flex align-items-center justify-content-between small">
                            <div class="text-muted">Copyright &copy; Your Website 2020</div>
                        </div>
                    </div>
                </footer>
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="js/admin_scripts.js" type="text/javascript"></script>
    </body>
</html>

