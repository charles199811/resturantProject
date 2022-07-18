.
<%@page import="java.text.DecimalFormat"%>
<%@page import="hotel.dao.OrderDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="hotel.dao.ProductDao"%>
<%@page import="hotel.dao.ProductDao"%>
<%@page import="hotel.model.*"%>
<%@page import="hotel.connection.DbCon"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>


<%
    DecimalFormat dcf = new DecimalFormat("#.##");
    request.setAttribute("dcf", dcf);
    User auth = (User) request.getSession().getAttribute("auth");
    List<Order> orders = null;
    if (auth != null) {
        request.setAttribute("auth", auth);
        OrderDao orderDao = new OrderDao(DbCon.getConnection());
        orders = orderDao.userOrders(auth.getId());
    } else {
        response.sendRedirect("login.jsp");
    }
    ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
    if (cart_list != null) {
        request.setAttribute("cart_list", cart_list);
    }

%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="/includes/head.jsp"%>
        <title>E-Commerce Cart</title>
        <link href="css/carttable.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
            <%@include file="/includes/navbar.jsp"%>
        <div class="container">
            <div class="card-header my-3">All Orders</div>
           <table>
                <thead>
                    <tr>
                        <th scope="col">Date</th>
                        <th scope="col">Name</th>
                        <th scope="col">Category</th>
                        <th scope="col">Quantity</th>
                        <th scope="col">Price</th>
                        <th scope="col">Cancel</th>
                    </tr>
                </thead>
                <tbody>

                    <%                        if (orders != null) {
                            for (Order o : orders) {%>
                    <tr>
                        <td><%=o.getDate()%></td>
                        <td><%=o.getName()%></td>
                        <td><%=o.getCategory()%></td>
                        <td><%=o.getQunatity()%></td>
                        <td><%=dcf.format(o.getPrice())%></td>
                        <td><a class="btn1 btn-sm btn-danger" href="CancelOrder-Servlet?id=<%=o.getOrderId()%>">Cancel Order</a></td>
                    </tr>
                    <%}
                        }
                    %>

                </tbody>
            </table>
        </div>
        
    </body>
</html>
