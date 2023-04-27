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
<%-- <body>

	<form:form action="register" method="post" modelAttribute="userModel">
		<div class="form-group">
			<c:if test="${usernameExists}">
				<span style="color: red;">Username already exists. Choose a
					different one.</span>
			</c:if>
			<label for="newUsername">Username: </label>&nbsp; <input
				required="required" type="text" class="form-control"
				id="newUsername" name="username" />
			<form:errors path="username" />
			<p style="color: #828282">Enter your username here.</p>
		</div>

		<div class="form-group">
			<c:if test="${emailExists}">
				<span style="color: red;">Email already exists. Choose a
					different one.</span>
			</c:if>
			<label for="email">Email Address: </label> <input required="required"
				type="text" class="form-control" id="email" name="email" />
			<form:errors path="email"></form:errors>
			<p style="color: #828282">A valid email address. All emails from
				the system will be sent to this address. The email address is not
				made public and will only be used if you wish to receive a new
				password or wish to receive certain notification.</p>
		</div>

		<button type="submit" class="btn btn-primary">Create new
			account</button>
	</form:form>
</body>

 --%>
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
					<i class="login__icon fas fa-user"></i><input required="required" type="text" class="form-control"
						id="newUsername" name="username" placeholder="Username"/>
					<form:errors path="username" />
				</div>




				<c:if test="${emailExists}">
					<span style="color: red;">Email already exists. Choose a
						different one.</span>
				</c:if>
				<div class="login__field">
					<i class="login__icon fas fa-lock"></i><input required="required" type="text"
						class="form-control" id="email" name="email" placeholder="Email"/>
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
</html>