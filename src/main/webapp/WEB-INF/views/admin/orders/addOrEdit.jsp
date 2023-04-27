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
			<form action="<c:url value="/admin/stores/${storeId }/orders/saveOrUpdate" />" method="post" enctype="multipart/form-data">
				<div class="card">
					<div class="card-header">
						<h2>${order.isEdit ? "Edit Đơn hàng" : "Add new Đơn hàng"}</h2>
					</div>
					<div class="card-body">
						<div class="row">
							<div class="col-7">
								<c:if test="${order.isEdit }">
									<div class="mb-3">
										<label for="orderId" class="form-label">Order ID</label>
										<input type="hidden" value="${order.isEdit}" name="isEdit"> 
										
											<input
											type="text" readonly="readonly" class="form-control"
											value="${order.orderId}" aria-describedby="orderIdid"
											placeholder="order Id" id="orderId" name="orderId" path="orderId">
									</div>
								</c:if>
													
								<div class="mb-3">
									<label for="status">Status</label> <select class="form-select"
										name="status" aria-label="status" id="status">
										<option ${order.status == 'not_processed' ? 'selected' : '' }
											value="not_processed">Chưa xử lý</option>
										<option ${order.status == 'processing' ? 'selected' : '' }
											value="processing">Đang xử lý</option>
										<option ${order.status == 'shipped' ? 'selected' : '' }
											value="shipped">Đang giao</option>
										<option ${order.status == 'delivered' ? 'selected' : '' }
											value="delivered">Đã giao</option>
										<option ${order.status == 'cancelled' ? 'selected' : '' }
											value="cancelled">Đã hủy</option>
									</select>
								</div>


								<div class="mb-3">
									<label for="storeId">Store</label>
									<input
											type="text" readonly="readonly" class="form-control"
											value="${storeId}" aria-describedby="storeId"
											placeholder="storeId" id="storeId" name="storeId" path="storeId">
								</div>					
							</div>
						</div>	
					</div>
				</div>
				
				<div class="card-footer text-muted">
					<a href='<c:url value="/admin/stores/${storeId }/orders"/>' class="btn btn-success"><i class="fas fa-bars"></i> List Orders</a>
					<button class="btn btn-primary" type="submit" ><i class="fas fa-save"></i>
						<c:if test="${order.isEdit }">
						<span>Update</span>
						</c:if>
						<c:if test="${!order.isEdit }">
						<span>Save</span>
						</c:if>	
					</button>
				</div>
			</form>
		</div>
	</section>
</body>
</html>