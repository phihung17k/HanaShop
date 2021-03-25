<%-- 
    Document   : adminTable
    Created on : Jan 18, 2021, 8:47:12 AM
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
        <title>HanaShop - Admin</title>
        <link href="css/admin_styles.css" rel="stylesheet" type="text/css"/>
        <link href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css" rel="stylesheet" crossorigin="anonymous" />
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
                        </div>
                    </div>
                </nav>
            </div>
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid">
                        <h1 class="mt-4">Tables</h1>
                        
                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-table mr-1"></i>
                                Data Table
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-bordered" width="100%" cellspacing="0">
                                        <thead>
                                            <tr style="text-align: center">
                                                <th>Name</th>
                                                <th>Image</th>
                                                <th>Price</th>
                                                <th>Category</th>
                                                <th>Quantity</th>
                                                <th>Expiration Date</th>
                                                <th>Status</th>
                                                <th>Update</th>
                                                <th>Delete</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:set var="mapListItemAdmin" value="${sessionScope.mapListItemAdmin}"/>
                                            <c:if test="${not empty mapListItemAdmin}">
                                            <form action="remove" method="POST">
                                                <c:forEach var="map" items="${mapListItemAdmin}">
                                                    <c:set var="item" value="${map.key}"/>
                                                    <tr style="text-align: center;">
                                                        <td>${item.itemName}</td>
                                                        <td><img src="images/${item.image}" style="width: 40px; height: 40px;"/></td>
                                                        <td>${item.price}</td>
                                                        <td>${item.category}</td>
                                                        <td>${item.quantity}</td>
                                                        <td>${item.expirationDate}</td>
                                                        <td>${item.status}</td>
                                                        <td>
                                                            <a href="updateItemPage?itemId=${item.itemId}" style="text-decoration: none;"> 
                                                                    Update
                                                            </a>
                                                        </td>
                                                        <td style="text-align: center;">
                                                            <c:if test="${map.value == true}">
                                                                <input type="checkbox" name="selectedItem" value="${item.itemId}"/>
                                                            </c:if>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                                    <tr>
                                                        <td colspan="8"></td>
                                                        <td style="text-align: center;">
                                                            <input type="submit" value="Remove" 
                                                                   onclick="return confirm('Do you want remove this item in your cart?')"/>
                                                        </td>
                                                    </tr>
                                            </form>
                                            </c:if>
                                            <c:if test="${empty mapListItemAdmin}">
                                                <p>Don't have item in list</p>
                                            </c:if>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <ul class="pagination">
                            <c:set var="numOfPage" value="${sessionScope.numOfPageAdmin}"/>
                            <c:forEach begin="1" end="${numOfPage}" step="1" varStatus="counter">
                                <li class="page-item" style="background-color: #03a9f4;">
                                    <a class="page-link" href="adminTablePage?page=${counter.count}">${counter.count}</a>
                                </li>
                            </c:forEach>
                        </ul>             
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
        <script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js" crossorigin="anonymous"></script>
        <script src="js/datatables-demo.js" type="text/javascript"></script>
    </body>
</html>
