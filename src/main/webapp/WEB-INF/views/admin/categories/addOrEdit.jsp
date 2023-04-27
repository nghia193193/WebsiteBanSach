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
			<form action="<c:url value="/admin/categories/saveOrUpdate" />" method="post" enctype="multipart/form-data">
				<div class="card">
					<div class="card-header">
						<h2>${category.isEdit ? "EditCategory" : "Add new category"}</h2>
					</div>
					<div class="card-body">
						<c:if test="${category.isEdit }">
							<div class="mb-3">
								<label for="categoryId" class="form-label">Category ID</label>
								<input type="hidden" value="${category.isEdit}" name="isEdit"> 
								
									<input
									type="text" readonly="readonly" class="form-control"
									value="${category.categoryId}" aria-describedby="categoryIdid"
									placeholder="Category Id" id="categoryId" name="categoryId" path="categoryId">
							</div>
						</c:if>

						<!-- Image & Upload -->
						<script type="text/javascript">
							function chooseFile(fileInput) {
								if (fileInput.files && fileInput.files[0]) {
									var reader = new FileReader();
									reader.onload = function(e) {
										$('#images').attr('src',
												e.target.result);
									}
									reader.readAsDataURL(fileInput.files[0]);
								}
							}
						</script>

						<c:if test="${category.image != null }">
							<img alt="" src="${category.image }" width="70px"
								class="img-fluid rounded border" id="images">
						</c:if>
						<c:if test="${category.image == null }">
							<img alt="" src="/templates/images/noimage.jpg" width="70px"
								class="img-fluid rounded border" id="images">
						</c:if>
						<br />
						<!-- Image & Upload -->


						<div class="mb-3">
							<label for="imageFile" class="form-label">Image File</label> <input
								type="file" class="form-control-file" value="${category.imageFile}"
								name="imageFile" id="imageFile" aria-describedby="imageFile"
								placeholder="Category Image" onchange="chooseFile(this)"
								accept=".jpg, .png">
						</div>

						<div class="mb-3">
							<label for="categoryname" class="form-label">Category Name</label> 
							<input type="text" class="form-control"
								value="${category.categoryName}" name="categoryName" id="categoryName" path="categoryName"
								aria-describedby="categoryNameid" placeholder="Category Name">
						</div>

						<div class="mb-3">
							<label for="delete">Status</label> <select class="form-select"
								name="delete" aria-label="delete" id="delete">
								<option ${store.delete == false ? 'selected' : '' }
									value="false"">Hoạt động</option>
								<option ${store.delete == true ? 'selected' : '' }
									value="true"">Không hoạt động</option>
							</select>
						</div>

					</div>
				</div>
				<div class="card-footer text-muted">
					<a href='<c:url value="/admin/categories/add"/>' class="btn btn-secondary"><i class="fa-solid fa-plus"></i> New</a>
					<a href='<c:url value="/admin/categories"/>' class="btn btn-success"><i class="fas fa-bars"></i> List Categories</a>
					<button class="btn btn-primary" type="submit" ><i class="fas fa-save"></i>
						<c:if test="${category.isEdit }">
						<span>Update</span>
						</c:if>
						<c:if test="${!category.isEdit }">
						<span>Save</span>
						</c:if>	
					</button>
				</div>
			</form>
		</div>
	</section>
</body>
</html>