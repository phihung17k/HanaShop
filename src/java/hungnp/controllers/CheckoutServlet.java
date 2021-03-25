/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hungnp.controllers;

import hungnp.cart.CartObject;
import hungnp.daos.ItemDAO;
import hungnp.daos.UserDAO;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

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
@WebServlet(name = "CheckoutServlet", urlPatterns = {"/CheckoutServlet"})
public class CheckoutServlet extends HttpServlet {
    private static final String CART_PAGE="/cart.jsp";
    private static final String PAYMENT_PAGE="/payment.jsp";
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
        String url=CART_PAGE;
        try {
            HttpSession session= request.getSession();
            session.removeAttribute("redundantItems");
            if(session.getAttribute("cart") != null){
                CartObject cart = (CartObject) session.getAttribute("cart");
                Map<String, Integer> items = cart.getItems();
                if(items!=null){
                    ItemDAO itemDAO= new ItemDAO();
                    Map<String, Integer> redundantItems= new HashMap<>();
                    for (String itemId : items.keySet()) {
                        ArrayList properties = itemDAO.getRealQuantityAndNameItem(itemId, items.get(itemId));
                        if(properties!=null){
                            redundantItems.put((String)properties.get(0), (int)properties.get(1));
                        }
                    }
                    if(redundantItems.size()>0){
                        session.setAttribute("redundantItems", redundantItems);
                    }else{
                        UserDAO userDAO= new UserDAO();
                        String userId =(String) session.getAttribute("userId");
                        if(userId!=null){
                            String address = userDAO.getAddressUser(userId);
                            session.setAttribute("address", address);
                            url = PAYMENT_PAGE;
                        }
                    }
                }
            }
            url="/WEB-INF/view"+url;
        } catch (Exception e) {
            log("CheckoutServlet_processRequest:"+e.getMessage());
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
















































