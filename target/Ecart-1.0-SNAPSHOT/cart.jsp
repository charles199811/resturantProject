<%@page import="hotel.dao.ProductDao"%>
<%@page import="java.util.*"%>

<%@page import="hotel.model.*"%>
<%@page import="hotel.connection.DbCon"%>
<%@page import="java.text.DecimalFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    DecimalFormat dcf = new DecimalFormat("#.##");
    request.setAttribute("dcf", dcf);

    User auth = (User) request.getSession().getAttribute("auth");
    if (auth != null) {
        request.setAttribute("auth", auth);
    }

    ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
    List<Cart> cartProduct = null;
    if (cart_list != null) {
        ProductDao pDao = new ProductDao(DbCon.getConnection());
        cartProduct = pDao.getCartProducts(cart_list);

        request.setAttribute("cart_list", cart_list);
        double total = pDao.getTotalCartPrice(cart_list);
        request.setAttribute("total", total);

    }
%>
<!DOCTYPE html>
<html>
    <head>

        <title>JSP Page</title>
        <%@include file="/includes/head.jsp"%>
        
        
        <link href="css/carttable.css" rel="stylesheet" type="text/css"/>
        
    


        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>

            <header>
            <%@include file="/includes/navbar.jsp"%>
        </header>
        <div class="container">
            <div class="d-flex py-3"><h3>Total Price:$ ${(total>0)? dcf.format(total):0} </h3> 
                <a class="mx-3 btn btn-primary" href="checkOut-Servlet">Check Out </a></div>

            <table>
                <thead>
                    <tr>
                        <th scope="col">Name</th>
                        <th scope="col">Category</th><!-- comment -->
                        <th scope="col">Price</th><!-- comment -->
                        <th scope="col">Buy Now</th><!-- comment -->
                        <th scope="col">Cancel</th>
                    </tr>
                </thead>
                <tbody>
                    <%                        if (cart_list != null) {
                            for (Cart c : cartProduct) {%>

                    <tr>
                        <td><%= c.getName()%></td>
                        <td><%= c.getCategory()%></td>
                        <td><%= dcf.format(c.getPrice())%> </td>
                        <td>
                            <form action="Order-Now " method="post" class="form-inline">                            
                                <input type="hidden" name="id" value="<%= c.getId()%>" class="form-input">
                                <div class="form-group d-flex justify-content-between w-50">
                                    <a class="btn btn-sm btn decre" href="quantity-incDecServlet?action=dec&id=<%= c.getId()%>"><i class="fas fa-minus-square "></i></a>
                                    <input type ="text" name="quantity" class="form-control w-50" value="<%=c.getQuantity()%>" readonly>
                                    <a class="btn btn-sm btn incre" href="quantity-incDecServlet?action=inc&id=<%= c.getId()%>"><i class="fas fa-plus-square "></i></a>
                                </div>
                                <button type="submit" class="btn-primary btn-sm">Buy</button>                       
                            </form>
                        </td>
                        <td><a href="remove-from-cart?id=<%=c.getId()%>" class="btn btn-sm btn-danger">Remove</a></td>
                    </tr>
                    <%}
                        }
                    %>    
                </tbody>
            </table>
        </div>
                
        
    </body>
</html>
