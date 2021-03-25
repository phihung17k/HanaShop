/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hungnp.daos;

import hungnp.dtos.ItemDTO;
import hungnp.utilities.MyConnection;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.naming.NamingException;

/**
 *
 * @author Win 10
 */
public class ItemDAO implements Serializable{
    
    public List<String> getAllItemCategory() throws NamingException, SQLException{
        Connection connection=null;
        PreparedStatement statement=null;
        ResultSet resultSet=null;
        List<String> listItemCategory=null;
        try{
            connection=MyConnection.makeConnection();
            if(connection!=null){
                String sql="select ItemCategoryName "
                        + "from ItemCategory ";
                statement= connection.prepareStatement(sql);
                resultSet = statement.executeQuery();
                while(resultSet.next()){
                    if(listItemCategory==null){
                        listItemCategory= new ArrayList<>();
                    }
                    String category= resultSet.getString("ItemCategoryName");
                    listItemCategory.add(category);
                }
            }
        }finally{
            if(resultSet!=null) resultSet.close();
            if(statement!=null) statement.close();
            if(connection!=null) connection.close();
        }
        return listItemCategory;
    }

    public List<ItemDTO> getItemsPerPageDefault(int skippedItems, int nextItems) throws NamingException, SQLException{
        Connection connection=null;
        PreparedStatement statement=null;
        ResultSet resultSet=null;
        List<ItemDTO> listDefaultItem= null;
        try{
            connection= MyConnection.makeConnection();
            if(connection!=null){
                String sql="select i.ItemID, i.ItemName, i.Image, i.Price, i.Unit, i.Quantity, i.ExpirationDate "
                        + "from Item i join ItemCategory c on i.ItemCategoryID=c.ItemCategoryID "
                                    + "join ItemStatus s on s.ItemStatusID = i.ItemStatusID "
                        + "where s.ItemStatusName='active' and i.Quantity>0 and i.ExpirationDate >= getdate() "
                        + "order by i.CreatedDate desc "
                        + "offset ? rows "
                        + "fetch first ? rows only ";
                statement = connection.prepareStatement(sql);
                statement.setInt(1, skippedItems);
                statement.setInt(2, nextItems);
                resultSet = statement.executeQuery();
                while(resultSet.next()){
                    if(listDefaultItem==null){
                        listDefaultItem = new ArrayList<>();
                    }
                    String itemId= resultSet.getString("ItemID");
                    String itemName= resultSet.getString("ItemName");
                    String image= resultSet.getString("Image");
                    int price= resultSet.getInt("Price");
                    String unit= resultSet.getString("Unit");
                    int quantity= resultSet.getInt("Quantity");
                    Date expirationDate= resultSet.getTimestamp("ExpirationDate");
                    ItemDTO item= new ItemDTO(itemId, itemName, image, price, unit, quantity, expirationDate);
                    listDefaultItem.add(item);
                }
            }
        }finally{
            if(resultSet!=null) resultSet.close();
            if(statement!=null) statement.close();
            if(connection!=null) connection.close();
        }
        return listDefaultItem;
    }
    
    public int countSearchedItem(String searchValue, int minMoney, int maxMoney, String itemCategory) throws NamingException, SQLException{
        Connection connection=null;
        PreparedStatement statement= null;
        ResultSet resultSet= null;
        int countedItem=-1;
        try{
            connection = MyConnection.makeConnection();
            if(connection!=null){
                String sql="select count(i.ItemID) as countID "
                        + "from Item i join ItemCategory c on i.ItemCategoryID=c.ItemCategoryID "
                                    + "join ItemStatus s on s.ItemStatusID = i.ItemStatusID "
                        + "where s.ItemStatusName='active' and i.Quantity>0 and i.ExpirationDate >= getdate() and "
                        + "(i.ItemName like ? or (i.Price >= ? and i.Price <= ?) or c.ItemCategoryName=? ) ";
                statement = connection.prepareStatement(sql);
//                if(searchValue.trim().isEmpty()){
//                    statement.setNString(1, searchValue);
//                }else{
                    statement.setNString(1, "%"+searchValue+"%");
//                }
                statement.setInt(2, minMoney);
                statement.setInt(3, maxMoney);
                statement.setString(4, itemCategory);
                resultSet= statement.executeQuery();
                if(resultSet.next()){
                    countedItem = resultSet.getInt("countID");
                }
            }
        }finally{
            if(resultSet!=null) resultSet.close();
            if(statement!=null) statement.close();
            if(connection!=null) connection.close();
        }
        return countedItem;
    }
    
