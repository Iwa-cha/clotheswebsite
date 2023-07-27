<%@page import="model.Product"%>
<%@page import="DAO.ProductDAO" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Product</title>

    <style>
        input {
            width: 350px;
            margin: 10px 0;
            height: 30px;
            padding: 0 10px;
            box-sizing: border-box;
        }

        select {
            width: 350px;
            margin: 10px 0;
            height: 30px;
        }

        h1 {
            text-align: center;
            margin: 50px;
        }

        .add-product-form {
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .add-product-btn {
            margin-top: 30px;
            width: 100px;
            padding: 5px 0;
        }
    </style>
</head>

<body>

    <h1>Add Product</h1>

    <div class="add-product-form">
    
    	<%
    		int id = Integer.parseInt(request.getParameter("productID"));
    		ProductDAO productdao = new ProductDAO();
    		Product p = productdao.getProductById(id);
    	%>
    
        <form action="../ProductOperationServlet" Method="Post" enctype="multipart/form-data">
        
        	<input type="hidden" name="operation" value="editProduct">
        	<input type="hidden" name="id" value="<%=id%>">
        	<input type="hidden" name="oldCategory" value="<%=p.getCategory() %>">
        	<input type="hidden" name="oldBrand" value="<%=p.getBrand()%>">

            <div>
                <input type="text" name="name" value="<%=p.getName() %>" required>
            </div>

            <div>
                <select name="category">
                    <option value="">Select Category</option>
                    <option value="men">Men</option>
                    <option value="women">Women</option>
                </select>
            </div>

            <div>
                <select name="brand">
                    <option value="">Select Brand</option>
                    <option value="addidas">Addidas</option>
                    <option value="zara">Zara</option>
                    <option value="lewis">lewis</option>
                </select>
            </div>

            <div>
                <input type="number" name="price" step="any" min="1" value="<%=p.getPrice() %>" required>
            </div>

            <div>
                <input type="number" name="rating" step="0.1" min="1" max="5" value="<%=p.getRating() %>" required>
            </div>

            <div>
                <input type="number" name="stock" min="1" placeholder="Stock" value="<%=p.getStock() %>" required>
            </div>

           <div style="text-align:center;">
	            <button class="add-product-btn" type="submit">Update</button>
	            
	            <br> <br>
	            
	            <a href="#">Back to Dashboard</a>
            </div>

        </form>
        
        
    </div>

</body>

</html>