

<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.blog.entities.Category"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.entities.Message"%>
<%@page import="com.tech.blog.entities.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="error_page.jsp"%>

<%
    User user=(User)session.getAttribute("currentUser");
    if(user==null)
    {
        response.sendRedirect("login_page.jsp");
    }
    %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        
         <!--css-->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link href="css/mycss.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <style>
            .banner-background
            {
               clip-path: polygon(30% 0%, 100% 1%, 100% 30%, 100% 100%, 75% 90%, 32% 95%, 0 100%, 0 0);
            }
            body{
                background: url(img/back1.jpg);
                background-size: cover;
                background-attachment: fixed;
            }
        </style>
    </head>
    <body>
        <%--<%= user.getName()%>
        <br>
        <%=user.getEmail()%>
        <br>
        <%=user.getAbout()%> --%>
        
        <!--start of navbar-->
        
         <nav class="navbar navbar-expand-lg navbar-dark primary-background">
    <a class="navbar-brand" href="index.jsp"> <span class="fa fa-star-o"></span> TechBlog</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <!--<li class="nav-item active">
          <a class="nav-link" href="#"><span class="fa fa-home"></span>Home <span class="sr-only">(current)</span></a>
      </li>-->
      
      <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><span class="fa fa-pencil-square-o"></span>
          Categories
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item" href="#">Action</a>
          <a class="dropdown-item" href="#">Another action</a>
          <div class="dropdown-divider"></div>
          <a class="dropdown-item" href="#">Something else here</a>
        </div>
      </li>
     <!-- <li class="nav-item">
        <a class="nav-link disabled" href="#">Disabled</a>
      </li>-->
      <li class="nav-item">
          <a class="nav-link" href="#"> <span class="fa fa-address-card"></span>Contact</a>
      </li>
      <li class="nav-item">
          <a class="nav-link" href="#" data-toggle="modal" data-target="#add-post-modal"> <span class="fa fa-asterisk"></span>Do Post</a>
      </li>
      
      
    </ul>
    <!--<form class="form-inline my-2 my-lg-0">
      <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
      <button class="btn btn-outline-light my-2 my-sm-0" type="submit">Search</button>
    </form>-->
    <ul class="navbar-nav mr-right">
        <li class="nav-item">
          <a class="nav-link" href="#" data-toggle="modal" data-target="#profile-modal"> <span class="fa fa-user-circle"></span><%=user.getName()%></a>
      </li>
        <li class="nav-item">
          <a class="nav-link" href="LogoutServlet"> <span class="fa fa-user-plus"></span>Log out</a>
      </li>
    </ul>
  </div>
</nav>
  
        <!--end of navbar-->
        
         <%
                                Message m=(Message)session.getAttribute("msg");
                                if(m!=null)
                                {
                                    %>
                                    <div class="alert <%=m.getCssClass()%>"role="alert">
                                        <%=m.getContent()%>
                                    </div>
                                    <%
                                        session.removeAttribute("msg");                                 
                                  }
                                %>
                                
    <!--main body of profile-->
    
    <main>
        <div class="container">
            <div class="row mt-4">
                <!--first col-->
                <div class="col-md-4">
                    <!--categories-->
                    <!--using bootstrap list groups links and buttons-->
                  <div class="list-group">
                  <a href="#" onclick="getPosts(0,this)" class=" c-link list-group-item list-group-item-action active">
                    All Posts
                  </a>
                      <!--fetching categories from database-->
                      <%
                          PostDao p=new PostDao(ConnectionProvider.getConnection());
                          ArrayList<Category> list1=p.getAllCategories();
                          for(Category cc:list1){

                          %>
                  <a href="#" onclick="getPosts(<%= cc.getCid() %>,this)" class=" c-link list-group-item list-group-item-action"><%=cc.getName()%></a>
                  <%
                      }
                      %>
                  
                  </div>
                </div>
                <!--second col-->
                <div class="col-md-8">
                    <!--posts-->
                    <div class="container text-center" id="loader">
                        <i class="fa fa-refresh fa-4x fa-spin"></i>
                        <h3 class="mt-2">Loading....</h3>
                    </div>
                
                <div class="container-fluid" id="post-container">
                    
                </div>
               </div>     
            </div>
        </div>
    </main>
    <!--end of main body-->
        
        <!--profile modal-->
        
        <!-- Button trigger modal -->
<!--<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#profile-Modal">
  <!--Launch demo modal
</button>-->

