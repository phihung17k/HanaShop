/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hungnp.daos;

import hungnp.utilities.MyConnection;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.NamingException;

/**
 *
 * @author Win 10
 */
public class InvoiceDAO implements Serializable{
    
    public int countInvoice() throws NamingException, SQLException{
        Connection connection=null;
        PreparedStatement statement=null;
        ResultSet resultSet =null;
        try{
            connection = MyConnection.makeConnection();
            if(connection!=null){
                String sql = "select count(InvoiceID) as amount "
                        + "from Invoice ";
                statement = connection.prepareStatement(sql);
                resultSet= statement.executeQuery();
                if(resultSet.next()){
                    return resultSet.getInt("amount");
                }
            }
        }finally{
            if(resultSet!=null) resultSet.close();
            if(statement!=null) statement.close();
            if(connection!=null) connection.close();
        }
        return -1;
    }
    
    public boolean createInvoice(String invoiceId, int totalPrice, String userId, String Address) throws NamingException, SQLException{
        Connection connection = null;
        PreparedStatement statement = null;
        try{
            connection = MyConnection.makeConnection();
            if(connection!=null){
                String sql = "insert into Invoice(InvoiceID, TotalPrice, UserID, Address) "
                        + "values(?, ?, ?, ?)";
                statement = connection.prepareStatement(sql);
                statement.setString(1, invoiceId);
                statement.setInt(2, totalPrice);
                statement.setString(3, userId);
                statement.setString(4, Address);
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
}















