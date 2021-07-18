/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tech.blog.dao;

import com.tech.blog.entities.Category;
import com.tech.blog.entities.Post;
import com.tech.blog.entities.User;
import java.security.Timestamp;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.sql.PreparedStatement;
import java.util.List;


/**
 *
 * @author kkkkkk
 */
public class PostDao {
    
    Connection con;

    public PostDao(Connection con) {
        this.con = con;
    }
    public ArrayList<Category> getAllCategories()
    {
        ArrayList <Category> list=new ArrayList<>();
        
        try
        {
            String q="select * from categories";
            Statement s=this.con.createStatement();
            ResultSet set=s.executeQuery(q);
            
            while(set.next())
            {
                int cid=set.getInt("cid");
                String name=set.getString("name");
                String description=set.getString("description");
                Category c=new Category(cid,name,description);
                list.add(c);
            }
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        
        return list;
    }
    
    public boolean savePost(Post p)
    {
        boolean f= false;
        
        try
        {
          String q="insert into posts(pTitle,pContent,pCode,pPic,catId,userId) values(?,?,?,?,?,?)";
           PreparedStatement pstmt=con.prepareStatement(q);
           
           pstmt.setString(1,p.getpTitle());
           pstmt.setString(2,p.getpContent());
           pstmt.setString(3,p.getpCode());
           pstmt.setString(4,p.getpPic());
           pstmt.setInt(5,p.getCatId());
           pstmt.setInt(6,p.getUserId());
           pstmt.executeUpdate();
           f=true;
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return f;
        
    }
   
    //get all posts
   public List<Post> getAllPosts()
   {
      List<Post> l=new ArrayList<>(); 
      
      try
      {
          PreparedStatement pst=con.prepareStatement("select * from posts order by pid desc");
          ResultSet res=pst.executeQuery();
          while(res.next())
          {
              int pid=res.getInt("pid");
              String pTitle=res.getString("pTitle");
              String pContent=res.getString("pContent");
              String pCode=res.getString("pCode");
              String pPic=res.getString("pPic");
              java.sql.Timestamp date= res.getTimestamp("pDate");
              int catId=res.getInt("catId");
              int userId=res.getInt("userId");
              
              Post p=new Post(pid,pTitle,pContent,pCode,pPic,date,catId,userId); 
              l.add(p);
          }
      }
      catch(Exception e)
      {
          e.printStackTrace();
      }
      return l;
   }
    
   
   //get posts by catid
   public List<Post> getPostByCatId(int catId)
   {
        List<Post> l=new ArrayList<>(); 
        
        try
        {
        PreparedStatement pst=con.prepareStatement("select * from posts where catId=?");
        pst.setInt(1,catId);
          ResultSet res=pst.executeQuery();
          while(res.next())
          {
              int pid=res.getInt("pid");
              String pTitle=res.getString("pTitle");
              String pContent=res.getString("pContent");
              String pCode=res.getString("pCode");
              String pPic=res.getString("pPic");
              java.sql.Timestamp date= res.getTimestamp("pDate");
             // int catId=res.getInt("catId");
              int userId=res.getInt("userId");
              
              Post p=new Post(pid,pTitle,pContent,pCode,pPic,date,catId,userId); 
              l.add(p);
          }
      }
      catch(Exception e)
      {
          e.printStackTrace();
      }
      
      return l;
   }
   
   public Post getPostByPostId(int postId)
   {
       Post post=null;
       String q="select * from posts where pid=?";
       try
       {
       PreparedStatement p=this.con.prepareStatement(q);
       p.setInt(1, postId);
       ResultSet rs=p.executeQuery();
       if(rs.next())
       {
           int pid=rs.getInt("pid");
              String pTitle=rs.getString("pTitle");
              String pContent=rs.getString("pContent");
              String pCode=rs.getString("pCode");
              String pPic=rs.getString("pPic");
              java.sql.Timestamp date= rs.getTimestamp("pDate");
              int catId=rs.getInt("catId");
              int userId=rs.getInt("userId");
              
              post=new Post(pid,pTitle,pContent,pCode,pPic,date,catId,userId); 
              
       }
       }
       catch(Exception e)
       {
           e.printStackTrace();
       }
       return post;
   }
   
   
}