    public List<ItemDTO> searchItem(String searchValue, int minMoney, int maxMoney, String itemCategory, int skippedItems, int nextItems)
            throws SQLException, NamingException{
        Connection connection=null;
        PreparedStatement statement=null;
        ResultSet resultSet = null;
        List<ItemDTO> listSearchedItem=null;
        try{
            connection = MyConnection.makeConnection();
            if(connection!=null) {
                String sql="select i.ItemID, i.ItemName, i.Image, i.Price, i.Unit, i.Quantity, i.ExpirationDate "
                        + "from Item i join ItemCategory c on i.ItemCategoryID=c.ItemCategoryID "
                                    + "join ItemStatus s on s.ItemStatusID = i.ItemStatusID "
                        + "where s.ItemStatusName='active' and i.Quantity>0 and i.ExpirationDate >= getdate() and "
                                + "(i.ItemName like ? or (i.Price >= ? and i.Price <= ?) or c.ItemCategoryName=?) "
                        + "order by i.CreatedDate desc "
                        + "offset ? rows "
                        + "fetch first ? rows only "; 
                statement= connection.prepareStatement(sql);
//                if(searchValue.trim().isEmpty()){
//                    statement.setNString(1, searchValue);
//                }else{
                    statement.setNString(1, "%"+searchValue+"%");
//                }
                statement.setInt(2, minMoney);
                statement.setInt(3, maxMoney);
                statement.setString(4, itemCategory);
                statement.setInt(5, skippedItems);
                statement.setInt(6, nextItems);
                resultSet = statement.executeQuery();
                while(resultSet.next()){
                    if(listSearchedItem==null){
                        listSearchedItem=new ArrayList<>();
                    }
                    
                    String itemId= resultSet.getString("ItemID");
                    String itemName= resultSet.getString("ItemName");
                    String image= resultSet.getString("Image");
                    int price= resultSet.getInt("Price");
                    String unit = resultSet.getString("Unit");
                    int quantity= resultSet.getInt("Quantity");
                    Date expirationDate= resultSet.getTimestamp("ExpirationDate");
                    ItemDTO item= new ItemDTO(itemId, itemName, image, price, unit, quantity, expirationDate);
                    listSearchedItem.add(item);
//                    System.out.println(itemName);
                }
            }
        }finally{
            if(resultSet!=null) resultSet.close();
            if(statement!=null) statement.close();
            if(connection!=null) connection.close();
        }
        return listSearchedItem;
    }
    
    public ItemDTO getNamePriceItemFromItemId(String itemId) throws NamingException, SQLException{
        Connection connection = null;
        PreparedStatement statement= null;
        ResultSet resultSet=null;
        try{
            connection = MyConnection.makeConnection();
            if(connection!=null){
                String sql ="select ItemName, Price "
                        + "from Item "
                        + "where ItemID=? ";
                statement = connection.prepareStatement(sql);
                statement.setString(1, itemId);
                resultSet= statement.executeQuery();
                if(resultSet.next()){
                    String itemName= resultSet.getString("ItemName");
                    int price = resultSet.getInt("Price");
                    ItemDTO item= new ItemDTO(itemId, itemName, price);
                    return item;
                }
            }
        }finally{
            if(resultSet!=null) resultSet.close();
            if(statement!=null) statement.close();
            if(connection!=null) connection.close();
        }
        return null;
    }
   
    public ArrayList getRealQuantityAndNameItem(String itemId, int quantity) throws NamingException, SQLException{
        Connection connection= null;
        PreparedStatement statement = null;
        ResultSet resultSet= null;
        ArrayList properties= null;
        try{
            connection= MyConnection.makeConnection();
            if(connection!=null){
                String sql="select ItemName, Quantity "
                        + "from Item "
                        + "where ItemID=? and Quantity<? ";
                statement = connection.prepareStatement(sql);
                statement.setString(1, itemId);
                statement.setInt(2, quantity);
                resultSet= statement.executeQuery();
                if(resultSet.next()){
                    properties = new ArrayList();
                    String itemName= resultSet.getString("ItemName");
                    int realQuantity = resultSet.getInt("Quantity");
                    properties.add(itemName);
                    properties.add(realQuantity);
                }
            }
        }finally{
            if(resultSet!=null) resultSet.close();
            if(statement!=null) statement.close();
            if(connection!=null) connection.close();
        }
        return properties;
    }
    
