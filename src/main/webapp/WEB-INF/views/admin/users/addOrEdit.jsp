<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>

<!DOCTYPE html>
<html>

<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">

</head>

<body>

	<section class="row">
		<div class="col-6 offset-3 mt-4">
			<form action="<c:url value="/admin/users/saveOrUpdate" />" method="post" enctype="multipart/form-data">
				<div class="card">
					<div class="card-header">
						<h2>${user.isEdit ? "Edit User" : "Add new User"}</h2>
					</div>
					<div class="card-body">
						<div class="row">
							<div class="col-7">
								<c:if test="${user.isEdit }">
									<div class="mb-3">
										<label for="userId" class="form-label">User ID</label>
										<input type="hidden" value="${user.isEdit}" name="isEdit"> 
										
								
										<input
											type="text" readonly="readonly" class="form-control"
											value="${user.userId}" aria-describedby="userIdid"
											placeholder="User Id" id="userId" name="userId" path="userId">
									</div>
								</c:if>
								
								<!-- Image & Upload -->
								<script type="text/javascript">
									function chooseFile(fileInput) {
										if(fileInput.files && fileInput.files[0]) {
											var reader = new FileReader();
											reader.onload = function(e) {
												$('#images').attr('src', e.target.result);
											}
											reader.readAsDataURL(fileInput.files[0]);
										}
									}
								</script>
								
								<c:if test="${user.avatar != null }">
									<img alt="" src="${user.avatar }" width="70px" class="img-fluid rounded border" id="images">
								</c:if>
								<c:if test="${user.avatar == null }">
									<img alt="" src="/templates/images/noimage.jpg" width="70px" class="img-fluid rounded border" id="images">
								</c:if>
								<br/>
								<!-- Image & Upload -->
								
								
								<div class="mb-3">
									<label for="avatarFile" class="form-label">Avatar File</label> 
									<input type="file" class="form-control-file"
										value="${user.avatarFile}" name="avatarFile" id="avatarFile"
										aria-describedby="avatarFile" placeholder="User Avatar"
										onchange="chooseFile(this)" accept=".jpg, .png">
								</div>
								
								<div class="mb-3">
									<label for="firstName" class="form-label">Tên của bạn:</label>
									<input type="text" class="form-control"
										value="${user.firstName}" name="firstName" id="firstName" path="firstName"
										aria-describedby="firstName" placeholder="vd: Nghĩa">
								</div>
								
								<div class="mb-3">
									<label for="lastName" class="form-label">Họ và tên đệm:</label>
									<input type="text" class="form-control"
										value="${user.lastName}" name="lastName" id="lastName" path="lastName"
										aria-describedby="lastName" placeholder="vd: Nguyễn Khắc">
								</div>
								
								<div class="mb-3">
									<label for="phone" class="form-label">Phone:</label>
									<input type="text" class="form-control"
										value="${user.phone}" name="phone" id="phone" path="phone"
										aria-describedby="phone" placeholder="SĐT">
								</div>
								
								<div class="mb-3">
									<label for="address" class="form-label">Địa chỉ:</label>
									<input type="text" class="form-control"
										value="${user.address}" name="address" id="address" path="address"
										aria-describedby="address" placeholder="address">
								</div>
								
								<div class="mb-3">
									<label for="email" class="form-label">Email</label>
									<input type="text" class="form-control"
										value="${user.email}" name="email" id="email" path="email"
										aria-describedby="email" placeholder="email">
								</div>
								
								<div class="mb-3">
									<label for="username" class="form-label">User Name</label>
									<input type="text" class="form-control"
										value="${user.username}" name="username" id="username" path="username"
										aria-describedby="usernameid" placeholder="User Name">
								</div>
								
								<div class="mb-3">
									<label for="password" class="form-label">Password</label>
									<input type="text" class="form-control"
										value="${user.password}" name="password" id="password" path="password"
										aria-describedby="password" placeholder="Password">
								</div>
									
								
								<div class="mb-3">
									<label for="role" class="form-label">Role</label>
									<select class="form-select"
										name="role" aria-label="role" id="role">
										<option ${user.role == 'USER' ? 'selected' : '' }
											value="USER">USER</option>
										<option ${user.role == 'ADMIN' ? 'selected' : '' }
											value="ADMIN">ADMIN</option>
									</select>
								</div>

								<div class="mb-3">
									<label for="delete">Status</label> <select class="form-select"
										name="delete" aria-label="delete" id="delete">
										<option ${user.delete == false ? 'selected' : '' }
											value="false"">Hoạt động</option>
										<option ${user.delete == true ? 'selected' : '' }
											value="true"">Không hoạt động</option>
									</select>
								</div>

							</div>
						</div>	
					</div>
				</div>
				
				<div class="card-footer text-muted">
					<a href='<c:url value="/admin/users/add"/>' class="btn btn-secondary"><i class="fa-solid fa-plus"></i> New</a>
					<a href='<c:url value="/admin/users"/>' class="btn btn-success"><i class="fas fa-bars"></i> List Users</a>
					<button class="btn btn-primary" type="submit" ><i class="fas fa-save"></i>
						<c:if test="${user.isEdit }">
						<span>Update</span>
						</c:if>
						<c:if test="${!user.isEdit }">
						<span>Save</span>
						</c:if>	
					</button>
				</div>
			</form>
		</div>
	</section>
</body>
</html>