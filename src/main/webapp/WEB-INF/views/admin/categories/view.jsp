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
						<h2>${category.categoryName}</h2>
					</div>
					<div class="card-body">
					
						<div class="mb-3">
							<label for="categoryId" class="form-label">Category ID</label>
							<input
							type="text" readonly="readonly" class="form-control"
							value="${category.categoryId}" aria-describedby="categoryIdid"
							placeholder="Category Id" id="categoryId" name="categoryId" path="categoryId">
						</div>
						
						<c:if test="${category.image != null }">
							<img alt="" src="${category.image }" width="70px"
								class="img-fluid rounded border" id="images">
						</c:if>
						<c:if test="${category.image == null }">
							<img alt="" src="/templates/images/noimage.jpg" width="70px"
								class="img-fluid rounded border" id="images">
						</c:if>
						<br />
						<br />
						
						<div class="mb-3">
							<label for="delete">Status</label> 
							<input
							type="text" readonly="readonly" class="form-control"
							value="${category.delete ? 'Không hoạt động' : 'Hoạt động'}" aria-describedby="delete"
							placeholder="delete" id="delete" name="delete" path="delete">
						</div>
						
						<div class="mb-3">
							<label for="createAt">Create at</label> 
							<input
							type="text" readonly="readonly" class="form-control"
							value="${category.createAt}" aria-describedby="createAt"
							placeholder="createAt" id="createAt" name="createAt" path="createAt">
						</div>
						
						<c:if test="${category.updateAt != null }">
							<div class="mb-3">
							<label for="updateAt">Update at</label> 
							<input
							type="text" readonly="readonly" class="form-control"
							value="${category.updateAt}" aria-describedby="updateAt"
							placeholder="updateAt" id="updateAt" name="updateAt" path="updateAt">
						</div>
						</c:if>
						
						<div class="col-md-6">
						<div class="float-right">
							<a class="btn btn-outline-success" href="/admin/categories">Back</a>
						</div>
					</div>

					</div>
				</div>
				
			
		</div>
	</section>
</body>
</html>