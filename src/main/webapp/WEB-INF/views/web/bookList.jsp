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
							<i class="fa fa-globe"></i>Quản lý Category
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
									<form action="/home/listByPage">
										<div class="input-group">
											<input type="text" class="form-control ml-2" name="name"
												id="name" placeholder="Nhập để tìm kiếm">
											<button class="btn btn-outline-primary ml-2">Search
											</button>
										</div>
								</div>
								<c:if test="${!bookPage.hasContent()}">
									<div class="row">
										<div class="col">
											<div class="alert alert-danger">Khong thayas</div>
										</div>
									</div>
								</c:if>
								<c:if test="${bookPage.hasContent()}">
									<table class="table table-striped table-responsive">
										<thead class="thear-inverse">
											<tr>
												<th>Book Name</th>
												<th>Author</th>
												<th>Sold</th>
												<th>Price</th>
												<th>Sale</th>
												<th>Rating</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach items="${bookPage.content}" var="book">
												<tr>
													<td>${book.bookName}</td>
													<td>${book.author}</td>
													<td>${book.sold}</td>
													<td>${book.price}</td>
													<td>${book.promotionalPrice}</td>
													<td>${book.rating}</td>
													<%-- <form:button action="/addToCart" method="POST">
														<input type"number" name="quantity" class="form-control">
													</form:button> --%>
												</tr>

											</c:forEach>

										</tbody>
									</table>
								</c:if>

								<div class="row">
									<form action="/home/listByPage">
										<div class="mb-3 input-group float-left">
											<label for="size" class="mr-2">Page size:</label> <select
												class="form-select ml-2" name="size" aria-label="size"
												id="size" onchange="this.form.submit()">
												<option ${bookPage.size==1 ? 'selected':''} value="1">1</option>
												<option ${bookPage.size==3 ? 'selected':''} value="3">3</option>
												<option ${bookPage.size==5 ? 'selected':''} value="5">5</option>
												<option ${bookPage.size==7 ? 'selected':''} value="7">7</option>
											</select>
										</div>
									</form>
								</div>

								<c:if test="${bookPage.totalPages > 0}">
									<nav aria-label="Page navigation example">
										<ul class="pagination">
											<li
												class="${1==bookPage.number +1 ? 'page-team active':'page-item' }">
												<a class="page-link"
												href="<c:url value='/home/listByPage?name=${bookName}&size=${bookPage.size}&page=${1}'/>"
												tabindex="-1" aria-disabled="true">First</a>
											</li>
											<c:forEach items="${pageNumbers}" var="pageNumber">
												<c:if test="${bookPage.totalPages > 1}">
													<li
														class="${pageNumber == bookPage.number +1 ? 'page-item active':'page-item'}"><a
														class="page-link"
														href="<c:url value='/home/listByPage?name=${bookName}&size=${bookPage.size}&page=${pageNumber}'/>">${pageNumber}</a></li>
												</c:if>
											</c:forEach>
											<li
												class="${bookPage.totalPages == bookPage.number + 1 ? 'page-item active':'page-item'}">
												<a
												href="<c:url value='/home/listByPage?name=${bookName}&size=${bookPage.size}&page=${bookPage.totalPages}'/>"
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
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script>
	$(document).ready(function() {
		$(".minusButton").on("click", function(event) {
			event.preventDefault();
			decreaseQuantity($(this));
		});
		$(".plusButton").on("click", function(event) {
			event.preventDefault();
			increaseQuantity($(this));
		});
		updateTotal();
	});

	function decreaseQuantity(link) {
		id = link.attr("pid");
		qtyInput = $("#quantity" + id);
		newQty = parseInt(qtyInput.val()) - 1;
		if (newQty > 0) {
			qtyInput.val(newQty);
			updateQuantity();
		}
	}

	function increaseQuantity(link) {
		id = link.attr("pid");
		qtyInput = $("#quantity" + id);
		newQty = parseInt(qtyInput.val()) + 1;
		if (newQty < 10) {
			qtyInput.val(newQty);
			updateQuantity();
		}
	}

	function updateQuantity() {

	}

	function updateTotal() {
		total = 0.0;
		$(".productSubtotal").each(function(index, element) {
			total = total + parseFloat(element.innerHTML);
		});
		$("#totalAmount").text(total);
	}
</script>