<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cart | Wine-market</title>
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
						<h2>Cart</h2>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- breadcrumb part end-->

	<!--================Checkout Area =================-->
	<section class="checkout_area section_padding">
		<div class="container">
			<div class="billing_details">
				<div class="row">
					<div class="col-lg-12">
						<div class="cart_inner">
							<div class="table-responsive">
								<table class="table">
									<thead>
										<tr>
											<th scope="col">Product</th>
											<th scope="col">Price</th>
											<th scope="col">Quantity</th>
											<th scope="col">Total</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="cart" items="${carts}">
											<tr>
												<td>
													<div class="media">
														<div class="d-flex">
															<img
																src="/assets/img/product/${cart.getProduct().getImage() }"
																alt="" />
														</div>
														<div class="media-body">
															<p>${cart.getProduct().getName() }</p>
														</div>
													</div>
												</td>
												<td>
													<h5>$${cart.getProduct().getPrice()}</h5>
												</td>
												<td>
													<div class="product_count">
														<a href="/cart/update/decrement?cartId=${cart.getId()}"><i
															class="ti-minus"></i></a> <input class="input-number"
															type="text" value="${cart.getQuantity()}" min="0"
															max="10" readonly> <a
															href="/cart/update/increment?cartId=${cart.getId()}">
															<i class="ti-plus"></i>
														</a>
													</div>
												</td>
												<td>
													<h5>$${cart.getQuantity() *
														cart.getProduct().getPrice()}</h5>
												</td>
											</tr>
										</c:forEach>
										<tr class="bottom_button">
											<td></td>
											<td></td>
											<td></td>
											<td>
												<div class="cupon_text float-right">
													<a class="btn_1" href="/product">continue Shopping</a>
												</div>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="product_list">
				<div class="row">
					<div class="product_sidebar">
						<span style="color: red">${message }</span>
						<div class="single_sedebar">
							<form action="/cart/voucher" method="post">
								<input type="text" name="discount" placeholder="Add Voucher">
								<i class="fa fa-credit-card" aria-hidden="true"></i>
							</form>
						</div>
					</div>
				</div>
			</div>
			<div class="col-lg-8">
				<div class="order_box">
					<h2>Your Order</h2>
					<ul class="list">
						<li><a href="#">Product <span>Total</span>
						</a></li>
						<c:forEach var="cart" items="${carts}">
							<li><a href="#">${cart.getProduct().getName() } <span
									class="middle">x ${cart.getQuantity()}</span> <span
									class="last">$${cart.getQuantity() *
										cart.getProduct().getPrice()}</span>
							</a></li>
						</c:forEach>
					</ul>
					<ul class="list list_2">
						<li><a href="#">Subtotal <span>$${subtotal }</span>
						</a></li>
						<li><a href="#">Discount <span>${discount }%</span>
						</a></li>
						<li><a href="#">Shipping <span>Flat rate: $10.0</span>
						</a></li>
						<li><a href="#">Total <span>$${total }</span>
						</a></li>
					</ul>
					<div class="payment_item">
						<div class="radion_btn">
							<input type="radio" id="f-option5" name="selector" /> <label
								for="f-option5">Cash</label>
							<div class="check"></div>
						</div>
					</div>
					<div class="payment_item active">
						<div class="radion_btn">
							<input type="radio" id="f-option6" name="selector" /> <label
								for="f-option6">Paypal </label> <img
								src="/assets/img/product/single-product/card.jpg" alt="" />
							<div class="check"></div>
						</div>
					</div>
					<a class="btn_3" href="/cart/checkout?total=${total }">Check
						out</a>
				</div>
			</div>
		</div>
		</div>
		</div>
	</section>
	<!--================End Checkout Area =================-->
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