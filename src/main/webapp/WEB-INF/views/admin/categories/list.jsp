<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/common/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zxx">


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
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css"
	integrity="sha512-MV7K8+y+gLIBoVD59lQIYicR65iaqukzvf/nwasF0nqhPay5w/9lJmVM2hMDcnK1OnMGCdVK+iQrJ7lzPJQd1w=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />

</head>
<body>

	<section class="row">

		<div class="col mt-4">

			<div class="card">

				
				<div class="card-header">List Category</div>
				
				<div class="card-body">
				
					

					<!-- Hiển thông báo -->

					<c:if test="${message != null}">
						<c:if test="${message == 'Xóa không thành công' }">
							<div class="row">
								<div class="col">
									<div class="alert alert-danger">${message }</div>
								</div>
							</div>
						</c:if>

						<c:if test="${message != 'Xóa không thành công' }">
							<div class="alert alert-primary" role="alert">

								<i>${message}</i>

							</div>
						</c:if>

					</c:if>

					<!-- Hêt thông báo -->
					
					<!-- Search -->
					<div class="container-fluid">
						<form class="d-flex" action="/admin/categories/searchpagenated">
							<input class="form-control me-2" type="search"
								placeholder="Search categoryname" aria-label="Search" id="name" name="name">
							<button class="btn btn-outline-success" type="submit">Search</button>
						</form>
					</div>

					<c:if test="${!categoryPage.hasContent() }">
						<div class="row">
							<div class="col">
								<div class="alert alert-danger">Chưa có Category hãy thêm mới</div>
							</div>
						</div>
					</c:if>

					<c:if test="${categoryPage.hasContent() }">
					<table class="table table-striped table-responsive">
						
						<thead class="thead-inverse">

							<tr>

								<th>Image</th>

								<th>Category ID</th>

								<th>Category Name</th>
								
								<th>Status</th>

								<th>Create At</th>
								
								<th>Update At</th>

								<th>Action</th>

							</tr>

						</thead>

						<tbody>
							<c:forEach items="${categoryPage.content}" var="category">
								
									<tr>
										<td><c:if test="${category.image != null }">
											<img alt="" src="${category.image }" width="70px" class="img-fluid">
										</c:if>
										<c:if test="${category.image == null }">
											<img alt="" src="/templates/images/noimage.jpg" width="70px" class="img-fluid">
										</c:if></td>
										<td scope="row">${category.categoryId}</td>
										<td>${category.categoryName}</td>
										<td>${category.delete ? 'Không hoạt động' : 'Hoạt động'}</td>
										<td>${category.createAt}</td>
										<td>${category.updateAt}</td>
										<td>
											<a
											href="/admin/categories/view/${category.categoryId}"
											class="btn btn-outline-info"><i class="fa fa-info"></i></a> 
											<a
											href="/admin/categories/edit/${category.categoryId}"
											class="btn btn-outline-warning"><i class="fa fa-edit"></i></a>

											<a 
												data-id="${category.categoryId }"
												data-name="${category.categoryName }"
												onclick="showconfirmation(this.getAttribute('data-id'), this.getAttribute('data-name'))"
											class="btn btn-outline-danger"><i class="fa fa-trash"></i></a>
										</td>
									</tr>
								
							</c:forEach>
						</tbody>
					</table>
					</c:if>
					
					<script type="text/javascript">
						function showconfirmation(id,name) {
							$('#categoryName').text(name);
							$('#yesOption').attr('href','/admin/categories/delete/' +id);
							$('#confirmationId').modal('show');
						}
					</script>
					
					<!-- Modal -->
					<div class="modal fade" id="confirmationId" tabindex="-1"
						aria-labelledby="confirmationLabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="confirmationLabel">Confirmation</h5>
									<button type="button" class="btn-close" data-bs-dismiss="modal"
										aria-label="Close"></button>
								</div>
								
								<div class="modal-body">
									Bạn có muốn xóa "<span id="categoryName"></span>"?
								</div>
								<div class="modal-footer">
									<a id="yesOption" class="btn btn-primary">Yes</a>
									<button type="button" class="btn btn-secondary"
										data-bs-dismiss="modal">Close</button>
								</div>
							</div>
						</div>
					</div>
					<!-- Modal -->
					
					<div class="row">
						<div class="col-5">
							<form action="">
								<div class="mb-3 input-group float-left">
									<label for="size" class="mr-2"> Page size:</label>
									<select class="form-select ml-2" name="size" aria-label="size" id="size" onchange="this.form.submit()">
										<option ${categoryPage.size == 3 ? 'selected' : '' } value="3">3</option>
										<option ${categoryPage.size == 5 ? 'selected' : '' } value="5">5</option>
										<option ${categoryPage.size == 10 ? 'selected' : '' } value="10">10</option>
										<option ${categoryPage.size == 15 ? 'selected' : '' } value="15">15</option>
										<option ${categoryPage.size == 20 ? 'selected' : '' } value="20">20</option>
									</select>
								</div>
							</form>
						
						</div>
						<div class="col-7">
							<!-- Phân trang -->
							<c:if test="${categoryPage.totalPages > 0 }">
								<nav aria-label="Page navigation">
									<ul class="pagination">
										<li class="${1 == categoryPage.number+1 ? 'page-item active' : 'page-item' }">
										<a class="page-link"
											href='<c:url value="/admin/categories?size=${categoryPage.size}&page=${1}"/>'
											tabindex="-1" aria-disabled="true">First</a></li>
										
										<c:forEach items="${pageNumbers }" var="pageNumber">
											<c:if test="${categoryPage.totalPages > 1 }">
												<li class="${pageNumber == categoryPage.number+1 ? 'page-item active' : 'page-item' }">
												<a href='<c:url value="/admin/categories?size=${categoryPage.size}&page=${pageNumber}"/>' 
												class="page-link">${pageNumber }</a></li>
											</c:if>
										</c:forEach>
											
										<li class="${categoryPage.totalPages == categoryPage.number+1? 'page-item active' : 'page-item' }">
										<a href='<c:url value="/admin/categories?size=${categoryPage.size}&page=${categoryPage.totalPages}"/>' class="page-link">Last</a>
										</li>
									</ul>
								</nav>
							</c:if>
							<!-- end phân trang -->
						</div>
					</div>
					
					<div class="col-md-6">
						<div class="float-right">
							<a class="btn btn-outline-success" href="/admin/categories/add">Add New Category</a>
						</div>
					</div>
				</div>



			</div>

		</div>

	</section>
</body>