/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hungnp.controllers;

import hungnp.daos.ItemDAO;
import hungnp.error.ItemError;
import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 *
 * @author Win 10
 */
@WebServlet(name = "AdminCreateItemServlet", urlPatterns = {"/AdminCreateItemServlet"})
public class AdminCreateItemServlet extends HttpServlet {
    private static final String CREATE_ITEM_PAGE="/createItem.jsp";
    private static final String ADMIN_TABLE_CONTROLLER="/AdminTableServlet";
            
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private java.sql.Date convertStringToSQLDate(String date) throws ParseException{
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        java.util.Date utilDate = dateFormat.parse(date);
        return new java.sql.Date(utilDate.getTime());
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = CREATE_ITEM_PAGE;
        try {
            HttpSession session =request.getSession();
            session.removeAttribute("errorCreate");
            boolean checkMultiPart = ServletFileUpload.isMultipartContent(request);
            if(checkMultiPart){
                DiskFileItemFactory fileItemFactory = new DiskFileItemFactory();
                ServletFileUpload upload = new ServletFileUpload(fileItemFactory);
                List items = upload.parseRequest(request);
                Iterator interator = items.iterator();
                Hashtable params = new Hashtable();
                String fileName= null;
                while(interator.hasNext()){
                    FileItem item = (FileItem) interator.next();
                    if(item.isFormField()){
                        params.put(item.getFieldName(), item.getString());
                    }else{
                        String itemName = item.getName();
                        fileName= itemName.substring(itemName.lastIndexOf("\\")+1);
                        String realPath = this.getServletContext().getRealPath("/")+"images\\"+fileName;
                        realPath=realPath.replace("\\build", "");
                        if(!fileName.isEmpty()){
                            File savedFile = new File(realPath);
                            if(!savedFile.exists()){
                                item.write(savedFile);
                            }
                        }
                    }
                }
                String itemId = (String) params.get("itemId");
                String nameItem = (String) params.get("itemName");
                String itemName= new String(nameItem.getBytes(StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);
                String image = fileName;
                String stringPrice = (String) params.get("price");
                String unit = (String) params.get("unit");
                String decodedUnit= new String(unit.getBytes(StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);
                String category = (String) params.get("category");
                String stringQuantity = (String) params.get("quantity");
                String description = (String) params.get("description");
                String decodedDecription= new String(description.getBytes(StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);
                String stringExpirationDate = (String) params.get("exDate");
                String status = (String) params.get("status");
                ItemError itemError= new ItemError();
                boolean isError = false;
                if(itemName.trim().isEmpty()){
                    itemError.setNameEmptyError("item name is not empty");
                    isError=true;
                }
                if(image.isEmpty()){
                    itemError.setImageNotChosenError("image is not chosen yet");
                    isError=true;
                }
                if(decodedUnit.trim().isEmpty()){
                    itemError.setUnitEmptyError("unit is not empty");
                    isError=true;
                }
                if(stringPrice.trim().isEmpty()){
                    isError=true;
                    itemError.setPriceEmptyError("price is not empty");
                }else {
                    if(stringPrice.matches("^\\d+$")){
                        int price = Integer.parseInt(stringPrice);
                        if(price<=0){
                            itemError.setPriceInputInvalidError("price must more than zero");
                            isError=true;
                        }
                    }else{
                        itemError.setPriceInputInvalidError("price is a number");
                        isError=true;
                    }
                }
                if(stringQuantity.trim().isEmpty()){
                    itemError.setQuantityEmptyError("quantity is not empty");
                    isError=true;
                }else {
                    if(stringQuantity.matches("^\\d+$")){
                    }else{
                        itemError.setQuantityInputInvalidError("quantity is a number and more than or equal zero");
                        isError=true;
                    }
                }
                if(stringExpirationDate.isEmpty()){
                    itemError.setEmptyDateError("date is empty");
                    isError=true;
                }else{
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    Date inputDate = sdf.parse(stringExpirationDate);
                    Date currentDate = new Date();
                    if (inputDate.compareTo(currentDate) < 1) {
                        itemError.setDateLessCurrentDateError("expiration date must be more than current date");
                        isError = true;
                    }
                }
                if(isError){
                    session.setAttribute("errorCreate", itemError);
                }else{
                    ItemDAO itemDAO = new ItemDAO();
                    String categoryId = itemDAO.getCategoryIDFromCategoryName(category);
                    String statusId = itemDAO.getStatusIDFromStatusName(status);
                    String userId = (String) session.getAttribute("userId");
                    if(categoryId.isEmpty() || statusId.isEmpty() || userId==null || itemId==null){
                    }else{
                        if (itemDAO.addItem(itemName, image, Integer.parseInt(stringPrice), decodedUnit, categoryId,
                                Integer.parseInt(stringQuantity), description, convertStringToSQLDate(stringExpirationDate), statusId, userId)) {
                            url = ADMIN_TABLE_CONTROLLER;
                        }
                    }
                }
            }
            if(url.contains(".jsp")){
                url="/WEB-INF/view"+url;
            }
        } catch (Exception e) {
            log("AdminUpdateItemServlet_processRequest:"+e.getMessage());
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






































