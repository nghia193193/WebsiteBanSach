<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="/templates/css/bootstrap.min.css" rel="stylesheet">
<link href="/templates/css/custom.css" rel="stylesheet">
<link href="/templates/css/inputRe.css" rel="stylesheet">
<title>User Information</title>
</head>

<body>
	<section class="vh-100 gradient-custom">
		<div class="container py-5 h-100">
			<div class="row justify-content-center align-items-center h-100">
				<div class="col-12 col-lg-9 col-xl-7">
					<div class="card shadow-2-strong card-registration"
						style="border-radius: 15px;">
						<div class="card-body p-4 p-md-5">
							<h3 class="mb-4 pb-2 pb-md-0 mb-md-5">Điền Thông Tin Người
								Dùng</h3>
							<form action="newuserinfo" method="post"
								enctype="multipart/form-data">
								<input type="hidden" name="userId" value="${user.userId}" />

								<div class="form-group">
									<div class="row">
										<div class="col-xs-6">
											<label for="firstName">First Name</label> <input type="text"
												class="form-control" id="firstName" name="firstName"
												value="${user.firstName}" />
										</div>
										<div class="col-xs-6">
											<label for="lastName">Last Name</label> <input type="text"
												class="form-control" id="lastName" name="lastName"
												value="${user.lastName}" />
										</div>
									</div>
								</div>
								<c:if test="${user.avatar != null}">
									<img id="image" alt="" src="${user.avatar}" style="width: 60%;class="col-xs-6" >
								</c:if>
								<c:if test="${user.avatar == null}">
									<img id="image" alt="" src="/templates/images/noavatar.png"
										style="width: 60px;"class="col-xs-6">
								</c:if>
								<h4>
									Choose image: <input type="file" onchange="chooseFile(this)"
										id="avatarFile" name="avatarFile" placeholder="User avatar"
										accept=".jpg, .png" class="col-xs-6">
								</h4>
								<div class="col-xs-6">
									<label for="address">Address: </label> <input type="text"
										class="form-control" id="address" name="address"
										value="${user.address}" />
								</div>


								<div class="col-xs-6">
									<label for="userName">UserName</label> <input type="text"
										class="form-control" id="userName" name="username"
										value="${user.username}" readonly="readonly" class="col-xs-6"/>
								</div>

								<div class="form-group">
									<label for="email">Email: </label> <input type="text"
										class="form-control" id="email" name="email"
										value="${user.email}" readonly="readonly" />
								</div>
								<div class="form-group">
									<label for="phone">Phone: </label> <input type="text"
										class="form-control" id="phone" name="phone"
										value="${user.phone}" />
								</div>

								<div class="form-group">
									<label for="txtNewPassword">Password</label>&nbsp;<span
										id="checkPasswordMatch" style="color: red;"></span> <input
										type="password" class="form-control" id="txtNewPassword"
										name="password" />
								</div>
								<p style="color: #828282">Nhập mật khẩu cho user</p>
								<div class="form-group">
									<label for="txtConfirmPassword">Confirm Password</label> <input
										type="password" class="form-control" id="txtConfirmPassword"
										name="confirmPassword" />
								</div>


								<button id="updateUserInfoButton" type="submit"
									class="btn btn-primary">Hoàn tất đăng ký</button>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
	<script type="text/javascript">
		function chooseFile(fileInput) {
			if (fileInput.files && fileInput.files[0]) {
				var reader = new FileReader();
				reader.onload = function(e) {
					$('#image').attr('src', e.target.result);
				}
				reader.readAsDataURL(fileInput.files[0]);
			}
		}
	</script>
</body>
</html>