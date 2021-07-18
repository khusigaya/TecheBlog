<%-- 
    Document   : error_page
    Created on : Apr 11, 2021, 2:10:55 AM
    Author     : kkkkkk
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page isErrorPage="true"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>error page</title>
        
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
       <div class="container text-center">
        <img src="img/error.png" class="img-fluid " style="height:400px;">
        <h4 class="display-3">Sorry ! Something Went Wrong...</h4>
        <%=exception%>
        <a href="index.jsp" class="btn primary-background btn-lg text-white mt-3">Home<a>
       </div>
    </body>
</html>
