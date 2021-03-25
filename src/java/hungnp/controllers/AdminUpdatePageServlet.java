/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hungnp.controllers;

import hungnp.daos.ItemDAO;
import hungnp.dtos.ItemDTO;
import java.io.IOException;
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
@WebServlet(name = "AdminUpdatePageServlet", urlPatterns = {"/AdminUpdatePageServlet"})
public class AdminUpdatePageServlet extends HttpServlet {
    private static final String FILE_NOT_FOUND_PAGE="/fileNotFound.jsp";
    private static final String UPDATE_ITEM_PAGE="/updateItem.jsp";
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
        try {
            String itemId = request.getParameter("itemId");
            if(itemId !=null){
                ItemDAO itemDAO = new ItemDAO();
                boolean checkExistItem = itemDAO.checkExistItem(itemId);
                if(checkExistItem){
                    ItemDTO item = itemDAO.getPropertiesItemForUpdate(itemId);
                    List<String> listCategory= itemDAO.getAllItemCategory();
                    List<String> listStatus = itemDAO.getAllStatus();
                    if(item!=null && listCategory!=null && listStatus!=null){
                        HttpSession session = request.getSession();
                        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                        String date = dateFormat.format(item.getExpirationDate());
                        session.setAttribute("expirationDate", date);
                        session.setAttribute("itemForUpdate", item);
                        session.setAttribute("listCategory", listCategory);
                        session.setAttribute("listStatus", listStatus);
                        url = UPDATE_ITEM_PAGE;
                    }
                }
            }
            url="/WEB-INF/view"+url;
        } catch (Exception e) {
            log("AdminUpdatePageServlet_processRequest:"+e.getMessage());
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















































