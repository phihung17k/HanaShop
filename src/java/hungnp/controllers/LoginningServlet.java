/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hungnp.controllers;

import hungnp.daos.UserDAO;
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
@WebServlet(name = "LoginningServlet", urlPatterns = {"/LoginServlet"})
public class LoginningServlet extends HttpServlet {
    private static final String FILE_NOT_FOUND_PAGE="/fileNotFound.jsp";
    private static final String HOME_PAGE="/home.jsp";
    private static final String SHOP_PAGE="/shop.jsp";
    private static final String LOGIN_PAGE="/login.jsp";
    private static final String ITEM_PAGE="/item.jsp";
    private static final String ADMIN_TABLE_CONTROLLER="/AdminTableServlet";
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private String convertPageName(String pageName){
        String page="";
        if(pageName.equals("homePage")){
            page=HOME_PAGE;
        }else if(pageName.equals("shopPage")){
            page=SHOP_PAGE;
        }else if(pageName.equals("itemPage")){
            page=ITEM_PAGE;
        }
        return page;
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String userId= request.getParameter("userId");
        String password= request.getParameter("password");
        String url=FILE_NOT_FOUND_PAGE;
        try {
            if(userId != null && password != null){
                UserDAO userDAO = new UserDAO();
                boolean result = userDAO.checkLogin(userId, password);
                if (result) {
                    HttpSession session = request.getSession();
                    String pageBeforeLogin = (String) session.getAttribute("pageBeforeLogin");
                    String role = userDAO.getRole(userId);
                    if (role.equals("admin")) {
                        url = ADMIN_TABLE_CONTROLLER;
                    } else if (role.equals("user")) {
                        url = convertPageName(pageBeforeLogin);
                    }
                    if (pageBeforeLogin == null) {
                        url = HOME_PAGE;
                    }
                    String fullname = userDAO.getFullnameFromUserId(userId);
                    session.setAttribute("fullname", fullname);
                    session.setAttribute("userId", userId);
                    session.setAttribute("role", role);
                    session.setAttribute("isAdmin", role.equals("admin"));
                } else {
                    request.setAttribute("loginFail", "UserID or Password is not existed!!!");
                    request.setAttribute("userId", userId);
                    url=LOGIN_PAGE;
                }
            }
            if(url.contains(".jsp")){
                url="/WEB-INF/view"+url;
            }
        } catch (Exception e) {
            log("LoginServlet_processRequest:"+e.getMessage());
        }finally{
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



























































































