    public int getPriceFromId(String itemId) throws NamingException, SQLException{
        Connection connection= null;
        PreparedStatement statement = null;
        ResultSet resultSet= null;
        try{
            connection= MyConnection.makeConnection();
            if(connection!=null){
                String sql="select Price "
                        + "from Item "
                        + "where ItemID=? ";
                statement = connection.prepareStatement(sql);
                statement.setString(1, itemId);
                resultSet = statement.executeQuery();
                if(resultSet.next()){
                    int price= resultSet.getInt("Price");
                    return price;
                }
            }
        }finally{
            if(resultSet!=null) resultSet.close();
            if(statement!=null) statement.close();
            if(connection!=null) connection.close();
        }
        return -1;
    }
    
    public int getQuantityFromID(String itemId) throws NamingException, SQLException{
        Connection connection= null;
        PreparedStatement statement = null;
        ResultSet resultSet= null;
        try{
            connection= MyConnection.makeConnection();
            if(connection!=null){
                String sql="select Quantity "
                        + "from Item "
                        + "where ItemID=? ";
                statement = connection.prepareStatement(sql);
                statement.setString(1, itemId);
                resultSet = statement.executeQuery();
                if(resultSet.next()){
                    int quantity= resultSet.getInt("Quantity");
                    return quantity;
                }
            }
        }finally{
            if(resultSet!=null) resultSet.close();
            if(statement!=null) statement.close();
            if(connection!=null) connection.close();
        }
        return -1;
    }
    
