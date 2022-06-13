<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin | Wine-market</title>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta content="" name="keywords">
<meta content="" name="description">

<!-- Favicon -->
<link rel="icon" href="/assets/img/favicon.png">

<!-- Google Web Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap"
	rel="stylesheet">

<!-- Icon Font Stylesheet -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
	rel="stylesheet">

<!-- Libraries Stylesheet -->
<link href="/adminassets/lib/owlcarousel/assets/owl.carousel.min.css"
	rel="stylesheet">
<link
	href="/adminassets/lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css"
	rel="stylesheet" />

<!-- Customized Bootstrap Stylesheet -->
<link href="/adminassets/css/bootstrap.min.css" rel="stylesheet">

<!-- Template Stylesheet -->
<link href="/adminassets/css/style.css" rel="stylesheet">
<body>
	<div class="container-fluid position-relative bg-white d-flex p-0">
		<!-- Spinner Start -->
		<div id="spinner"
			class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
			<div class="spinner-border text-primary"
				style="width: 3rem; height: 3rem;" role="status">
				<span class="sr-only">Loading...</span>
			</div>
		</div>

		<jsp:include page="sidebar.jsp"></jsp:include>

		<div class="content">
			<jsp:include page="navbar.jsp"></jsp:include>
			<div class="container-fluid pt-4 px-4">
				<div class="row g-4">
					<div class="col-sm-6 col-xl-4">
						<div class="bg-light rounded h-100 p-4">
							<form action="/admin/updateProduct" method="post"
								enctype="multipart/form-data">
								<div class="mb-3">
									<label for="exampleInputEmail1" class="form-label">Order
										ID</label> <input type="text" name="Name" class="form-control"
										value="${item.getId() }" readonly>
								</div>
								<div class="mb-3">
									<label for="exampleInputEmail1" class="form-label">User</label>
									<input type="text" name="Name" class="form-control"
										value="${item.getUser().getUsername() }" readonly>
								</div>
								<div class="mb-3">
									<label for="exampleInputEmail1" class="form-label">Total</label>
									<input type="text" name="Name" class="form-control"
										value="${item.getTotal() }" readonly>
								</div>
								<div class="mb-3">
									<label for="exampleInputEmail1" class="form-label">Date</label>
									<input type="text" name="Name" class="form-control"
										value="${item.getDateOrder() }" readonly>
								</div>
								<div class="mb-3">
									<label for="exampleInputEmail1" class="form-label">Status</label>
									<input type="text" name="Name" class="form-control"
										value="${item.getStatus() }" readonly>
								</div>
								<a href="/admin/orderUpdate?id=${item.getId() }&action=pending"
									class="btn btn-primary"><i class="fas fa-box"></i></a> <a
									href="/admin/orderUpdate?id=${item.getId() }&action=delivering"
									class="btn btn-primary"><i class="fas fa-truck"></i></a> <a
									href="/admin/orderUpdate?id=${item.getId() }&action=done"
									class="btn btn-primary"><i class="fas fa-check"></i></a> <a
									href="/admin/orderUpdate?id=${item.getId() }&action=remove"
									class="btn btn-primary"><i class="fas fa-times"></i></a>
							</form>
						</div>
					</div>
					<div class="col-sm-6 col-xl-8">
						<div class="bg-light rounded h-100 p-4">
							<div class="table-wrapper-scroll-y my-custom-scrollbar">
								<table id="tableData" class="table table-hover">
									<thead>
										<tr class="text-dark">
											<th scope="col">Product ID</th>
											<th scope="col">Product Name</th>
											<th scope="col">Quantity</th>
											<th scope="col">Price</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="cart" items="${carts}">
											<tr>
												<td>${cart.getProduct().getId() }</td>
												<td>${cart.getProduct().getName() }</td>
												<td>${cart.getQuantity() }</td>
												<td>${cart.getProduct().getPrice() }</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="container-fluid pt-4 px-4">
				<div class="row g-4">
					<div class="col-sm-12 col-xl-12">
						<div class="bg-light rounded h-100 p-4">
							<div class="row">
								<div class="col-6">
									<div class="d-none d-md-flex float-start">
										<a href="/admin/orderSort?by=DESC" class="btn btn-primary ms-3"><i class="fas fa-angle-down"></i></a>
										<a href="/admin/orderSort?by=ASC" class="btn btn-primary ms-3"><i class="fas fa-angle-up"></i></a>
									</div>
								</div>
								<div class="col-6">
									<form class="d-none d-md-flex float-end"
										action="/admin/orderSearch" method="post">
										<select name="Status" class="form-select ms-3"
											aria-label="Default select example">
											<option value="0"></option>
											<c:forEach var="status" items="${statusList}">
												<option value="${status}">${status}</option>
											</c:forEach>
										</select>
										<button type="submit" class="btn btn-primary ms-3">
											<i class="fas fa-filter"></i>
										</button>
									</form>
								</div>
							</div>
							<div class="table-wrapper-scroll-y my-custom-scrollbar">
								<table id="tableData" class="table table-hover">
									<thead>
										<tr class="text-dark">
											<th scope="col">Date</th>
											<th scope="col">Order Id</th>
											<th scope="col">Customer</th>
											<th scope="col">Amount</th>
											<th scope="col">Status</th>
											<th scope="col">Action</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="order" items="${orders}">
											<tr>
												<td>${order.getDateOrder() }</td>
												<td>${order.getId() }</td>
												<td>${order.getUser().getUsername() }</td>
												<td>$${order.getTotal() }</td>
												<td>${order.getStatus() }</td>
												<td><a
													href="/admin/orderUpdate?id=${order.getId() }&action=pending"
													class="btn btn-primary"><i class="fas fa-box"></i></a> <a
													href="/admin/orderUpdate?id=${order.getId() }&action=delivering"
													class="btn btn-primary"><i class="fas fa-truck"></i></a> <a
													href="/admin/orderUpdate?id=${order.getId() }&action=done"
													class="btn btn-primary"><i class="fas fa-check"></i></a> <a
													href="/admin/orderUpdate?id=${order.getId() }&action=view"
													class="btn btn-primary"><i class="fas fa-edit"></i></a> <a
													href="/admin/orderUpdate?id=${order.getId() }&action=remove"
													class="btn btn-primary"><i class="fas fa-times"></i></a></td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>

			<jsp:include page="footer.jsp"></jsp:include>
		</div>
		<a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i
			class="bi bi-arrow-up"></i></a>
	</div>


</body>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="/adminassets/lib/chart/chart.min.js"></script>
<script src="/adminassets/lib/easing/easing.min.js"></script>
<script src="/adminassets/lib/waypoints/waypoints.min.js"></script>
<script src="/adminassets/lib/owlcarousel/owl.carousel.min.js"></script>
<script src="/adminassets/lib/tempusdominus/js/moment.min.js"></script>
<script src="/adminassets/lib/tempusdominus/js/moment-timezone.min.js"></script>
<script
	src="/adminassets/lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>

<!-- Template Javascript -->
<script src="/adminassets/js/main.js"></script>
</html>