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
@WebServlet(name = "ShoppingPageServlet", urlPatterns = {"/ShopPageServlet"})
public class ShoppingPageServlet extends HttpServlet {
    private static final String FILE_NOT_FOUND_PAGE="/fileNotFound.jsp";
    private static final String SHOP_PAGE="/shop.jsp";
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private int findIndexItem(List<ItemDTO> listItem, String itemId){
        for (int i = 0; i < listItem.size(); i++) {
            if(listItem.get(i).getItemId().equals(itemId)){
                return i;
            }
        }
        return -1;
    }
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url=FILE_NOT_FOUND_PAGE;
        try {
            double countDefaultItems = 20;
            double amountItemPerPage=9;
            int numOfPages= (int) Math.ceil(countDefaultItems/amountItemPerPage);
            int skippedItems = 0;
            int nextItems=0;
            
            HttpSession session = request.getSession();
            session.removeAttribute("checkedCategory");
            session.removeAttribute("searchValue");
            session.removeAttribute("maxMoney");
            session.removeAttribute("minMoney");
            
            String currentPage= request.getParameter("page");
            if(currentPage!=null){
                if(currentPage.matches("^\\d+$")){
                    int curPage = Integer.parseInt(currentPage);
                    if(curPage >= 1 && curPage <= numOfPages){
                        if(numOfPages == curPage){
                            if (countDefaultItems % amountItemPerPage == 0) {//full item last page
                                nextItems = 9;
                            } else {
                                nextItems = (int) (countDefaultItems % amountItemPerPage);
                            }
                        }else{
                            nextItems=9;
                        }
                        skippedItems = (int) (curPage * amountItemPerPage - 9);
                        url = SHOP_PAGE;
                    }
                }
            }else{//when search first, not click page
                nextItems=9;
                url = SHOP_PAGE;
            }

            ItemDAO itemDAO= new ItemDAO();
            List<String> listCategory = itemDAO.getAllItemCategory();
            List<ItemDTO> listItem = itemDAO.getItemsPerPageDefault(skippedItems, nextItems);
            if(listCategory!=null && listItem!=null){
                session.setAttribute("numOfPage", numOfPages);
                session.setAttribute("listCategory", listCategory);
                
                if(session.getAttribute("cart")!=null){
                    CartObject cart= (CartObject) session.getAttribute("cart");
                    Map<String, Integer> items= (Map<String, Integer>) cart.getItems();
                    if(items!=null){
                        for (String itemId : items.keySet()) {
                            int index = findIndexItem(listItem, itemId);
                            if(index>-1){
                                ItemDTO item= listItem.get(index);
                                item.setQuantity(item.getQuantity()-items.get(itemId));
                                listItem.set(index, item);
                            }
                        }
                    }
                }
                
                session.setAttribute("listItem", listItem);
            }
            url="/WEB-INF/view"+url;
        } catch (Exception e) {
            log("ShopPageServlet_processRequest:"+e.getMessage());
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




























































































































































































































