/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hungnp.daos;

import hungnp.purchased_item.PurchasedItem;
import hungnp.utilities.MyConnection;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.naming.NamingException;

/**
 *
 * @author Win 10
 */
public class InvoiceDetailDAO implements Serializable{
    public boolean createInvoiceDetail(String invoiceId, String itemId, int itemPrice) throws NamingException, SQLException{
        Connection connection  =null;
        PreparedStatement statement = null;
        try{
            connection = MyConnection.makeConnection();
            if(connection!=null){
                String sql= "insert into InvoiceDetail(InvoiceID, ItemID, ItemPrice) "
                        + "values(?, ?, ?) ";
                statement = connection.prepareStatement(sql);
                statement.setString(1, invoiceId);
                statement.setString(2, itemId);
                statement.setInt(3, itemPrice);
                int row= statement.executeUpdate();
                if(row>0){
                    return true;
                }
            }
        }finally{
            if(statement!=null) statement.close();
            if(connection!=null) connection.close();
        }
        return false;
    }
    
    public List<PurchasedItem> getAllPurchasedItems(String userId) throws NamingException, SQLException{
        Connection connection=null;
        PreparedStatement statement=null;
        ResultSet resultSet =null;
        List<PurchasedItem> listPurchasedItems=null;
        try{
            connection = MyConnection.makeConnection();
            if(connection!=null){
                String sql = "select iv.InvoiceID, i.ItemName, id.ItemPrice, iv.BuyTime "
                        + "from InvoiceDetail id, Invoice iv, Item i, [User] u "
                        + "where id.InvoiceID=iv.InvoiceID and id.ItemID= i.ItemID and iv.UserID= u.UserID "
                                + "and u.UserID=? ";
                statement = connection.prepareStatement(sql);
                statement.setString(1, userId);
                resultSet= statement.executeQuery();
                while(resultSet.next()){
                    if(listPurchasedItems==null){
                        listPurchasedItems = new ArrayList<>();
                    }
                    String invoidId = resultSet.getString("InvoiceID");
                    String itemName= resultSet.getString("ItemName");
                    int itemPrice= resultSet.getInt("ItemPrice");
                    Date buyTime = resultSet.getTimestamp("BuyTime");
                    PurchasedItem item = new PurchasedItem(invoidId, itemName, itemPrice, buyTime);
                    listPurchasedItems.add(item);
                }
            }
        }finally{
            if(resultSet!=null) resultSet.close();
            if(statement!=null) statement.close();
            if(connection!=null) connection.close();
        }
        return listPurchasedItems;
    }
    
    public List<PurchasedItem> searchPurchasedItems(String userId, java.util.Date sqlDate, String searchValue) throws NamingException, SQLException{
        Connection connection=null;
        PreparedStatement statement=null;
        ResultSet resultSet =null;
        List<PurchasedItem> purchasedItems=null;
        try{
            connection = MyConnection.makeConnection();
            if(connection!=null){
                String sql = "select iv.InvoiceID, i.ItemName, id.ItemPrice, iv.BuyTime "
                        + "from InvoiceDetail id, Invoice iv, Item i, [User] u "
                        + "where id.InvoiceID=iv.InvoiceID and id.ItemID= i.ItemID and iv.UserID= u.UserID "
                                + "and u.UserID=? and (i.ItemName like ? or iv.BuyTime=? ) ";
                statement = connection.prepareStatement(sql);
                statement.setString(1, userId);
                if(searchValue.trim().isEmpty()){
                    statement.setString(2, searchValue);
                }else{
                    statement.setNString(2, "%"+searchValue+"%");
                }
                statement.setDate(3, (java.sql.Date) sqlDate);
                resultSet= statement.executeQuery();
                while(resultSet.next()){
                    if(purchasedItems==null){
                        purchasedItems = new ArrayList<>();
                    }
                    String invoidId = resultSet.getString("InvoiceID");
                    String itemName= resultSet.getString("ItemName");
                    int itemPrice= resultSet.getInt("ItemPrice");
                    Date buyTime = resultSet.getTimestamp("BuyTime");
                    PurchasedItem item = new PurchasedItem(invoidId, itemName, itemPrice, buyTime);
                    purchasedItems.add(item);
                }
            }
        }finally{
            if(resultSet!=null) resultSet.close();
            if(statement!=null) statement.close();
            if(connection!=null) connection.close();
        }
        return purchasedItems;
    }
}










































