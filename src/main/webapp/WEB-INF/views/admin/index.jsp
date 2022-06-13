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
			<!-- Sale & Revenue Start -->
			<div class="container-fluid pt-4 px-4">
				<div class="row g-4">
					<div class="col-sm-6 col-xl-3">
						<div
							class="bg-light rounded d-flex align-items-center justify-content-between p-4">
							<i class="fa fa-chart-line fa-3x text-primary"></i>
							<div class="ms-3">
								<p class="mb-2">Today Sale</p>
								<h6 class="mb-0">${todaySale }</h6>
							</div>
						</div>
					</div>
					<div class="col-sm-6 col-xl-3">
						<div
							class="bg-light rounded d-flex align-items-center justify-content-between p-4">
							<i class="fa fa-chart-bar fa-3x text-primary"></i>
							<div class="ms-3">
								<p class="mb-2">Today Revenue</p>
								<h6 class="mb-0">${todaySale*0.2 }</h6>
							</div>
						</div>
					</div>
					<div class="col-sm-6 col-xl-3">
						<div
							class="bg-light rounded d-flex align-items-center justify-content-between p-4">
							<i class="fa fa-chart-area fa-3x text-primary"></i>
							<div class="ms-3">
								<p class="mb-2">Month Sale</p>
								<h6 class="mb-0">${monthSale }</h6>
							</div>
						</div>
					</div>
					<div class="col-sm-6 col-xl-3">
						<div
							class="bg-light rounded d-flex align-items-center justify-content-between p-4">
							<i class="fa fa-chart-pie fa-3x text-primary"></i>
							<div class="ms-3">
								<p class="mb-2">Month Revenue</p>
								<h6 class="mb-0">${monthSale*0.2 }</h6>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- Sale & Revenue End -->


			<!-- Recent Sales Start
			<div class="container-fluid pt-4 px-4">
				<div class="bg-light rounded h-100 p-4">
					<h6 class="mb-4">Testimonial</h6>
					<div class="owl-carousel testimonial-carousel">
						<div class="testimonial-item text-center">
							<img class="img-fluid rounded-circle mx-auto mb-4"
								src="/assets/img/about_us_video.png"
								style="width: 100px; height: 100px;">
							<h5 class="mb-1">Someone</h5>
							<p>Profession</p>
							<p class="mb-0">It is better to write for yourself than to
								work for money.</p>
						</div>
						<div class="testimonial-item text-center">
							<img class="img-fluid rounded-circle mx-auto mb-4"
								src="/assets/img/banner.png"
								style="width: 100px; height: 100px;">
							<h5 class="mb-1">Someone</h5>
							<p>Profession</p>
							<p class="mb-0">Good code is its own best documentation.</p>
						</div>
					</div>
				</div>
			</div>
			Recent Sales End -->
			
			 <!-- Recent Sales Start -->
            <div class="container-fluid pt-4 px-4">
                <div class="bg-light text-center rounded p-4">
                    <div class="d-flex align-items-center justify-content-between mb-4">
                        <h6 class="mb-0">Recent Salse</h6>
                        <a href="">Show All</a>
                    </div>
                    <div class="table-responsive">
                        <table class="table text-start align-middle table-bordered table-hover mb-0">
                            <thead>
                                <tr class="text-dark">
                                    <th scope="col">Date</th>
                                    <th scope="col">Order Id</th>
                                    <th scope="col">Customer</th>
                                    <th scope="col">Amount</th>
                                    <th scope="col">Status</th>
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
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <!-- Recent Sales End -->

			<!-- Widgets Start -->
			<div class="container-fluid pt-4 px-4">
				<div class="row g-4">
					<div class="col-sm-12 col-md-6 col-xl-4">
						<div class="h-100 bg-light rounded p-4">
							<div
								class="d-flex align-items-center justify-content-between mb-2">
								<h6 class="mb-0">Messages</h6>
								<a href="/admin/message">Show All</a>
							</div>
							<c:forEach var="mess" items="${messageSPs}">
								<div class="d-flex align-items-center border-bottom py-3">
									<div class="w-100 ms-3">
										<div class="d-flex w-100 justify-content-between">
											<h6 class="mb-0">${mess.getName()}</h6>
										</div>
										<span>${mess.getMessage()}</span>
									</div>
								</div>
							</c:forEach>
						</div>
					</div>
					<div class="col-sm-12 col-md-6 col-xl-4">
						<div class="h-100 bg-light rounded p-4">
							<div
								class="d-flex align-items-center justify-content-between mb-4">
								<h6 class="mb-0">Calender</h6>
							</div>
							<div id="calender"></div>
						</div>
					</div>
					<div class="col-sm-12 col-md-6 col-xl-4">
						<div class="h-100 bg-light rounded p-4">

							<form action="/admin/addTodo" method="post">
								<div
									class="d-flex align-items-center justify-content-between mb-4">
									<h6 class="mb-0">To Do List</h6>

								</div>
								<div class="d-flex mb-2">
									<input class="form-control bg-transparent" type="text"
										name="Task" placeholder="Enter task">
									<button type="submit" class="btn btn-primary ms-2">Add</button>
								</div>

							</form>
							<c:forEach var="todo" items="${todos}">
								<div class="d-flex align-items-center border-bottom py-2">
									<div class="w-100 ms-3">
										<div
											class="d-flex w-100 align-items-center justify-content-between">
											<span>${todo.getContent() }</span>
											<a href="/admin/removeTodo?id=${todo.getId() }" class="btn btn-sm">
												<i class="fa fa-times"></i>
											</a>
										</div>
									</div>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
			</div>
			<!-- Widgets End -->
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