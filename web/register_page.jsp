<%-- 
    Document   : register_page
    Created on : Apr 9, 2021, 11:52:31 PM
    Author     : kkkkkk
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        </style>
    </head>
    <body>
        <%@include file="normal_navbar.jsp" %>
    <main class="primary-background" style="padding-bottom:70px; padding-top:30px; ">
            <div class="container">
                <div class="col-md-6 offset-md-3">
                    <div class="card">
                        <div class="card-header primary-background text-white text-center"><span class="fa fa-user-circle fa-3x"></span>
                            <br>
                            Register Here
                        </div>
                        <div class="card-body">
                               <form id="reg-form" action="RegisterServlet" method="POST">
    
    <div class="form-group">
    <label for="user_name">User name</label>
    <input name="user_name" type="text" class="form-control" id="user_name" aria-describedby="emailHelp" placeholder="Enter user">
    
  </div>                               
  <div class="form-group">
    <label for="exampleInputEmail1">Email address</label>
    <input type="email" name="user_email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email">
    <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
  </div>
  <div class="form-group">
    <label for="exampleInputPassword1">Password</label>
    <input name="user_password" type="password" class="form-control" id="exampleInputPassword1" placeholder="Password">
  </div>
   <div class="form-group">
    <label for="gender">Select gender</label>
    <br>
    <input type="radio"  id="gender" name="gen" value="male">Male
    <input type="radio"  id="gender" name="gen" value="female">Female
  </div>      
  <div class="form-group">
      <textarea name="about" class="form-control" rows="5" placeholder="Enter something about yourself"></textarea>
  </div>
  <div class="form-check">
    <input name="check" type="checkbox" class="form-check-input" id="exampleCheck1">
    <label class="form-check-label" for="exampleCheck1">Agree Terms and Conditions</label>
  </div>
                                   <br>
                                  <div class="container text-center" id="loader" style="display:none;"> 
                                   <span class="fa fa-refresh fa-spin fa-3x"></span> 
                                   <h4>Please wait...</h4>
                                  </div> 
                                   <br>
  <button type="submit" id="submit-btn" class="btn btn-primary">Submit</button>
</form>
                        </div>
                        
                    </div>
                </div>
            </div>
        </main>
        
        <!--javascript-->
        
       <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous">
       <!--<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js">/script>-->
       <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
       <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
       <script src="js/myjs.js" type="text/javascript"></script>
       <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
       <script>
           $(document).ready(function(){
               console.log("loaded...")
               //when form will submit this function called
               $('#reg-form').on('submit',function(event){
                  
                   event.preventDefault();
                   let form=new FormData(this);
                   
                   $("#submit_btn").hide();
                   $("#loader").show();
                   //send to registerservlet
                   $.ajax({
                       
                       url:"RegisterServlet",
                       type:'POST',
                       data:form,
                       success: function(data,textstatus,jqXHR)
                       {
                           console.log(data)
                           $("#submit_btn").show();
                           $("#loader").hide();
                           
                           //sweet alert library
                           if(data.trim()==='done')
                           {     
                           swal("Successfully registered....Directing to Login page")
                           .then((value) => {
                             window.location="login_page.jsp"
                          });
                         }
                         else
                         {
                             swal(data);
                         }
                       },
                       error: function(jqXHR,textstatus,errorThrown)
                       {
                          console.log(jqXHR) 
                          $("#submit_btn").show();
                           $("#loader").hide();
                       },
                       processData: false,
                       contentType: false
                   });
                   
               });
                              
           });
       </script>
    </body>
</html>
