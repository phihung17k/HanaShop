/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hungnp.controllers;

import hungnp.daos.InvoiceDetailDAO;
import hungnp.purchased_item.PurchasedItem;
import java.io.IOException;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
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
@WebServlet(name = "SearchingHistoryServlet", urlPatterns = {"/SearchHistory"})
public class SearchingHistoryServlet extends HttpServlet {
    private static final String FILE_NOT_FOUND_PAGE="/fileNotFound.jsp";
    private static final String SHOP_HISTORY_PAGE="/shopHistory.jsp";
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    public Date convertStringToSQLDate(String date) throws ParseException{
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        java.util.Date day = dateFormat.parse(date);
        Date sqlDate = new Date(day.getTime());
        return sqlDate;
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = FILE_NOT_FOUND_PAGE;
        try {
            HttpSession session = request.getSession();
            session.removeAttribute("errorDate");
            session.removeAttribute("listPurchasedItem");
            
            String date = request.getParameter("date");
//            System.out.println("da:"+date);
            String searchValue = request.getParameter("search");
//            if(date!=null || searchValue!=null){
            if(searchValue==null){
                searchValue = "";
            }
                if(!date.isEmpty() || !searchValue.trim().isEmpty()){
                    Date sqlDate = convertStringToSQLDate(date);
                    InvoiceDetailDAO invoiceDetailDAO = new InvoiceDetailDAO();
                    String userId= (String) session.getAttribute("userId");
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    java.util.Date inputDate = sdf.parse(date);
                    java.util.Date currentDate = new java.util.Date();
                    if (inputDate.compareTo(currentDate) > -1) {
                        session.setAttribute("errorDate", "date must be less current date");
                    }else{
                        List<PurchasedItem> purchasedItems = invoiceDetailDAO.searchPurchasedItems(userId, sqlDate, searchValue);
                        if (purchasedItems != null) {
                            session.setAttribute("listPurchasedItem", purchasedItems);
                            session.setAttribute("currentDate", date);
                            session.setAttribute("searchHistory", searchValue);
                        }
                    }
                    url= SHOP_HISTORY_PAGE;
                }
//            }
            url="/WEB-INF/view"+url;
        } catch (Exception e) {
            log("SearchingHistory_processRequest:"+e.getMessage());
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




















































































