/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hungnp.controllers;

import hungnp.cart.CartObject;
import hungnp.daos.InvoiceDAO;
import hungnp.daos.InvoiceDetailDAO;
import hungnp.daos.ItemDAO;
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
@WebServlet(name = "PaymentSetvlet", urlPatterns = {"/PaymentSetvlet"})
public class PaymentSetvlet extends HttpServlet {
    private static final String PAYMENT_PAGE= "/payment.jsp";
    private static final String SHOP_PAGE_CONTROLLER="/ShopPageServlet";
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
        String url = PAYMENT_PAGE;
        try {
            String address = request.getParameter("address");
            HttpSession session = request.getSession();
            session.removeAttribute("addressFail");
            if(address.trim().isEmpty() || address.length()>100){
                session.setAttribute("address", address);
                session.setAttribute("addressFail", "Address is not empty and length of address is not more than 100");
            }else{
                InvoiceDAO invoiceDAO= new InvoiceDAO();
                int countInvoice = invoiceDAO.countInvoice();
                if(countInvoice>-1){
                    String invoiceId = "IV"+(++countInvoice);
                    int totalPrice = (int) session.getAttribute("totalPrice");
                    String userId= (String) session.getAttribute("userId");
                    boolean newInvoice = invoiceDAO.createInvoice(invoiceId, totalPrice, userId, address);
                    if(newInvoice){
                        CartObject cart = (CartObject) session.getAttribute("cart");
                        if(cart!=null){
                            InvoiceDetailDAO invoiceDetailDAO = new InvoiceDetailDAO();
                            ItemDAO itemDAO = new ItemDAO();
                            Map<String, Integer> items= cart.getItems();
                            for (String itemId : items.keySet()) {
                                int price = itemDAO.getPriceFromId(itemId);
                                int priceItem = items.get(itemId)*price;
                                invoiceDetailDAO.createInvoiceDetail(invoiceId, itemId, priceItem);
                                int quantityInDatabase= itemDAO.getQuantityFromID(itemId);
                                int realQuantity = quantityInDatabase - items.get(itemId);
                                itemDAO.updateQuantity(itemId, realQuantity);
                            }
                            url = SHOP_PAGE_CONTROLLER;
                            session.removeAttribute("cart");
                            session.removeAttribute("itemsInCart");
                        }
                    }
                }
            }
            if(url.contains(".jsp")){
                url="/WEB-INF/view"+url;
            }
        } catch (Exception e) {
            log("PaymentServlet_processRequest:"+e.getMessage());
        } finally{
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


















































