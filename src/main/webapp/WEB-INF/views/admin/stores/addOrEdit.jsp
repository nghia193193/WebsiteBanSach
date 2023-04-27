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
			<form action="<c:url value="/admin/stores/saveOrUpdate" />" method="post" enctype="multipart/form-data">
				<div class="card">
					<div class="card-header">
						<h2>${store.isEdit ? "Edit Store" : "Add new Store"}</h2>
					</div>
					<div class="card-body">
						<div class="row">
							<div class="col-7">
								<c:if test="${store.isEdit }">
									<div class="mb-3">
										<label for="storeId" class="form-label">Store ID</label>
										<input type="hidden" value="${store.isEdit}" name="isEdit"> 
										
								
										<input
											type="text" readonly="readonly" class="form-control"
											value="${store.storeId}" aria-describedby="storeIdid"
											placeholder="store Id" id="storeId" name="storeId" path="storeId">
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
								
								<c:if test="${store.avatar != null }">
									<img alt="" src="${store.avatar }" width="70px" class="img-fluid rounded border" id="images">
								</c:if>
								<c:if test="${store.avatar == null }">
									<img alt="" src="/templates/images/noimage.jpg" width="70px" class="img-fluid rounded border" id="images">
								</c:if>
								<br/>
								<!-- Image & Upload -->
								
								
								<div class="mb-3">
									<label for="avatarFile" class="form-label">Avatar File</label> 
									<input type="file" class="form-control-file"
										value="${store.avatarFile}" name="avatarFile" id="avatarFile"
										aria-describedby="avatarFile" placeholder="store Avatar"
										onchange="chooseFile(this)" accept=".jpg, .png">
								</div>
								
								<div class="mb-3">
									<label for="storeName" class="form-label">Tên cửa hàng:</label>
									<input type="text" class="form-control"
										value="${store.storeName}" name="storeName" id="storeName" path="storeName"
										aria-describedby="storeName" placeholder="Store Name">
								</div>
								
								<div class="mb-3">
									<label for="description" class="form-label">Mô tả:</label>
									<input type="text" class="form-control"
										value="${store.description}" name="description" id="description" path="description"
										aria-describedby="description" placeholder="Mô tả cửa hàng">
								</div>
								
								<div class="mb-3">
									<label for="active">Active</label>
									<select class="form-select" name="active" aria-label="active" id="active">		
										<option ${store.active == true ? 'selected' : '' } value="true" ">Hoạt động</option>
										<option ${store.active == false ? 'selected' : '' } value="false" ">Không hoạt động</option>
									</select>
								</div>
													
								<div class="mb-3">
									<label for="ownerId" class="form-label">Chủ cửa hàng:</label>
									<input type="text" class="form-control"
										value="${store.ownerId}" name="ownerId" id="ownerId" path="ownerId"
										aria-describedby="ownerId" placeholder="OwnerId">
								</div>
								
							</div>
						</div>	
					</div>
				</div>
				
				<div class="card-footer text-muted">
					<a href='<c:url value="/admin/stores/add"/>' class="btn btn-secondary"><i class="fa-solid fa-plus"></i> New</a>
					<a href='<c:url value="/admin/stores"/>' class="btn btn-success"><i class="fas fa-bars"></i> List stores</a>
					<button class="btn btn-primary" type="submit" ><i class="fas fa-save"></i>
						<c:if test="${store.isEdit }">
						<span>Update</span>
						</c:if>
						<c:if test="${!store.isEdit }">
						<span>Save</span>
						</c:if>	
					</button>
				</div>
			</form>
		</div>
	</section>
</body>
</html>