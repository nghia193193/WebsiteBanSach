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

	<section>
		<div class="col-6 offset-3 mt-4">
			
				<div class="card">
					<div class="card-header">
						<h2>${user.username}</h2>
					</div>
					<div class="card-body">

					<div class="mb-3">
						<label for="userId" class="form-label">User ID</label> <input
							type="text" readonly="readonly" class="form-control"
							value="${user.userId}" aria-describedby="userIdid"
							placeholder="User Id" id="userId" name="userId" path="userId">
					</div>

					<c:if test="${user.avatar != null }">
						<img alt="" src="${user.avatar }" width="70px"
							class="img-fluid rounded border" id="images">
					</c:if>
					<c:if test="${user.avatar == null }">
						<img alt="" src="/templates/images/noimage.jpg" width="70px"
							class="img-fluid rounded border" id="images">
					</c:if>
					<br/>
					<br/>
					
					<div class="mb-3">
									<label for="firstName" class="form-label">Tên:</label>
									<input type="text" readonly="readonly" class="form-control"
										value="${user.firstName}" name="firstName" id="firstName" path="firstName"
										aria-describedby="firstName" placeholder="vd: Nghĩa">
								</div>
								
					<div class="mb-3">
									<label for="lastName" class="form-label">Họ và tên đệm:</label>
									<input type="text" readonly="readonly" class="form-control"
										value="${user.lastName}" name="lastName" id="lastName" path="lastName"
										aria-describedby="lastName" placeholder="vd: Nguyễn Khắc">
								</div>
								
					<div class="mb-3">
									<label for="phone" class="form-label">Phone:</label>
									<input type="text" readonly="readonly" class="form-control"
										value="${user.phone}" name="phone" id="phone" path="phone"
										aria-describedby="phone" placeholder="SĐT">
								</div>
								
					<div class="mb-3">
									<label for="address" class="form-label">Địa chỉ:</label>
									<input type="text" readonly="readonly" class="form-control"
										value="${user.address}" name="address" id="address" path="address"
										aria-describedby="address" placeholder="address">
								</div>
					
					<div class="mb-3">
									<label for="email" class="form-label">Email</label>
									<input type="text" readonly="readonly" class="form-control"
										value="${user.email}" name="email" id="email" path="email"
										aria-describedby="email" placeholder="email">
								</div>

					<div class="mb-3">
							<label for="delete">Status</label> 
							<input
							type="text" readonly="readonly" class="form-control"
							value="${user.delete ? 'Không hoạt động' : 'Hoạt động'}" aria-describedby="delete"
							placeholder="delete" id="delete" name="delete" path="delete">
						</div>
						
						<div class="mb-3">
							<label for="createAt">Create at</label> 
							<input
							type="text" readonly="readonly" class="form-control"
							value="${user.createAt}" aria-describedby="createAt"
							placeholder="createAt" id="createAt" name="createAt" path="createAt">
						</div>
						
						<c:if test="${user.updateAt != null }">
							<div class="mb-3">
							<label for="updateAt">Update at</label> 
							<input
							type="text" readonly="readonly" class="form-control"
							value="${user.updateAt}" aria-describedby="updateAt"
							placeholder="updateAt" id="updateAt" name="updateAt" path="updateAt">
						</div>
						</c:if>
						
						<div class="col-md-6">
						<div class="float-right">
							<a class="btn btn-outline-success" href="/admin/users">Back</a>
						</div>
					</div>

					</div>
				</div>
				
				
			
		</div>
	</section>
</body>
</html>