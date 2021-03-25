/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hungnp.controllers;

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
@WebServlet(name = "AdminTableServlet", urlPatterns = {"/AdminTableServlet"})
public class AdminTableServlet extends HttpServlet {
    private static final String FILE_NOT_FOUND_PAGE="/fileNotFound.jsp";
    private static final String ADMIN_TABLE_PAGE="/adminTable.jsp";
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
            ItemDAO itemDAO = new ItemDAO();
            double countItem = itemDAO.countAllItems();
            double amountItemPerPage=20;
            int numOfPage = (int) Math.ceil(countItem/amountItemPerPage);
            
            int skippedItems = 0;
            int nextItem = 0;
            String currentPage = request.getParameter("page");
            if(currentPage!=null){
                if(currentPage.matches("^\\d+$")){
                    int curPage= Integer.parseInt(currentPage);
                    if(curPage >= 1 && curPage <= numOfPage){
                        if(curPage == numOfPage){
                            if (countItem % amountItemPerPage == 0) {//full item last page
                                nextItem = 20;
                            } else {
                                nextItem = (int) (countItem % amountItemPerPage);
                            }
                        }else{
                            nextItem = 20;
                        }
                        skippedItems = (int) (curPage*amountItemPerPage-20);
                        url = ADMIN_TABLE_PAGE;
                    }
                }
            }else{
                nextItem=20;
                url=ADMIN_TABLE_PAGE;
            }
            Map<ItemDTO, Boolean> mapListItem = itemDAO.getItemPerPageAdmin(skippedItems, nextItem);
            
            if(mapListItem!=null){
                HttpSession session = request.getSession();
                session.setAttribute("mapListItemAdmin", mapListItem);
                session.setAttribute("numOfPageAdmin", numOfPage);
            }
            url="/WEB-INF/view"+url;
        } catch (Exception e) {
            log("AdminTableServlet_processRequest:"+e.getMessage());
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





















































































