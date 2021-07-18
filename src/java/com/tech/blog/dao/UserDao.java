/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tech.blog.dao;

/**
 *
 * @author kkkkkk
 */
import com.tech.blog.entities.User;
import java.sql.*;
public class UserDao {
    
    public Connection con;

    public UserDao(Connection con) {
        this.con = con;
    }

    
    
    //method to insert user to database
    public boolean saveUser(User user)
    {
         boolean f=false;
        try
        {
           String query="insert into techuser(name,email,password,gender,about)values(?,?,?,?,?)";
           PreparedStatement pstmt=this.con.prepareStatement(query);
           pstmt.setString(1,user.getName());
           pstmt.setString(2,user.getEmail());
           pstmt.setString(3,user.getPassword());
           pstmt.setString(4,user.getGender());
           pstmt.setString(5,user.getAbout());
           
           pstmt.executeUpdate();
           f=true;
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return f;
    }
    
    //get user by usermail and password
    public User getUserByEmailAndPassword(String email,String password)
    {
        User user=null;
        
        try
        {
            String query="select * from techuser where email=? and password=?";
            PreparedStatement pst=con.prepareStatement(query);
            pst.setString(1,email);
            pst.setString(2,password);
            
            ResultSet rst=pst.executeQuery();
            if(rst.next())
            {
                user=new User();
                //data from db
                String name=rst.getString("name");
                //set data into user object
                user.setName(name);
                user.setId(rst.getInt("id"));
                user.setEmail(rst.getString("email"));
                user.setPassword(rst.getString("password"));
                user.setGender(rst.getString("gender"));
                user.setAbout(rst.getString("about"));
                user.setRdate(rst.getTimestamp("rdate"));
                user.setProfile(rst.getString("profile"));
            }
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        
        return user;
    }
    public boolean updateUser(User user)
    {
        boolean f=false;
        try
        {
           String query= "update techuser set name=? , email=? , password=? , gender=? , about=? , profile=? where id=?";
           PreparedStatement p=con.prepareStatement(query);
           p.setString(1, user.getName());
           p.setString(2,user.getEmail());
           p.setString(3,user.getPassword());
           p.setString(4,user.getGender());
           p.setString(5,user.getAbout());
           p.setString(6,user.getProfile());
           p.setInt(7,user.getId());
           
           p.executeUpdate();
           f=true;
      }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return f;
    }
    public User getUserByUserId(int userId)
   {
      User u=null;
      
      
      try
      {
          String q="select * from techuser where id=?";
      PreparedStatement pst=this.con.prepareStatement(q);
      pst.setInt(1,userId);
      ResultSet rs=pst.executeQuery();
      
      if(rs.next())
      {
           u=new User();
                //data from db
                String name=rs.getString("name");
                //set data into user object
                u.setName(name);
                u.setId(rs.getInt("id"));
                u.setEmail(rs.getString("email"));
                u.setPassword(rs.getString("password"));
                u.setGender(rs.getString("gender"));
                u.setAbout(rs.getString("about"));
                u.setRdate(rs.getTimestamp("rdate"));
                u.setProfile(rs.getString("profile"));
      }
      }
      catch(Exception e)
      {
          e.printStackTrace();
      }
      
      return u;
   }
    
}
