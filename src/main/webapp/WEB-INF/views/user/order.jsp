<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>
<div class="page-content-wrapper">
	<div class="page-content">
		<div class="row">
			<div class="col-md-12">
				<!-- BEGIN EXAMPLE TABLE PORTLET-->
				<div class="portlet box grey-cascade">
					<div class="portlet-title">
						<div
							class="caption d-flex justify-content-center align-items-center">
						</div>
						<div class="tools">
							<a href="javascript:;" class="collapse"> </a> <a
								href="#portlet-config" data-toggle="modal" class="config"> </a>
							<a href="javascript:;" class="reload"> </a> <a
								href="javascript:;" class="remove"> </a>
						</div>
					</div>
					<div class="portlet-body">
						<div class="table-toolbar">
							<!-- Hiển thị thông báo -->
							<%-- <%@include file="/common/info.jsp"%> --%>
							<!-- Kết thúc hiển thị thông báo -->
							<div class="row mt-2 mb-2">
								<div class="col-md-6">
									<form action="/user/orderList">
										<div class="input-group">
											<input type="text" class="form-control ml-2" name="name"
												id="name" placeholder="Nhập để tìm kiếm">
											<button class="btn btn-outline-primary ml-2">Search
											</button>
										</div>
								</div>
								<c:if test="${!orderPage.hasContent()}">
									<div class="row">
										<div class="col">
											<div class="alert alert-danger">Khong thayas</div>
										</div>
									</div>
								</c:if>
								<c:if test="${orderPage.hasContent()}">
									<table class="table">
										<thead class="thear-inverse">

											<tr>
												<th>ID</th>
												<th>Store</th>
												<th>Ngày</th>
												<th>Số lượng</th>
												<th>Trạng thái</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach items="${orderPage.content}" var="order">
												<tr>
													<td>${order.orderId}</td>
													<td>${order.store.storeName}</td>
													<td>${order.createAt}</td>
													<td>${order.amountFromUser}</td>
													<td>${order.status}</td>
													<%-- <form:button action="/addToCart" method="POST">
														<input type"number" name="quantity" class="form-control">
													</form:button> --%>
												</tr>

											</c:forEach>

										</tbody>
									</table>
								</c:if>

								<div class="row">
									<form action="/user/orderList">
										<div class="mb-3 input-group float-left">
											<label for="size" class="mr-2">Page size:</label> <select
												class="form-select ml-2" name="size" aria-label="size"
												id="size" onchange="this.form.submit()">
												<option ${orderPage.size==1 ? 'selected':''} value="1">1</option>
												<option ${orderPage.size==3 ? 'selected':''} value="3">3</option>
												<option ${orderPage.size==5 ? 'selected':''} value="5">5</option>
												<option ${orderPage.size==7 ? 'selected':''} value="7">7</option>
											</select>
										</div>
									</form>
								</div>

								<c:if test="${orderPage.totalPages > 0}">
									<nav aria-label="Page navigation example">
										<ul class="pagination">
											<li
												class="${1==orderPage.number +1 ? 'page-team active':'page-item' }">
												<a class="page-link"
												href="<c:url value='/user/orderList?name=${bookName}&size=${orderPage.size}&page=${1}'/>"
												tabindex="-1" aria-disabled="true">First</a>
											</li>
											<c:forEach items="${pageNumbers}" var="pageNumber">
												<c:if test="${orderPage.totalPages > 1}">
													<li
														class="${pageNumber == orderPage.number +1 ? 'page-item active':'page-item'}"><a
														class="page-link"
														href="<c:url value='/user/orderList?name=${bookName}&size=${orderPage.size}&page=${pageNumber}'/>">${pageNumber}</a></li>
												</c:if>
											</c:forEach>
											<li
												class="${orderPage.totalPages == orderPage.number + 1 ? 'page-item active':'page-item'}">
												<a
												href="<c:url value='/user/orderList?name=${bookName}&size=${orderPage.size}&page=${orderPage.totalPages}'/>"
												class="page-link">Last</a>
											</li>
										</ul>
									</nav>
								</c:if>
							</div>
						</div>
					</div>
				</div>
				<!-- END EXAMPLE TABLE PORTLET-->
			</div>
		</div>
	</div>
</div>