<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Product | Wine-market</title>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="icon" href="/assets/img/favicon.png">
<link rel="stylesheet" href="/assets/css/bootstrap.min.css">
<link rel="stylesheet" href="/assets/css/animate.css">
<link rel="stylesheet" href="/assets/css/owl.carousel.min.css">
<link rel="stylesheet" href="/assets/css/all.css">
<link rel="stylesheet" href="/assets/css/flaticon.css">
<link rel="stylesheet" href="/assets/css/themify-icons.css">
<link rel="stylesheet" href="/assets/css/magnific-popup.css">
<link rel="stylesheet" href="/assets/css/slick.css">
<!-- style CSS -->
<link rel="stylesheet" href="/assets/css/style.css">
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	 <!-- breadcrumb part start-->
    <section class="breadcrumb_part">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb_iner">
                        <h2>${title}</h2>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- breadcrumb part end-->
    
    <!-- product list part start-->
    <section class="product_list section_padding">
        <div class="container">
            <div class="row">
                <div class="col-md-4">
                    <div class="product_sidebar">
                        <div class="single_sedebar">
                            <form action="/product/search" method="post">
                                <input type="text" name="keyword" placeholder="Search keyword">
                                <i class="ti-search"></i>
                            </form>
                        </div>
                        <div class="single_sedebar">
                            <div class="select_option">
                                <div class="select_option_list">Category <i class="right fas fa-caret-down"></i> </div>
                                <div class="select_option_dropdown">
                                	<c:forEach var="category" items="${categories}">
                                		<p><a href="/product/category?categoryId=${category.id }">${category.name }</a></p>
                                	</c:forEach>
                                </div>
                            </div>
                        </div>
                        <div class="single_sedebar">
                            <div class="select_option">
                                <div class="select_option_list">Brand <i class="right fas fa-caret-down"></i> </div>
                                <div class="select_option_dropdown">
                                	<c:forEach var="brand" items="${brands}">
                                		<p><a href="/product/brand?brandId=${brand.id }">${brand.name}</a></p>
                                	</c:forEach>
                                </div>
                            </div>
                        </div>
                        <div class="single_sedebar">
                            <div class="select_option">
                                <div class="select_option_list">Sort by: <i class="right fas fa-caret-down"></i> </div>
                                <div class="select_option_dropdown">
                                	<p><a href="/product/sort?by=price">Price</a></p>
                                	<p><a href="/product/sort?by=name">Name</a></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-8">
                    <div class="product_list">
                        <div class="row">
	                        <c:forEach var="product" items="${page.content}">
	                        	<div class="col-lg-6 col-sm-6">
                                	<div class="single_product_item">
	                                    <img src="/assets/img/product/${product.image}" alt="#" class="img-fluid">
	                                    <h3> <a href="/product/details?productId=${product.id }">${product.name }</a> </h3>
	                                    <p>$${product.price}</p>
	                                </div>
	                            </div>
	                        </c:forEach>
                        </div>
                        <div class="load_more_btn text-center">
                            <a href="/product/page?p=${page.number+1}" class="btn_3">${btnLoad}</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- product list part end-->
	<jsp:include page="subscribe.jsp"></jsp:include>
	<jsp:include page="footer.jsp"></jsp:include>
</body>
<script src="/config/js/jquery-1.12.1.min.js"></script>
<script src="/config/js/popper.min.js"></script>
<script src="/config/js/bootstrap.min.js"></script>
<script src="/config/js/jquery.magnific-popup.js"></script>
<script src="/config/js/owl.carousel.min.js"></script>
<script src="/config/js/jquery.nice-select.min.js"></script>
<script src="/config/js/slick.min.js"></script>
<script src="/config/js/jquery.counterup.min.js"></script>
<script src="/config/js/waypoints.min.js"></script>
<script src="/config/js/contact.js"></script>
<script src="/config/js/jquery.ajaxchimp.min.js"></script>
<script src="/config/js/jquery.form.js"></script>
<script src="/config/js/jquery.validate.min.js"></script>
<script src="/config/js/mail-script.js"></script>
<script src="/config/js/custom.js"></script>
</html>