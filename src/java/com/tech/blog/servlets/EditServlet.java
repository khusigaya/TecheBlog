/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tech.blog.servlets;

import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.Message;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import com.tech.blog.helper.Helper;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Paths;
import java.sql.Blob;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author kkkkkk
 */

 @MultipartConfig(fileSizeThreshold=1024*1024*2,
         maxFileSize=1024*1024*10,
         maxRequestSize=1024*1024*50)
public class EditServlet extends HttpServlet {

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
        PrintWriter out = response.getWriter();
        try {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EditServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            //out.println("<h1>Servlet EditServlet at " + request.getContextPath() + "</h1>");
            //fetch all data
            String userEmail=request.getParameter("user_email");
            String userName=request.getParameter("user_name");
            String userPassword=request.getParameter("user_password");
            String about=request.getParameter("user_about");
            Part filePart=request.getPart("image");
           String fileName=extractFileName(filePart);
            //get the user from the session
            
            HttpSession s=request.getSession();
            User user=(User)s.getAttribute("currentUser");
            user.setEmail(userEmail);
            user.setName(userName);
            user.setPassword(userPassword);
            user.setAbout(about);
            String oldProfile=user.getProfile();
            user.setProfile(fileName);
            
            //update Database
            UserDao d=new UserDao(ConnectionProvider.getConnection());
            boolean ans=d.updateUser(user);
            if(ans)
            {
                out.println("updated to Database");
                
                String path=request.getRealPath("/")+"pics"+File.separator+user.getProfile();
                //delete code
                String oldpath=request.getRealPath("/")+"pics"+File.separator+oldProfile;
                if(!oldpath.equals("default.png"))
                {
                  Helper.deleteFile(oldpath);
                }
                
                    if(Helper.saveFile(filePart.getInputStream(), path))
                    {
                         out.println("updated to Database");
                         
                          Message msg=new Message("Profile updated.....","success","alert-success");
                         
                 
                          s.setAttribute("msg",msg);
                    }
                    else
                    {
                        out.println("path not saved successfullly");
                         Message msg=new Message("Invalid details ! try with another","error","alert-danger");
                        s.setAttribute("msg",msg);
                    }
                }
               
            
            else
            {
                out.println("not updated");
                Message msg=new Message("Invalid details ! try with another","error","alert-danger");
                 s.setAttribute("msg",msg);
            }
            response.sendRedirect("profile.jsp");
            out.println("</body>");
            out.println("</html>");
        } finally {
            out.close();
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

    private String extractFileName(Part filePart) {
     
      
        for (String cd : filePart.getHeader("content-disposition").split(";")) {
        if (cd.trim().startsWith("filename")) {
            String fileName = cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
            return fileName.substring(fileName.lastIndexOf('/') + 1).substring(fileName.lastIndexOf('\\') + 1); // MSIE fix.
        }
    }
    return null;
    }

}
