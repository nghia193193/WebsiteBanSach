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
							<i class="fa fa-globe"></i>Sản phẩm
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
									<form action="/user/list">
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
										<!-- <thead class="thear-inverse">
											<tr>
												<th>Book Name</th>
												<th>Author</th>
												<th>Sold</th>
												<th>Price</th>
												<th>Sale</th>
												<th>Rating</th>
											</tr>
										</thead> -->
										<tbody>
											<c:forEach items="${bookPage.content}" var="book">
												<div class="card card-body mt-3">
													<div
														class="media align-items-center align-items-lg-start text-center text-lg-left flex-column flex-lg-row">
														<div class="mr-2 mb-3 mb-lg-0">

															<img src="https://i.imgur.com/Aj0L4Wa.jpg" width="150"
																height="150" alt="">

														</div>

														<div class="media-body">
															<h6 class="media-title font-weight-semibold">
																<a href="#" data-abc="true">${book.bookName}</a>
															</h6>

															<ul class="list-inline list-inline-dotted mb-3 mb-lg-2">
																<li class="list-inline-item"><a href="#"
																	class="text-muted" data-abc="true">Author:
																		${book.author}</a></li>
																<li class="list-inline-item"><a href="#"
																	class="text-muted" data-abc="true">Sold:
																		${book.sold}</a></li>
															</ul>

															<p class="mb-3">Lorem ipsum dolor sit amet,
																consectetur adipiscing elit, sed do eiusmod tempor
																incididunt ut labore et dolore magna aliqua.</p>

															<input type="number" id="quan" class="mb-3">
														</div>

														<div class="mt-3 mt-lg-0 ml-lg-3 text-center">
															<h3 class="mb-0 font-weight-semibold">${book.promotionalPrice}</h3>

															<div>
																<i class="fa fa-star"></i> <i class="fa fa-star"></i> <i
																	class="fa fa-star"></i> <i class="fa fa-star"></i> <i
																	class="fa fa-star"></i>

															</div>

															<div class="text-muted">Rate: ${book.rating}</div>
															
															
															<a href="" id="add"
														onclick="getById(${book.bookId})" class="btn btn-warning col-6">Add</a>&nbsp;
															
															<!-- <button type="button"
																class="btn btn-warning mt-4 text-white">
																<i class="icon-cart-add mr-2"></i> Add to cart
															</button> -->
														</div>
													</div>
												</div>
												<%-- <tr>
													<td>${book.bookName}</td>
													<td>${book.author}</td>
													<td>${book.sold}</td>
													<td>${book.price}</td>
													<td>${book.promotionalPrice}</td>
													<td>${book.rating}</td>
													<td><input type="number" id="quan" class="col-6">
													</td>

													<td><a href="" id="add"
														onclick="getById(${book.bookId})" class="col-6">Add</a>&nbsp;

													
												</tr> --%>

											</c:forEach>

										</tbody>
									</table>
								</c:if>

								<div class="row">
									<form action="/user/list">
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
												href="<c:url value='/user/list?name=${bookName}&size=${bookPage.size}&page=${1}'/>"
												tabindex="-1" aria-disabled="true">First</a>
											</li>
											<c:forEach items="${pageNumbers}" var="pageNumber">
												<c:if test="${bookPage.totalPages > 1}">
													<li
														class="${pageNumber == bookPage.number +1 ? 'page-item active':'page-item'}"><a
														class="page-link"
														href="<c:url value='/user/list?name=${bookName}&size=${bookPage.size}&page=${pageNumber}'/>">${pageNumber}</a></li>
												</c:if>
											</c:forEach>
											<li
												class="${bookPage.totalPages == bookPage.number + 1 ? 'page-item active':'page-item'}">
												<a
												href="<c:url value='/user/list?name=${bookName}&size=${bookPage.size}&page=${bookPage.totalPages}'/>"
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

