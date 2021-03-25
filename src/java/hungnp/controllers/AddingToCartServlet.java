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
import java.util.List;
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
@WebServlet(name = "AddingToCartServlet", urlPatterns = {"/AddToCartServlet"})
public class AddingToCartServlet extends HttpServlet {

    private static final String FILE_NOT_FOUND_PAGE = "/fileNotFound.jsp";
    private static final String SHOP_PAGE = "/shop.jsp";
    private static final String ITEM_PAGE = "/item.jsp";

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private int findIndexItem(List<ItemDTO> listItem, String itemId) {
        for (int i = 0; i < listItem.size(); i++) {
            if (listItem.get(i).getItemId().equals(itemId)) {
                return i;
            }
        }
        return -1;
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = FILE_NOT_FOUND_PAGE;
        try {
            HttpSession session = request.getSession();
            CartObject cart = (CartObject) session.getAttribute("cart");
            if (cart == null) {
                cart = new CartObject();
            }
            String itemId = request.getParameter("itemId");
            if (itemId != null) {
                List<ItemDTO> listItem = (List<ItemDTO>) session.getAttribute("listItem");//có nút add => có list sẵn
                int index = findIndexItem(listItem, itemId);
                if (index > -1) {
                    int quantityInList = listItem.get(index).getQuantity();
                    if (quantityInList - 1 > 0) {
                        listItem.get(index).setQuantity(quantityInList - 1);
                    } else {
                        listItem.remove(index);
                    }
//                    listItem.get(index).setQuantity( listItem.get(index).getQuantity() - 1 );//set quantity cho item
                    cart.addItem(itemId);
                    session.setAttribute("cart", cart);
                    session.setAttribute("listItem", listItem);
                    url = SHOP_PAGE;

                    String thisPage = request.getParameter("thisPage");
                    if (thisPage != null) {
                        ItemDAO itemDAO = new ItemDAO();
                        ItemDTO item = itemDAO.getAllInfoItemFromItemID(itemId);
                        Map<String, Integer> items = cart.getItems();
                        if (items != null) {
                            if (items.containsKey(itemId)) {
                                item.setQuantity(item.getQuantity() - items.get(itemId));
                            }
                        }
                        session.setAttribute("singleItem", item);
                        url = ITEM_PAGE;
                    }
                }
            }
            url = "/WEB-INF/view" + url;
        } catch (Exception e) {
            log("AddingToCartServlet_processRequest:" + e.getMessage());
        } finally {
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

