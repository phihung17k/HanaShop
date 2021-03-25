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
public class UserDAO implements Serializable{
    
    public boolean checkLogin(String userId, String password) throws SQLException, NamingException{
        Connection connection=null;
        PreparedStatement statement= null;
        ResultSet resultSet= null;
        try{
            connection = MyConnection.makeConnection();
            if(connection!=null){
                String sql="select UserID "
                        + "from [User] "
                        + "where UserID=? and [Password]=? ";
                statement = connection.prepareStatement(sql);
                statement.setString(1, userId);
                statement.setString(2, password);
                resultSet=statement.executeQuery();
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
    
    public String getRole(String userId) throws NamingException, SQLException{
        Connection connection=null;
        PreparedStatement statement=null;
        ResultSet resultSet= null;
        try{
            connection = MyConnection.makeConnection();
            if(connection!=null){
                String sql="select t.UserTypeName "
                        + "from [User] u join UserType t on u.UserTypeID=t.UserTypeID "
                        + "where u.UserID=? ";
                statement= connection.prepareStatement(sql);
                statement.setString(1, userId);
                resultSet= statement.executeQuery();
                if(resultSet.next()){
                    String userTypeName = resultSet.getString("UserTypeName");
                    return userTypeName;
                }
            }
        }finally{
            if(resultSet!=null) resultSet.close();
            if(statement!=null) statement.close();
            if(connection!=null) connection.close();
        }
        return "";
    }
    public String getFullnameFromUserId(String userId) throws NamingException, SQLException{
        Connection connection=null;
        PreparedStatement statement=null;
        ResultSet resultSet= null;
        try{
            connection = MyConnection.makeConnection();
            if(connection!=null){
                String sql="select FullName "
                        + "from [User] "
                        + "where UserID=? ";
                statement = connection.prepareStatement(sql);
                statement.setString(1, userId);
                resultSet= statement.executeQuery();
                if(resultSet.next()){
                    return resultSet.getString("FullName");
                }
            }
        }finally{
            if(resultSet!=null) resultSet.close();
            if(statement!=null) statement.close();
            if(connection!=null) connection.close();
        }
        return null;
    }
    
    public String getAddressUser(String useId) throws NamingException, SQLException{
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        try{
            connection = MyConnection.makeConnection();
            if(connection!=null){
                String sql="select Address "
                        + "from [User] "
                        + "where UserID=? ";
                statement = connection.prepareStatement(sql);
                statement.setString(1, useId);
                resultSet = statement.executeQuery();
                if(resultSet.next()){
                    String address= resultSet.getNString("Address");
                    return address;
                }
            }
        }finally{
            if(resultSet!=null) resultSet.close();
            if(statement!=null) statement.close();
            if(connection!=null) connection.close();
        }
        return "";
    }
    
}































