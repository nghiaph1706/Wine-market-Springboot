<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<section class="trending_items">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="section_tittle text-center">
                        <h2>Trending Items</h2>
                    </div>
                </div>
            </div>
            <div class="row">
            	<c:forEach var="product" items="${products.content}">
            		<div class="col-lg-4 col-sm-6">
                    <div class="single_product_item">
                        <div class="single_product_item_thumb">
                            <img src="/assets/img/product/${product.image }" alt="#" class="img-fluid">
                        </div>
                        <h3> <a href="/product/details?productId=${product.id }">${product.name }</a> </h3>
                        <p>$${product.price }</p>
                    </div>
                </div>
            	</c:forEach>
            </div>
        </div>
    </section>
</body>
</html>