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

				<div class="card-header">Danh sách các đơn hàng</div>

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
							<form class="d-flex" action="/admin/stores/${storeId }/orders/searchpagenated">
								<input class="form-control me-2" type="search"
									placeholder="Search username" aria-label="Search" id="name" name="name">
								<button class="btn btn-outline-success" type="submit">Search</button>
							</form>
						</div>

					<c:if test="${!orderPage.hasContent() }">
						<div class="row">
							<div class="col">
								<div class="alert alert-danger">Chưa có đơn hàng nào</div>
							</div>
						</div>
					</c:if>
					
					<c:if test="${orderPage.hasContent() }">
					<table class="table table-striped table-responsive">

						<thead class="thead-inverse">

							<tr>
								<th>Order ID</th>
								<th>Username</th>
								<th>Phone</th>
								<th>Address</th>
								<th>Status</th>
								<th>Create At</th>																
								<th>Update At</th>
								<th>Action</th>
							</tr>

						</thead>

						<tbody>
							<c:forEach items="${orderPage.content}" var="order">
								
									<tr>
										
										<td scope="row">${order.orderId}</td>
										<td>${order.user.username}</td>
										<td>${order.phone}</td>
										<td>${order.address}</td>
										<td>
											<c:if test="${order.status == 'not_processed' }">Chưa xử lý</c:if>
											<c:if test="${order.status == 'processing' }">Đang xử lý</c:if>
											<c:if test="${order.status == 'shipped' }">Đang giao</c:if>
											<c:if test="${order.status == 'delivered' }">Đã giao</c:if>
											<c:if test="${order.status == 'cancelled' }">Đã hủy</c:if>
										</td>
										<td>${order.createAt}</td>
										<td>${order.updateAt}</td>
										<td>
											<a
											href="/admin/stores/${storeId }/orders/${order.orderId}/view"
											class="btn btn-outline-info"><i class="fa fa-info"></i></a> 
											<a
											href="/admin/stores/${storeId }/orders/${order.orderId}/edit"
											class="btn btn-outline-warning"><i class="fa fa-edit"></i></a>
	
											
										</td>
									</tr>
								
							</c:forEach>
						</tbody>
					</table>
					</c:if>
					
					
					<div class="row">
						<div class="col-5">
							<form action="">
								<div class="mb-3 input-group float-left">
									<label for="size" class="mr-2"> Page size:</label>
									<select class="form-select ml-2" name="size" aria-label="size" id="size" onchange="this.form.submit()">
										<option ${orderPage.size == 3 ? 'selected' : '' } value="3">3</option>
										<option ${orderPage.size == 5 ? 'selected' : '' } value="5">5</option>
										<option ${orderPage.size == 10 ? 'selected' : '' } value="10">10</option>
										<option ${orderPage.size == 15 ? 'selected' : '' } value="15">15</option>
										<option ${orderPage.size == 20 ? 'selected' : '' } value="20">20</option>
									</select>
								</div>
							</form>
						
						</div>
						<div class="col-7">
							<!-- Phân trang -->
							<c:if test="${orderPage.totalPages > 0 }">
								<nav aria-label="Page navigation">
									<ul class="pagination">
										<li class="${1 == orderPage.number+1 ? 'page-item active' : 'page-item' }">
										<a class="page-link"
											href='<c:url value="/admin/stores/${storeId }/orders?size=${orderPage.size}&page=${1}"/>'
											tabindex="-1" aria-disabled="true">First</a></li>
										
										<c:forEach items="${pageNumbers }" var="pageNumber">
											<c:if test="${orderPage.totalPages > 1 }">
												<li class="${pageNumber == orderPage.number+1 ? 'page-item active' : 'page-item' }">
												<a href='<c:url value="/admin/stores/${storeId }/orders?size=${orderPage.size}&page=${pageNumber}"/>' 
												class="page-link">${pageNumber }</a></li>
											</c:if>
										</c:forEach>
											
										<li class="${orderPage.totalPages == orderPage.number+1? 'page-item active' : 'page-item' }">
										<a href='<c:url value="/admin/stores/${storeId }/orders?size=${orderPage.size}&page=${orderPage.totalPages}"/>' class="page-link">Last</a>
										</li>
									</ul>
								</nav>
							</c:if>
							<!-- end phân trang -->
						</div>
					</div>
					
				</div>



			</div>

		</div>

	</section>
</body>