    public boolean updateQuantity(String itemId, int quantity) throws NamingException, SQLException{
        Connection connection= null;
        PreparedStatement statement = null;
        try{
            connection= MyConnection.makeConnection();
            if(connection!=null){
                String sql="update Item "
                        + "set Quantity=? "
                        + "where ItemID=? ";
                statement = connection.prepareStatement(sql);
                statement.setInt(1, quantity);
                statement.setString(2, itemId);
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
    
    public ItemDTO getAllInfoItemFromItemID(String itemId) throws NamingException, SQLException{
        Connection connection= null;
        PreparedStatement statement = null;
        ResultSet resultSet= null;
        try{
            connection= MyConnection.makeConnection();
            if(connection!=null){
                String sql="select i.ItemName, i.Image, i.Price, i.Unit, c.ItemCategoryName, i.Quantity, i.Description, i.ExpirationDate "
                        + "from Item i join ItemCategory c on i.ItemCategoryID=c.ItemCategoryID "
                        + "where ItemID=? ";
                statement = connection.prepareStatement(sql);
                statement.setString(1, itemId);
                resultSet = statement.executeQuery();
                if(resultSet.next()){
                    String itemName= resultSet.getString("ItemName");
                    String image = resultSet.getString("Image");
                    int price = resultSet.getInt("Price");
                    String unit = resultSet.getString("Unit");
                    String itemCategory= resultSet.getString("ItemCategoryName");
                    int quantity = resultSet.getInt("Quantity");
                    String description = resultSet.getString("Description");
                    Date expirationDate =resultSet.getTimestamp("ExpirationDate");
                    ItemDTO item = new ItemDTO(itemId, itemName, image, price, unit, quantity, itemCategory, description, expirationDate);
                    return item;
                }
            }
        }finally{
            if(resultSet!=null) resultSet.close();
            if(statement!=null) statement.close();
            if(connection!=null) connection.close();
        }
        return null;
    }
    
    public int countAllItems() throws NamingException, SQLException{
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet=null;
        try{
            connection = MyConnection.makeConnection();
            if(connection!=null){
                String sql="select count(ItemID) as countItem "
                        + "from Item ";
                statement = connection.prepareStatement(sql);
                resultSet = statement.executeQuery();
                if(resultSet.next()){
                    int countItem = resultSet.getInt("countItem");
                    return countItem;
                }
            }
        }finally{
            if(resultSet!=null) resultSet.close();
            if(statement!=null) statement.close();
            if(connection!=null) connection.close();
        }
        return -1;
    }
    
    public Map<ItemDTO, Boolean> getItemPerPageAdmin(int skippedItem, int nextItem) throws NamingException, SQLException{
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        Map<ItemDTO, Boolean> mapListItem = null;
        try{
            connection = MyConnection.makeConnection();
            if(connection!=null){
                String sql="select i.ItemID, i.ItemName, i.Image, i.Price, c.ItemCategoryName, i.Quantity, i.ExpirationDate, s.ItemStatusName "
                        + "from Item i, ItemStatus s, ItemCategory c "
                        + "where i.ItemStatusID=s.ItemStatusID and i.ItemCategoryID=c.ItemCategoryID "
                        + "order by i.CreatedDate desc "
                        + "offset ? rows "
                        + "fetch first ? rows only ";
                statement=connection.prepareStatement(sql);
                statement.setInt(1, skippedItem);
                statement.setInt(2, nextItem);
                resultSet = statement.executeQuery();
                while(resultSet.next()){
                    if(mapListItem==null){
                        mapListItem = new HashMap<>();
                    }
                    String itemId= resultSet.getString("ItemID");
                    String itemName= resultSet.getString("ItemName");
                    String image= resultSet.getString("Image");
                    int price= resultSet.getInt("Price");
                    String category= resultSet.getString("ItemCategoryName");
                    int quantity = resultSet.getInt("Quantity");
                    Date expirationDate = resultSet.getTimestamp("ExpirationDate");
                    String status = resultSet.getString("ItemStatusName");
                    ItemDTO item = new ItemDTO(itemId, itemName, image, price, quantity, category, expirationDate, status);
                    mapListItem.put(item, status.equals("active"));
                }
            }
        }finally{
            if(resultSet!=null) resultSet.close();
            if(statement!=null) statement.close();
            if(connection!=null) connection.close();
        }
        return mapListItem;
    }
    
    public boolean checkExistItem(String itemId) throws NamingException, SQLException{
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        try{
            connection = MyConnection.makeConnection();
            if(connection!=null){
                String sql="select ItemID "
                        + "from Item "
                        + "where ItemID= ? ";
                statement=connection.prepareStatement(sql);
                statement.setString(1, itemId);
                resultSet = statement.executeQuery();
                if(resultSet.next()){
                    return true;
                }
            }
        }finally{
            if(resultSet!=null) resultSet.close();
            if(statement!=null) statement.close();
            if(connection!=null) connection.close();
        }
        return false;
    }
    
    public boolean removeItem(String userId, String itemId) throws NamingException, SQLException{
        Connection connection = null;
        PreparedStatement statement = null;
        try{
            connection = MyConnection.makeConnection();
            if(connection!=null){
                String sql="update Item "
                        + "set ItemStatusID='IS1', UpdatedDate = default, UpdatedUserID=? "
                        + "where ItemID= ? ";
                statement=connection.prepareStatement(sql);
                statement.setString(1, userId);
                statement.setString(2, itemId);
                int row = statement.executeUpdate();
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
    
    public ItemDTO getPropertiesItemForUpdate(String itemId) throws NamingException, SQLException{
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        try{
            connection = MyConnection.makeConnection();
            if(connection!=null){
                String sql="select i.ItemName, i.Image, i.Price, c.ItemCategoryName, i.Quantity, i.ExpirationDate, s.ItemStatusName "
                        + "from Item i, ItemCategory c, ItemStatus s "
                        + "where i.ItemCategoryID = c.ItemCategoryID and i.ItemStatusID = s.ItemStatusID and i.ItemID=? ";
                statement=connection.prepareStatement(sql);
                statement.setString(1, itemId);
                resultSet = statement.executeQuery();
                if(resultSet.next()){
                    String itemName = resultSet.getString("ItemName");
                    String image = resultSet.getString("Image");
                    int price = resultSet.getInt("Price");
                    String category = resultSet.getString("ItemCategoryName");
                    int quantity = resultSet.getInt("Quantity");
                    Date expirationDate = resultSet.getTimestamp("ExpirationDate");
                    String status = resultSet.getString("ItemStatusName");
                    ItemDTO item = new ItemDTO(itemId, itemName, image, price, quantity, category, expirationDate, status);
                    return item;
                }
            }
        }finally{
            if(resultSet!=null) resultSet.close();
            if(statement!=null) statement.close();
            if(connection!=null) connection.close();
        }
        return null;
    }
    
    public List<String> getAllStatus() throws NamingException, SQLException {
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        List<String> listStatus = null;
        try{
            connection = MyConnection.makeConnection();
            if(connection!=null){
                String sql="select ItemStatusName "
                        + "from ItemStatus ";
                statement=connection.prepareStatement(sql);
                resultSet = statement.executeQuery();
                while(resultSet.next()){
                    if(listStatus==null){
                        listStatus = new ArrayList<>();
                    }
                    String status = resultSet.getString("ItemStatusName");
                    listStatus.add(status);
                }
            }
        }finally{
            if(resultSet!=null) resultSet.close();
            if(statement!=null) statement.close();
            if(connection!=null) connection.close();
        }
        return listStatus;
    }
    
    public boolean updateItem(String itemName, String image, int price, String category, int quantity, java.sql.Date expirationDate,
            String status, String userId, String itemId) throws NamingException, SQLException{
        Connection connection = null;
        PreparedStatement statement = null;
        try{
            connection = MyConnection.makeConnection();
            if(connection!=null){
                String sql="update Item "
                        + "set ItemName=?, Image=?, Price=?, ItemCategoryID=?, Quantity=?, ExpirationDate=?, ItemStatusID=?, "
                                + "UpdatedDate = default, UpdatedUserID=? "
                        + "where ItemID=? ";
                statement=connection.prepareStatement(sql);
                statement.setString(1, itemName);
                statement.setString(2, image);
                statement.setInt(3, price);
                statement.setString(4, category);
                statement.setInt(5, quantity);
                statement.setDate(6, expirationDate);
                statement.setString(7, status);
                statement.setString(8, userId);
                statement.setString(9, itemId);
                int row = statement.executeUpdate();
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
    
    public boolean updateItemExceptImage(String itemName, int price, String categoryId, int quantity, java.sql.Date expirationDate,
            String statusId, String userId, String itemId) throws NamingException, SQLException{
        Connection connection = null;
        PreparedStatement statement = null;
        try{
            connection = MyConnection.makeConnection();
            if(connection!=null){
                String sql="update Item "
                        + "set ItemName=?, Price=?, ItemCategoryID=?, Quantity=?, ExpirationDate=?, ItemStatusID=?, "
                                + "UpdatedDate = default, UpdatedUserID=? "
                        + "where ItemID=? ";
                statement=connection.prepareStatement(sql);
                statement.setString(1, itemName);
                statement.setInt(2, price);
                statement.setString(3, categoryId);
                statement.setInt(4, quantity);
                statement.setDate(5, expirationDate);
                statement.setString(6, statusId);
                statement.setString(7, userId);
                statement.setString(8, itemId);
                int row = statement.executeUpdate();
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
    
    public String getCategoryIDFromCategoryName(String category) throws NamingException, SQLException{
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        try{
            connection = MyConnection.makeConnection();
            if(connection!=null){
                String sql="select ItemCategoryID "
                        + "from ItemCategory "
                        + "where ItemCategoryName=? ";
                statement=connection.prepareStatement(sql);
                statement.setString(1, category);
                resultSet = statement.executeQuery();
                if(resultSet.next()){
                    String categoryId = resultSet.getString("ItemCategoryID");
                    return categoryId;
                }
            }
        }finally{
            if(resultSet!=null) resultSet.close();
            if(statement!=null) statement.close();
            if(connection!=null) connection.close();
        }
        return "";
    }
    public String getStatusIDFromStatusName(String status) throws NamingException, SQLException{
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        try{
            connection = MyConnection.makeConnection();
            if(connection!=null){
                String sql="select ItemStatusID "
                        + "from ItemStatus "
                        + "where ItemStatusName=? ";
                statement=connection.prepareStatement(sql);
                statement.setString(1, status);
                resultSet = statement.executeQuery();
                if(resultSet.next()){
                    String statusId = resultSet.getString("ItemStatusID");
                    return statusId;
                }
            }
        }finally{
            if(resultSet!=null) resultSet.close();
            if(statement!=null) statement.close();
            if(connection!=null) connection.close();
        }
        return "";
    }
    
    public boolean addItem(String itemName, String image, int price, String unit, String categoryId, int quantity, String description,
            java.sql.Date expirationDate, String statusId, String userId) throws NamingException, SQLException{
        Connection connection = null;
        PreparedStatement statement = null;
        try{
            connection = MyConnection.makeConnection();
            if(connection!=null){
                String sql="insert into Item(ItemID, ItemName, Image, Price, Unit, ItemCategoryID, Quantity, Description, CreatedDate, "
                                            + "ExpirationDate, ItemStatusID, UpdatedDate, UpdatedUserID) "
                        + "values(default, ?, ?, ?, ?, ?, ?, ?, getdate(), ?, ?, null, ?) ";
                statement=connection.prepareStatement(sql);
                statement.setString(1, itemName);
                statement.setString(2, image);
                statement.setInt(3, price);
                statement.setString(4, unit);
                statement.setString(5, categoryId);
                statement.setInt(6, quantity);
                statement.setString(7, description);
                statement.setDate(8, expirationDate);
                statement.setString(9, statusId);
                statement.setString(10, userId);
                int row = statement.executeUpdate();
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
}



































































































































































































































































































































































