/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hungnp.controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Win 10
 */
@WebServlet(name = "DispatcherServlet", urlPatterns = {"/DispatcherServlet", "/homePage","/loginPage", "/shopPage", "/addToCart",
"/checkout", "/itemPage", "/login", "/logout", "/payment", "/searchHistory", "/search", "/shopHistoryPage", "/viewCart",
"/adminTablePage", "/remove", "/updateItemPage", "/updateItem", "/createPage", "/createItem"})
public class DispatcherServlet extends HttpServlet {
    private static final String FILE_NOT_FOUND_PAGE="/fileNotFound.jsp";
    private static final String UNAUTHORIZED_PAGE="/unauthorized.jsp";
    private static final String HOME_PAGE="/home.jsp";
    private static final String LOGIN_PAGE="/login.jsp";
    /*----------------------------------------------------------------------------------------*/
    private static final String ADD_TO_CART_CONTROLLER="/AddToCartServlet";
    private static final String CHECKOUT_CONTROLLER="/CheckoutServlet";
    private static final String ITEM_CONTROLLER="/ItemServlet";
    private static final String LOGIN_CONTROLLER="/LoginServlet";
    private static final String LOGOUT_CONTROLLER="/LogoutServlet";
    private static final String PAYMENT_CONTROLLER="/PaymentSetvlet";
    private static final String SEARCH_HISTORY_CONTROLLER="/SearchHistory";
    private static final String SEARCH_CONTROLLER="/SearchServlet";
    private static final String SHOP_HISTORY_CONTROLLER="/ShopHistoryServlet";
    private static final String SHOP_PAGE_CONTROLLER="/ShopPageServlet";
    private static final String VIEW_CART_CONTROLLER="/ViewCartServlet";
    private static final String ADMIN_TABLE_CONTROLLER="/AdminTableServlet";
    private static final String ADMIN_REMOVE_ITEM_CONTROLLER="/AdminRemoveItemServlet";
    private static final String ADMIN_UPDATE_PAGE_CONTROLLER="/AdminUpdatePageServlet";
    private static final String ADMIN_UPDATE_ITEM_CONTROLLER="/AdminUpdateItemServlet";
    private static final String ADMIN_CREATE_PAGE_CONTROLLER="/AdminCreatePageServlet";
    private static final String ADMIN_CREATE_ITEM_CONTROLLER="/AdminCreateItemServlet";
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url=FILE_NOT_FOUND_PAGE;
        String servletPath= request.getServletPath();
        String resource = servletPath.substring(1);// loginPage
        try {
            HttpSession session= request.getSession();
            String role = (String) session.getAttribute("role");
            if(role==null){
                if (resource.equals("homePage") || resource.equals("DispatcherServlet")) {
                    session.setAttribute("lastPage", request.getParameter("lastPage"));//logout return lastPage
                    url = HOME_PAGE;
                } else if (resource.equals("loginPage")) {
                    session.setAttribute("pageBeforeLogin", request.getParameter("pageBeforeLogin"));
                    url = LOGIN_PAGE;
                }else if (resource.equals("itemPage")) {
                    url = ITEM_CONTROLLER;
                } else if (resource.equals("login")) {
                    url = LOGIN_CONTROLLER;
                } else if (resource.equals("logout")) {
                    url = LOGOUT_CONTROLLER;
                } else if (resource.equals("search")) {
                    url = SEARCH_CONTROLLER;
                } else if (resource.equals("shopPage")) {
                    session.setAttribute("lastPage", request.getParameter("lastPage"));
                    String searchValue = (String) session.getAttribute("searchValue");//Search exist => searched
                    if (searchValue != null) {
                        url = SEARCH_CONTROLLER;
                    } else {
                        url = SHOP_PAGE_CONTROLLER;
                    }
                }
            }else{
                if (resource.equals("homePage") || resource.equals("DispatcherServlet")) {
                    session.setAttribute("lastPage", request.getParameter("lastPage"));//logout return lastPage
                    url = HOME_PAGE;
                } else if (resource.equals("loginPage")) {
                    session.setAttribute("pageBeforeLogin", request.getParameter("pageBeforeLogin"));
                    url = LOGIN_PAGE;
                } else if (resource.equals("addToCart") && role.equals("user")) {
                    url = ADD_TO_CART_CONTROLLER;
                } else if (resource.equals("checkout") && role.equals("user")) {
                    url = CHECKOUT_CONTROLLER;
                } else if (resource.equals("itemPage")) {
                    url = ITEM_CONTROLLER;
                } else if (resource.equals("login")) {
                    url = LOGIN_CONTROLLER;
                } else if (resource.equals("logout")) {
                    url = LOGOUT_CONTROLLER;
                } else if (resource.equals("payment") && role.equals("user")) {
                    url = PAYMENT_CONTROLLER;
                } else if (resource.equals("searchHistory") && role.equals("user")) {
                    url = SEARCH_HISTORY_CONTROLLER;
                } else if (resource.equals("search")) {
                    url = SEARCH_CONTROLLER;
                } else if (resource.equals("shopHistoryPage") && role.equals("user")) {
                    url = SHOP_HISTORY_CONTROLLER;
                } else if (resource.equals("shopPage")) {
                    session.setAttribute("lastPage", request.getParameter("lastPage"));
                    String searchValue = (String) session.getAttribute("searchValue");//Search exist => searched
                    if (searchValue != null) {
                        url = SEARCH_CONTROLLER;
                    } else {
                        url = SHOP_PAGE_CONTROLLER;
                    }
                } else if ((resource.equals("viewCart") || resource.equals("cartPage")) && role.equals("user")) {
                    url = VIEW_CART_CONTROLLER;
                } else if (resource.equals("adminTablePage") && role.equals("admin")) {
                    url = ADMIN_TABLE_CONTROLLER;
                } else if (resource.equals("remove") && role.equals("admin")) {
                    url = ADMIN_REMOVE_ITEM_CONTROLLER;
                }else if (resource.equals("updateItemPage") && role.equals("admin")){
                    url= ADMIN_UPDATE_PAGE_CONTROLLER;
                }else if(resource.equals("updateItem") && role.equals("admin")){
                    url= ADMIN_UPDATE_ITEM_CONTROLLER;
                }else if(resource.equals("createPage") && role.equals("admin")){
                    url= ADMIN_CREATE_PAGE_CONTROLLER;
                }else if(resource.equals("createItem") && role.equals("admin")){
                    url= ADMIN_CREATE_ITEM_CONTROLLER;
                }
                
                boolean roleAllowed=false;
                if(resource.equals("addToCart") && !role.equals("user")){
                    roleAllowed=true;
                }else if (resource.equals("checkout") && !role.equals("user")) {
                    roleAllowed=true;
                }else if (resource.equals("payment") && !role.equals("user")) {
                    roleAllowed=true;
                } else if (resource.equals("searchHistory") && !role.equals("user")) {
                    roleAllowed=true;
                } else if (resource.equals("shopHistoryPage") && !role.equals("user")) {
                    roleAllowed=true;
                }else if ((resource.equals("viewCart") || resource.equals("cartPage")) && !role.equals("user")) {
                    roleAllowed=true;
                } else if (resource.equals("adminTablePage") && !role.equals("admin")) {
                    roleAllowed=true;
                } else if (resource.equals("remove") && !role.equals("admin")) {
                    roleAllowed=true;
                }else if (resource.equals("updateItemPage") && !role.equals("admin")){
                   roleAllowed=true;
                }else if(resource.equals("updateItem") && !role.equals("admin")){
                    roleAllowed=true;
                }else if(resource.equals("createPage") && !role.equals("admin")){
                    roleAllowed=true;
                }else if(resource.equals("createItem") && !role.equals("admin")){
                    roleAllowed=true;
                }
                if(roleAllowed){
                    url=UNAUTHORIZED_PAGE;
                }
            }
            if(url.contains(".jsp")){
                url="/WEB-INF/view"+url;
            }
        }catch(Exception e){
            log("DispatcherServlet_processRequest:"+e.getMessage());
        }finally{
//            System.out.println("dis:"+url);
            this.getServletContext().getRequestDispatcher(url).forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}












































































































































































































































































































































































































































