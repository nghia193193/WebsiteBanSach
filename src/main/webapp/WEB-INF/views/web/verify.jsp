<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css"
	href="/templates/css/register.css">
<meta charset="UTF-8">
<title>Register</title>
</head>
<%-- <c:if test="${emailSent}">
	<div class="alert alert-info">An email has been sent to the email
		address you just registered. Please validate your email address and
		update your password information.</div>
</c:if>
<form action="verifyRegister" role="form" method="post">

	<span class="input-group-addon"><i
		class="glyphicon glyphicon-envelope color-blue"></i></span> <input id="opt"
		name="otp" placeholder="Enter OTP" class="form-control" type="text"
		required="required">
	<c:if test="${not empty message}">
		<span>${message}</span>
	</c:if>

	<div>
		<input value="Submit" type="submit">
	</div>
</form> --%>



<body>
	<div class="container">
		<div class="screen">
			<div class="screen__content">
				<form action="verifyRegister" role="form" method="post" class="login">

					<c:if test="${emailSent}">
						<div class="alert alert-info">An email has been sent to the
							email address you just registered. Please validate your email
							address and update your password information.</div>
					</c:if>

					<div class="input-group form-group">
						<i class="login__icon fas fa-user"></i><input id="opt" name="otp" placeholder="Enter OTP"
							class="form-control" type="text" required="required">
					</div>

					<button class="button login__submit" type="submit">
						<span class="button__text">Submit</span> <i
							class="button__icon fas fa-chevron-right"></i>
					</button>

					<!-- <div class="form-group">
						<input value="Submit" type="submit"
							class="btn float-right login_btn">
					</div> -->
				</form>
				<div class="social-login">
					<h3>Đăng ký</h3>
					<div class="social-icons">
						<a href="#" class="social-login__icon fab fa-instagram"></a> <a
							href="#" class="social-login__icon fab fa-facebook"></a> <a
							href="#" class="social-login__icon fab fa-twitter"></a>
					</div>
				</div>
			</div>
			<div class="screen__background">
				<span class="screen__background__shape screen__background__shape4"></span>
				<span class="screen__background__shape screen__background__shape3"></span>
				<span class="screen__background__shape screen__background__shape2"></span>
				<span class="screen__background__shape screen__background__shape1"></span>
			</div>
		</div>
	</div>
</html>
<%-- <html>
<head>
<link rel="stylesheet" type="text/css"
	href="/templates/css/register.css">
<meta charset="UTF-8">
<title>Register</title>
</head>
<div class="container">
	<div class="screen">
		<div class="screen__content">
			<form action="register" method="post" modelAttribute="userModel"
				class="login">
				<c:if test="${usernameExists}">
					<span style="color: red;">Username already exists. Choose a
						different one.</span>
				</c:if>


				<div class="login__field">
					<i class="login__icon fas fa-user"></i><input required="required"
						type="text" class="form-control" id="newUsername" name="username"
						placeholder="Username" />
					<form:errors path="username" />
				</div>




				<c:if test="${emailExists}">
					<span style="color: red;">Email already exists. Choose a
						different one.</span>
				</c:if>
				<div class="login__field">
					<i class="login__icon fas fa-lock"></i><input required="required"
						type="text" class="form-control" id="email" name="email"
						placeholder="Email" />
					<form:errors path="email"></form:errors>
				</div>




				<button class="button login__submit" type="submit">
					<span class="button__text">Create new account</span> <i
						class="button__icon fas fa-chevron-right"></i>
				</button>



			</form>
			<div class="social-login">
				<h3>Đăng ký</h3>
				<div class="social-icons">
					<a href="#" class="social-login__icon fab fa-instagram"></a> <a
						href="#" class="social-login__icon fab fa-facebook"></a> <a
						href="#" class="social-login__icon fab fa-twitter"></a>
				</div>
			</div>
		</div>
		<div class="screen__background">
			<span class="screen__background__shape screen__background__shape4"></span>
			<span class="screen__background__shape screen__background__shape3"></span>
			<span class="screen__background__shape screen__background__shape2"></span>
			<span class="screen__background__shape screen__background__shape1"></span>
		</div>
	</div>
</div>
</html> --%>