<%@ page pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login | Wine-market</title>
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
                        <h2>login</h2>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- breadcrumb part end-->

    <!--================login_part Area =================-->
    <section class="login_part section_padding ">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6 col-md-6">
                    <div class="login_part_text text-center">
                        <div class="login_part_text_iner">
                            <h2>New to our Shop?</h2>
                            <p>There are advances being made in science and technology
                                everyday, and a good example of this is the</p>
                            <a href="/account/signup" class="btn_3">Create an Account</a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6 col-md-6">
                    <div class="login_part_form">
                        <div class="login_part_form_iner">
                            <h3>Welcome Back ! <br>
                                Please Sign in now</h3>
                            <form class="row contact_form" action="/account/login" method="post" novalidate="novalidate">
                            	<div class="col-md-12 form-group p_star">
                            		<span style="color: #b00c45 ">${message }</span>
                            	</div>
                                <div class="col-md-12 form-group p_star">
                                    <input type="text" class="form-control" id="name" name="Username" value=""
                                        placeholder="Username">
                                </div>
                                <div class="col-md-12 form-group p_star">
                                    <input type="password" class="form-control" id="password" name="Password" value=""
                                        placeholder="Password">
                                </div>
                                <div class="col-md-12 form-group">
                                    <div class="creat_account d-flex align-items-center">
                                        <input type="checkbox" id="f-option" name="remember">
                                        <label for="f-option">Remember me</label>
                                    </div>
                                    <button type="submit" value="submit" class="btn_3">
                                        log in
                                    </button>
                                    <a class="lost_pass" href="/account/sendcode">forget password?</a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!--================login_part end =================-->
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