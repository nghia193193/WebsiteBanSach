<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>
<%-- <!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
</head>
<body>
	<h1>Đăng Nhập</h1>
	<c:if test="${param.error != null}">
		<div style="color: red;">Incorrect username or password.</div>
	</c:if>

	<form action="" method="post">
		<div class="form-group">
			<label for="username">Username: </label> <input required="required"
				type="text" class="form-control" id="username" name="username" />
			<p style="color: #828282">Enter your username here.</p>
		</div>

		<div class="form-group">
			<label for="password">Password: </label> <input required="required"
				type="password" class="form-control" id="password" name="password" />
			<p style="color: #828282">Enter the password that accompanies
				your username</p>
		</div>

		<button type="submit" class="btn btn-primary">Đăng nhập</button>
		
	</form>
	<a th:href="/@{/forgot_password}">Forgot your password?</a>
</body>
</html> --%>
<link
	href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<script
	src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!------ Include the above in your HEAD tag ---------->

<!DOCTYPE html>
<html>
<head>
<title>Login Page</title>
<!--Made with love by Mutiullah Samim -->

<!--Bootsrap 4 CDN-->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"
	integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"
	crossorigin="anonymous">

<!--Fontawesome CDN-->
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.3.1/css/all.css"
	integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU"
	crossorigin="anonymous">

<!--Custom styles-->
<link rel="stylesheet" type="text/css" href="/templates/css/login.css">
</head>
<body>
	<div class="container">
		<div class="d-flex justify-content-center h-100">
			<div class="card">
				<div class="card-header">
					<h3>Đăng nhập</h3>
					<div class="d-flex justify-content-end social_icon">
						<c:if test="${param.error != null}">
							<div style="color: red;">Incorrect username or password.</div>
						</c:if>
					</div>
				</div>
				<div class="card-body">
					<form action="" method="post">
						<div class="input-group form-group">
							<div class="input-group-prepend">
								<span class="input-group-text"><i class="fas fa-user"></i></span>
							</div>
							<input
								required="required" type="text" class="form-control"
								id="username" name="username" />
						</div>
						<div class="input-group form-group">
							<div class="input-group-prepend">
								<span class="input-group-text"><i class="fas fa-key"></i></span>
							</div>
							<input
								required="required" type="password" class="form-control"
								id="password" name="password" />
						</div>
						<div class="form-group">
							<input type="submit" class="btn float-right login_btn">
						</div>
					</form>

				</div>
				<div class="card-footer">
					<div class="d-flex justify-content-center links">
						Don't have an account?<a href="/register">Đăng ký</a>
					</div>
					<div class="d-flex justify-content-center">
						<a href="/forgot_password">Quên mật khẩu ?</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
					<!-- <form action="" method="post">
						<div class="form-group">
							<label for="username">Username: </label> <input
								required="required" type="text" class="form-control"
								id="username" name="username" />
							<p style="color: #828282">Enter your username here.</p>
						</div>

						<div class="form-group">
							<label for="password">Password: </label> <input
								required="required" type="password" class="form-control"
								id="password" name="password" />
							<p style="color: #828282">Enter the password that accompanies
								your username</p>
						</div>

						<button type="submit" class="btn btn-primary">Đăng nhập</button>

					</form> -->