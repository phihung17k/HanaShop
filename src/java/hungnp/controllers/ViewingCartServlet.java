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
@WebServlet(name = "ViewingCartServlet", urlPatterns = {"/ViewCartServlet"})
public class ViewingCartServlet extends HttpServlet {
    private static final String FILE_NOT_FOUND_PAGE="/fileNotFound.jsp";
    private static final String CART_PAGE="/cart.jsp";
    /**View
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
        try{
            HttpSession session= request.getSession();
            if(session.getAttribute("cart") != null){
                CartObject cart =(CartObject) session.getAttribute("cart");
                /*----------------------REMOVE ITEM---------------------------*/
                String allowedDeletion= request.getParameter("remove");
                String removedItemId = request.getParameter("itemId");
                if(allowedDeletion!=null && removedItemId != null){
                    if (allowedDeletion.equals("true")) {
                        cart.removeItem(removedItemId);
                    }
                }
                /*----------------------END - REMOVE ITEM---------------------------*/
                Map<String, Integer> items= cart.getItems();
                if(items!=null){
                    session.removeAttribute("emptyCart");
                    ItemDAO itemDAO= new ItemDAO();
                    Map<ItemDTO, Integer> mapItem = new HashMap<>();//value: quantity; key: item
                    int totalPrice = 0;
                    for (String itemId : items.keySet()) {
                        ItemDTO item = itemDAO.getNamePriceItemFromItemId(itemId);
                        int boughtQuantity = items.get(itemId);
                        /*-------------------------PLUS AND MINUS QUANTITY-----------------------------*/
                        String changedItemId = request.getParameter("itemId");
                        String sign = request.getParameter("sign");
                        if (changedItemId != null && sign != null) {//change minus or plus
                            if (changedItemId.equals(itemId)) {
                                if (sign.equals("minus")) {
                                    if (boughtQuantity > 1) {
                                        --boughtQuantity;
                                        cart.reduceQuantityItem(itemId);
                                    }
                                } else if (sign.equals("plus")) {
                                    ++boughtQuantity;
                                    cart.addItem(itemId);
                                }
                            }
                        }
                        /*---------------------------END - PLUS AND MINUS QUANTITY--------------------------------*/
                        mapItem.put(item, boughtQuantity);
                        totalPrice += item.getPrice() * items.get(itemId);
                    }
                    session.setAttribute("itemsInCart", mapItem);
                    session.setAttribute("totalPrice", totalPrice);
                }else{
                    session.setAttribute("emptyCart", "Your cart is empty!!!");
                }
            }else{
                session.setAttribute("emptyCart", "Your cart is empty!!!");
            }
            url=CART_PAGE;
            url="/WEB-INF/view"+url;
        } catch (Exception e) {
            log("ViewCartServlet_processRequest:"+e.getMessage());
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




















































































































































































