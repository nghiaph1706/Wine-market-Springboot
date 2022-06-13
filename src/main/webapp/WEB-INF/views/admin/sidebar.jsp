<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	 <!-- Sidebar Start -->
        <div class="sidebar pe-4 pb-3">
            <nav class="navbar bg-light navbar-light">
                <a href="/admin/index" class="navbar-brand mx-4 mb-3">
                    <h3 class="text-primary"><i class="fas fa-wine-glass-alt"></i>  WINE-DASHMIN</h3>
                </a>
                <div class="d-flex align-items-center ms-4 mb-4">
                    <div class="position-relative">
                        <img class="rounded-circle" src="/assets/img/user/${admin.getImage() }" alt="" style="width: 40px; height: 40px;">
                        <div class="bg-success rounded-circle border border-2 border-white position-absolute end-0 bottom-0 p-1"></div>
                    </div>
                    <div class="ms-3">
                        <h6 class="mb-0">${admin.getUsername() }</h6>
                        <span>Admin</span>
                    </div>
                </div>
                <div class="navbar-nav w-100">
                    <a href="/admin/index" class="nav-item nav-link"><i class="fa fa-tachometer-alt me-2"></i>Dashboard</a>
                    <a href="/admin/product" class="nav-item nav-link"><i class="fa fa-th me-2"></i>Product</a>
                    <a href="/admin/user" class="nav-item nav-link"><i class="fas fa-user-circle me-2"></i>User</a>
                    <a href="/admin/message" class="nav-item nav-link"><i class="fa fa-envelope me-2"></i>Message<span class="btn btn-square btn-danger m-1 float-end">${messageCount }</span></a>
                    <a href="/admin/order" class="nav-item nav-link"><i class="fas fa-shopping-cart"></i> Order<span class="btn btn-square btn-danger m-1 float-end">${orderCount }</span></a>
                    <a href="/admin/voucher" class="nav-item nav-link"><i class="fas fa-tags"></i> Voucher</a>
                </div>
            </nav>
        </div>
        <!-- Sidebar End -->
</body>
</html>