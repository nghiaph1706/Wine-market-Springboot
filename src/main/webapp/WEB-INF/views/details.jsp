<%@ page pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Details | Wine-market</title>
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
    <section class="breadcrumb_part single_product_breadcrumb">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb_iner">
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- breadcrumb part end-->

  <!--================Single Product Area =================-->
  <div class="product_image_area">
    <div class="container">
      <div class="row justify-content-center">
        <div class="col-lg-12">
          <div class="product_img_slide owl-carousel">
            <div class="single_product_img">
              <img src="/assets/img/product/${product.image}" alt="#" class="img-fluid">
            </div>
            <div class="single_product_img">
              <img src="/assets/img/product/${product.image}" alt="#" class="img-fluid">
            </div>
            <div class="single_product_img">
              <img src="/assets/img/product/${product.image}" alt="#" class="img-fluid">
            </div>
          </div>
        </div>
        <div class="col-lg-8">
          <div class="single_product_text text-center">
          <form action="/cart/add" method="post">
	           <h3>${product.name }</h3>
	            <p>Price: $${product.price }</p>
	            <div class="card_area">
	                <div class="product_count_area">
	                    <div class="product_count d-inline-block">
	                        <span class="product_count_item inumber-decrement"> <i class="ti-minus"></i></span>
	                        <input class="product_count_item input-number" type="text" name="Quantity" value="1" min="0" max="10">
	                        <span class="product_count_item number-increment"> <i class="ti-plus"></i></span>
	                    </div>
	                </div>
	                        <input type="hidden" name="ProductId" value="${product.id}" >
	              <div class="add_to_cart">
	                  <button type="submit" class="btn_3">add to cart</button>
	              </div>
	            </div>
          </form>
          </div>
        </div>
      </div>
    </div>
  </div>
  <!--================End Single Product Area =================-->
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