<!-- Modal -->
<div class="modal fade" id="profile-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header primary-background text-center text-white">
        <h5 class="modal-title" id="exampleModalLabel">TechBlog</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      <div class="container text-center">
              <img src="pics/<%=user.getProfile()%>" class="image-fluid" style="border-radius:50%; max-width:150px;">
              <h5 class="modal-title mt-3" id="exampleModalLabel"><%=user.getName()%></h5>
              <!--details-->
        <div id="profile-details">     
         <table class="table">
          <!--<thead>
            <tr>
              <th scope="col">#</th>
              <th scope="col">First</th>
              <th scope="col">Last</th>
              <th scope="col">Handle</th>
            </tr>
          </thead>-->
          <tbody>
            <tr>
              <th scope="row">ID :</th>
              <td><%=user.getId()%></td>
             
            </tr>
            <tr>
              <th scope="row">Email :</th>
              <td><%=user.getEmail()%></td>
              
            </tr>
            <tr>
              <th scope="row">Gender :</th>
              <td><%=user.getGender()%></td>
              
            </tr>
            <tr>
              <th scope="row">About :</th>
              <td><%=user.getAbout()%></td>
              
            </tr>
            <tr>
              <th scope="row">Registered On :</th>
              <td><%=user.getRdate().toString()%></td>
              
            </tr>
          </tbody>
        </table>
        </div> 
              <!--profile edit-->
              <div id="profile-edit" style="display:none;">
                  <h3 class="mt-2">Please edit carefully</h3>
                  <form action="EditServlet" method="POST" enctype="multipart/form-data">
                      <table class="table">
                          <tr>
                              <td>ID :</td>
                              <td><%=user.getId()%></td>
                          </tr>
                          <tr>
                              <td>Email :</td>
                              <td>
                                  <input type="email" class="form-control" name="user_email" value="<%=user.getEmail()%>">
                              </td>
                          </tr>
                          <tr>
                              <td>Name :</td>
                              <td>
                                  <input type="text" class="form-control" name="user_name" value="<%=user.getName()%>">
                              </td>
                          </tr>
                          <tr>
                              <td>Password :</td>
                              <td>
                                  <input type="password" class="form-control" name="user_password" value="<%=user.getPassword()%>">
                              </td>
                          </tr>
                          <tr>
                              <td>Gender :</td>
                              <td><%=user.getGender().toUpperCase()%></td>
                          </tr>
                          <tr>
                              <td>About :</td>
                              <td>
                                  <textarea rows="3" class="form-control " name= "user_about">
                                      <%=user.getAbout()%>
                                  </textarea>
                              </td>
                          </tr>
                          <tr>
                              <td>New Profile:</td>
                              <td>
                                  <input type="file" class="form-control" name="image">
                              </td>
                          </tr>
                      </table>
                                  
                       <!--button-->  
                     <div class="container">  
                       <button type="submit" class="btn btn-outline-primary">Save</button>
                     </div>
                  </form>
              </div>  
      </div>
     </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" id="edit-profile-button" class="btn btn-primary">Edit</button>
      </div>
    </div>
  </div>
</div>
  <!--end of profile modal-->
  
  <!--add post modal-->
  
  <!-- Button trigger modal -->

<!-- Modal -->
<div class="modal fade" id="add-post-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Provide the Post Details</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
          
          <form id="add-post-form" action="AddPostServlet" method="post">
              <div class="form-group">
                  <select class="form-control" name="cid">
                      <option selected disabled>---Select Categories---</option>
                      <%
                          PostDao pstd=new PostDao(ConnectionProvider.getConnection());
                          ArrayList<Category> l=pstd.getAllCategories();
                          for(Category c:l)
                          {
                              
                          
                          %>
                      <option value="<%=c.getCid()%>"><%= c.getName()%></option>
                      <%
                          }
                      %>
                      
                  </select>
              </div>
              <div class="form-group">
                  <input name="pTitle"type="text" placeholder="Enter Post Title" class="form-control"/>
              </div>
              <div class="form-group">
                  <textarea name="pContent" class="form-control" style="height:200px;" placeholder="Enter your content"></textarea>
              </div>
              <div class="form-group">
                  <textarea  name="pCode" class="form-control" style="height:200px;" placeholder="Enter your program(if any)"></textarea>
              </div>
              <div class="form-group">
                  <label>Select ur pic...</label>
                  <br>
                  <input name="pPic" type="file">
              </div>
                      <div class="container text-center">
                          <button type="submit" class="btn-outline-primary">Post</button>
                      </div>      
          </form>
        ...
      </div>
      
    </div>
  </div>
</div>
  <!--end of post modal-->
        <!--javascript-->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>        
       <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
       <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
       <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
       <script src="js/myjs.js" type="text/javascript"></script>
       <script>
           $(document).ready(function(){
              
                let editStatus=false;
              $('#edit-profile-button').click(function(){
                  //alert("edit details")
                 if(editStatus==false)
                 {
                  $('#profile-details').hide()
                  $('#profile-edit').show()
                  editStatus=true;
                  $(this).text("BACK")
              }
              else
              {
                  $('#profile-details').show()
                  $('#profile-edit').hide()
                  editStatus=false;
                  $(this).text("EDIT")
              }
              })
           });
       </script>
       <!--- now add post js--->
       <script>
           $(document).ready(function(e){
               
               $("#add-post-form").on("submit",function(event){
                   //this get called when form is submitted
                   
                   event.preventDefault();//stops normal behaviour of form i.e synchronous behaviour
                   console.log("clicked on submit");
                   let form=new FormData(this);
                   //now requestng to server
                   
                   $.ajax({
                       
                       url:"AddPostServlet",
                       type:'POST',
                       data:form,
                       success: function(data,textStatus,jqXHR)
                       {
                         console.log(data); 
                         if(data.trim()=='done')
                         {
                             swal("Good job!", "Saved Successfully!", "success");
                         }
                         else
                         {
                             swal("Error!", "Something Went Wrong!", "error");
                         }
                       },
                       error: function(jqXHR,textStatus,errorThrown)
                       {
                           swal("Error!", "Something Went Wrong!", "error");
                       },
                       processData: false,
                       contentType: false
                   })
               })
           })
       </script>
       
       <!--load post using ajax-->
       
       <script>
           
           function getPosts(catId,temp){
              
                $("#loader").show();
                $("#post-container").hide();
                
                //active link implementation
                $(".c-link").removeClass('active')
                $.ajax({
                   
                   url: "load_posts.jsp",
                   data: {cid: catId},
                   success: function(data,textStatus,jqXHR)
                   {
                      console.log(data);
                      $("#loader").hide();
                      $("#post-container").show();
                      $("#post-container").html(data);
                      $(temp).addClass('active');
                   }
               })
           }
           $(document).ready(function(e){
               let allPostRef=$('.c-link')[0]
              getPosts(0,allPostRef)
           })
       </script>
    </body>
</html>
