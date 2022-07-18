<%-- 
    Document   : index
    Created on : Dec 1, 2021, 12:22:12 AM
    Author     : MSI
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="hotel.dao.ProductDao"%>
<%@page import="hotel.model.*"%>
<%@page import="hotel.connection.DbCon"%> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<%
    User auth = (User) request.getSession().getAttribute("auth");
    if (auth != null) {
        request.setAttribute("auth", auth);
    }
    ProductDao pd = new ProductDao(DbCon.getConnection());
    List<Product> products = pd.getAllProducts();

    ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
    List<Cart> cartProduct = null;
    if (cart_list != null) {
        ProductDao pDao = new ProductDao(DbCon.getConnection());
        cartProduct = pDao.getCartProducts(cart_list);
        double total = pDao.getTotalCartPrice(cart_list);
        request.setAttribute("total", total);
        request.setAttribute("cart_list", cart_list);
    }

%>


<!DOCTYPE html>
<html>
    <head>
        <%@include file="/includes/head.jsp"%>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="css/menuCard.css" rel="stylesheet" type="text/css"/>
        
        
    </head>
    <body>

        <%@include file="/includes/navbar.jsp"%>

        <div class="container">
            <div class="card-header my-3">All Products</div>
            <div class="row">
                <%                    if (!products.isEmpty()) {
                        for (Product p : products) {
                %>
                <div class="col-md-3 my-3">
                    <div class="card w-100">
                        <img class="card-img-top" src="images/<%=p.getImage()%>"
                             alt="Card image cap">
                        <div class="card-body">
                            <h5 class="card-title"><%=p.getName()%></h5>
                            <h6 class="price">Price: $<%=p.getPrice()%></h6>
                            <h6 class="category">Category: <%=p.getCategory()%></h6>
                            <div class="mt-3 d-flex justify-content-between">
                                <a class="btn btn-dark" href="add-To-card?id=<%=p.getId()%>">Add to Cart</a> <a
                                    class="btn btn-primary" href="Order-Now?quantity=1&id=<%=p.getId()%>">Buy Now</a>
                            </div>
                        </div>
                    </div>
                </div>
                <%
                        }
                    } else {
                        out.println("There is no proucts");
                    }
                %>

            </div>
        </div>
        <%@include file="/includes/footer.jsp"%>
    </body>


</html>
