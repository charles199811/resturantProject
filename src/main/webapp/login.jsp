<%-- 
    Document   : login
    Created on : Dec 1, 2021, 12:23:26 AM
    Author     : MSI
--%>
<%@page import="hotel.dao.ProductDao"%>
<%@page import="hotel.connection.DbCon"%>
<%@page import="java.util.*"%>
<%@page import="hotel.model.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    User auth = (User) request.getSession().getAttribute("auth");
    if (auth != null) {

        response.sendRedirect("index.jsp");
    }
    ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
    List<Cart> cartProduct = null;
    if (cart_list != null) {
        ProductDao pDao = new ProductDao(DbCon.getConnection());
        cartProduct = pDao.getCartProducts(cart_list);
//        double total = pDao.getTotalCartPrice(cart_list);
//        request.setAttribute("total", total);
        request.setAttribute("cart_list", cart_list);
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="/includes/head.jsp"%>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        
        <link href="css/loginStyle.css" rel="stylesheet" type="text/css"/>

    </head>

    <body>
        

        <!-- comment below is my old login form -->
        <!--        <div class="container">
                   <div class="card w-50 mx-auto my-5">
                       <div class="card-header text-center">User Login</div>
                       <div class="card-body">
                           <form action="user-login" method="post">
                               <div class="form-group">
                                   <label>Email address</label> 
                                   <input type="email" name="login-email" class="form-control" placeholder="Enter email">
                               </div>
                               <div class="form-group">
                                   <label>Password</label> 
                                   <input type="password" name="login-password" class="form-control" placeholder="Password">
                               </div>
                               <div class="text-center">
                                   <button type="submit" class="btn btn-primary">Login</button>
                               </div>
                           </form>
                       </div>
                   </div>
               </div>-->
        
        <div class="container" id="container">
            <div class="form-container sign-up-container">
                <form action="#">
                    <h1>Create Account</h1>
                    <div class="social-container">
                        <a href="#" class="social"><i class="fab fa-facebook-f"></i></a>
                        <a href="#" class="social"><i class="fab fa-google-plus-g"></i></a>
                        <a href="#" class="social"><i class="fab fa-linkedin-in"></i></a>
                    </div>
                    <span>or use your email for registration</span>
                    <input type="text" placeholder="Name" />
                    <input type="email" placeholder="Email" />
                    <input type="password" placeholder="Password" />
                    <button>Sign Up</button>
                </form>
            </div>
            <div class="form-container sign-in-container">
                <form action="user-login" method="post">
                    <h1>Sign in</h1>
                    <div class="social-container">
                        <a href="#" class="social"><i class="fab fa-facebook-f"></i></a>
                        <a href="#" class="social"><i class="fab fa-google-plus-g"></i></a>
                        <a href="#" class="social"><i class="fab fa-linkedin-in"></i></a>
                    </div>
                    <span>or use your account</span>
                    <input type="email" name="login-email" class="form-control" placeholder="Enter email">
                    <input type="password" name="login-password" class="form-control" placeholder="Password">
                    <a href="#">Forgot your password?</a>
                    <button>Sign In</button>
                </form>
            </div>
            <div class="overlay-container">
                <div class="overlay">
                    <div class="overlay-panel overlay-left">
                        <h1>Welcome Back!</h1>
                        <p>To keep connected with us please login with your personal info</p>
                        <button class="ghost" id="signIn">Sign In</button>
                    </div>
                    <div class="overlay-panel overlay-right">
                        <h1>Hello, Friend!</h1>
                        <p>Enter your personal details and start journey with us</p>
                        <button class="ghost" id="signUp">Sign Up</button>
                    </div>
                </div>
            </div>
        </div>

        <footer>
            <p>
                YUMMY KIGNDOM
        </footer>
        
    </body>
</html>
