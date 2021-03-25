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
@WebServlet(name = "SearchingServlet", urlPatterns = {"/SearchServlet"})
public class SearchingServlet extends HttpServlet {

    private static final String FILE_NOT_FOUND_PAGE = "/fileNotFound.jsp";
    private static final String SHOP_PAGE = "/shop.jsp";

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
        request.setCharacterEncoding("UTF-8");
        String url = FILE_NOT_FOUND_PAGE;
        try {
            HttpSession session = request.getSession();
            session.removeAttribute("numOfPage");
            session.removeAttribute("listItem");

            String searchValue = request.getParameter("search");
            String range = request.getParameter("range");
            String category = request.getParameter("itemCategory");

            if (searchValue == null && range == null && category == null) {
                searchValue = (String) session.getAttribute("searchValue");
                range = session.getAttribute("minMoney") + "VND - " + session.getAttribute("maxMoney") + "VND";
                category = (String) session.getAttribute("checkedCategory");
            }
            
            if (searchValue == null) {
                searchValue = "";
            }
            if (category == null) {
                category = "";
            }
            System.out.println("cate:"+category);
            range = range.replace("VND", "");
            String[] array = range.split(" - ");
            int minMoney = Integer.parseInt(array[0]);
            int maxMoney = Integer.parseInt(array[1]);

            ItemDAO itemDAO = new ItemDAO();
            double totalSearchedItem = itemDAO.countSearchedItem(searchValue, minMoney, maxMoney, category);
            System.out.println("t:"+totalSearchedItem);
            if (totalSearchedItem > 0) {
                double amountItemPerPage = 9;
                int numOfPage = (int) Math.ceil(totalSearchedItem / amountItemPerPage);

                int skippedItem = 0;
                int nextItem = 0;

                String page = request.getParameter("page");
                if (page != null) {
                    if (page.matches("\\d+")) {
                        int currentPage = Integer.parseInt(page);
                        if (currentPage > 0 && currentPage <= numOfPage) {
                            skippedItem = (int) (currentPage * amountItemPerPage - 9);
                            nextItem = 9;
                            if (currentPage == numOfPage) {
                                if (totalSearchedItem % 9 != 0) {
                                    nextItem = (int) (totalSearchedItem % 9);
                                }
                            }
                            url = SHOP_PAGE;
                        }
                    }
                } else {
                    nextItem = 9;
                    url = SHOP_PAGE;
                }
                
                List<ItemDTO> listItem = itemDAO.searchItem(searchValue, minMoney, maxMoney, category, skippedItem, nextItem);

                if (session.getAttribute("cart") != null) {
                    CartObject cart = (CartObject) session.getAttribute("cart");
                    if (cart.getItems() != null) {
                        Map<String, Integer> items = cart.getItems();
                        for (String itemId : items.keySet()) {
                            int index = findIndexItem(listItem, itemId);
                            if (index > -1) {
                                int quantityInList = listItem.get(index).getQuantity();
                                int quantityInCart = items.get(itemId);
                                System.out.println("list:"+quantityInList+";cart:"+quantityInCart);
                                if (quantityInList - quantityInCart > 0) {
                                    listItem.get(index).setQuantity(quantityInList - quantityInCart);
                                } else {
                                    listItem.remove(index);
                                }
                            }
                        }
                    }
                }

                session.setAttribute("numOfPage", numOfPage);
                session.setAttribute("listItem", listItem);
//                System.out.println("");
//                System.out.println("search:"+searchValue+"\nmin:"+minMoney+"\nmax"+maxMoney);
//                System.out.println("cate:"+category+"\nskip:"+skippedItem+"\nnext:"+nextItem);
//                System.out.println("");
            } else if (totalSearchedItem == 0) {
                url = SHOP_PAGE;
            }
            if (session.getAttribute("listCategory") == null) {
                session.setAttribute("listCategory", itemDAO.getAllItemCategory());
            }
            session.setAttribute("searchValue", searchValue);
            session.setAttribute("minMoney", minMoney);
            session.setAttribute("maxMoney", maxMoney);
            session.setAttribute("checkedCategory", category);

            url="/WEB-INF/view"+url;
        } catch (Exception e) {
//            e.printStackTrace();
            log("SearchServlet_processRequest:" + e.getMessage());
        } finally {
//            System.out.println("url"+url);
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

































