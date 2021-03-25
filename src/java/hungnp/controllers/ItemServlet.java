/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hungnp.controllers;

import hungnp.cart.CartObject;
import hungnp.daos.ItemDAO;
import hungnp.dtos.ItemDTO;
import java.io.IOException;
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
@WebServlet(name = "ItemServlet", urlPatterns = {"/ItemServlet"})
public class ItemServlet extends HttpServlet {
    private static final String FILE_NOT_FOUND_PAGE="/fileNotFound.jsp";
    private static final String ITEM_PAGE="/item.jsp";
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
        String url = FILE_NOT_FOUND_PAGE;
        try {
            String itemId = request.getParameter("itemId");
            if(itemId!=null){
                ItemDAO itemDAO = new ItemDAO();
                ItemDTO item = itemDAO.getAllInfoItemFromItemID(itemId);
                if(item!=null){
                    HttpSession session = request.getSession();
                    CartObject cart = (CartObject) session.getAttribute("cart");
                    if(cart!=null){
                        Map<String, Integer> items = cart.getItems();
                        if(items!=null){
                            if(items.containsKey(itemId)){
                                item.setQuantity(item.getQuantity() - items.get(itemId));
                            }
                        }
                    }
                    session.setAttribute("singleItem", item);
                    url=ITEM_PAGE;
                }
            }
            url="/WEB-INF/view"+url;
        } catch (Exception e) {
            log("ItemServlet_processRequest:"+e.getMessage());
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














