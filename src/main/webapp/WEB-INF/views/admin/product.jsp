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
					<div class="col-sm-12 col-xl-6">
						<div class="bg-light rounded h-100 p-4">
							<h6 class="mb-4">Product</h6>
							<form action="/admin/updateProduct" method="post"
								enctype="multipart/form-data">
								<div class="mb-3">
									<label for="exampleInputEmail1" class="form-label">Product</label>
									<input type="text" name="Name" class="form-control"
										value="${product.getName() }"> <input type="hidden"
										name="Id" class="form-control" value="${product.getId() }">
								</div>
								<div class="mb-3">
									<label for="formFile" class="form-label">Image</label> <input
										name="attach" class="form-control" type="file" id="formFile">
								</div>
								<label for="exampleInputEmail1" class="form-label">Brand</label>
								<select name="Brand" class="form-select mb-3"
									aria-label="Default select example">
									<c:forEach var="brand" items="${brands}">
										<option value="${brand.getId() }"
											${seBrand == brand.getId() ? 'selected' : '' }>${brand.getName()}</option>
									</c:forEach>
								</select> <label for="exampleInputEmail1" class="form-label">Category</label>
								<select name="Category" class="form-select mb-3"
									aria-label="Default select example">
									<c:forEach var="category" items="${categories}">
										<option value="${category.getId() }"
											${seCate == category.getId() ? 'selected' : '' }>${category.getName()}</option>
									</c:forEach>
								</select>
								<div class="mb-3">
									<label for="exampleInputEmail1" class="form-label">Price</label>
									<input type="text" name="Price" class="form-control"
										value="${product.getPrice() }">
								</div>
								<button type="submit" class="btn btn-primary">Update</button>
								<button formaction="/admin/addProduct" class="btn btn-primary">Add</button>
								<a href="/admin/product" class="btn btn-primary">Cancel</a>
							</form>
						</div>
					</div>
					<div class="col-sm-12 col-xl-6">
						<div
							class="bg-light rounded h-100 p-4 align-items-center justify-content-center mx-0">
							<img class="rounded mx-auto d-block" alt="none"
								style="width: 70%;"
								src="/assets/img/product/${product.getImage() }">
						</div>
					</div>
				</div>
			</div>

			<div class="container-fluid pt-4 px-4">
				<div class="row g-4">
					<div class="col-sm-12 col-xl-12">
						<div class="bg-light rounded h-100 p-4">
							<div class="row">
								<div class="col-4">
							<form class="d-none d-md-flex " action="/admin/productSearch">
								<input class="form-control border-0" type="search" name="keyword"
									placeholder="Search Product">
							</form>
								</div>
								<div class="col-8">
							<form class="d-none d-md-flex float-end" action="/admin/productSearch" method="post">
								<select name="Category" class="form-select ms-3"
									aria-label="Default select example">
										<option value="0"></option>
									<c:forEach var="category" items="${categories}">
										<option value="${category.getId() }">${category.getName()}</option>
									</c:forEach>
								</select>
								<select name="Brand" class="form-select ms-3"
									aria-label="Default select example">
										<option value="0"></option>
									<c:forEach var="brand" items="${brands}">
										<option value="${brand.getId() }">${brand.getName()}</option>
									</c:forEach>
								</select>
								<button type="submit" class="btn btn-primary ms-3"><i class="fas fa-filter"></i></button>
							</form>
								</div>
							</div>
							<div class="table-wrapper-scroll-y my-custom-scrollbar">
								<table id="tableData" class="table table-hover">
									<thead>
										<tr>
											<th scope="col" >#</th>
											<th scope="col">Product</th>
											<th scope="col">Brand</th>
											<th scope="col">Category</th>
											<th scope="col">Price</th>
											<th scope="col">Action</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="product" items="${products}">
											<tr>
												<td>${product.getId() }</td>
												<td>${product.getName() }</td>
												<td>${product.getBrand().getName() }</td>
												<td>${product.getCategory().getName() }</td>
												<td>${product.getPrice() }</td>
												<td><a href="/admin/editProduct?id=${product.getId() }"
													class="btn btn-primary"><i class="fas fa-edit"></i></a> <a
													href="/admin/removeProduct?id=${product.getId() }"
													class="btn btn-primary"><i class="fas fa-trash"></i></a></td>
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