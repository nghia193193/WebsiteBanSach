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
						<h2>${order.userId}</h2>
					</div>
					<div class="card-body">

					<div class="mb-3">
						<label for="orderId" class="form-label">Order ID</label> <input
							type="text" readonly="readonly" class="form-control"
							value="${order.orderId}" aria-describedby="orderIdid"
							placeholder="order Id" id="orderId" name="orderId" path="orderId">
					</div>
		
					<div class="mb-3">
									<label for="address" class="form-label">Địa chỉ:</label>
									<input type="text" readonly="readonly" class="form-control"
										value="${order.address}" name="address" id="address" path="address"
										aria-describedby="address" placeholder="address">
								</div>
									
					<h3>Danh sách sản phẩm</h3>	
					<c:forEach items="${orderItems }" var="orderItem">	
						<div class="row">
							<div class="col-2 mt-5">
								<c:if test="${orderItem.book.image != null }">
									<img alt="" src="${orderItem.book.image }" width="70px"
										class="img-fluid rounded border" id="images">
								</c:if>
							</div>
							<div class="col">
								<div class="mb-3">
									<label for="bookId" class="form-label">Tên sách:</label> <input
										type="text" readonly="readonly" class="form-control"
										value="${orderItem.book.bookName}" name="bookId" id="bookId"
										path="bookId" aria-describedby="bookId" placeholder="bookId">
								</div>
		
								<div class="mb-3">
									<label for="count" class="form-label">Số lượng:</label> <input
										type="text" readonly="readonly" class="form-control"
										value="${orderItem.count}" name="count" id="count"
										path="count" aria-describedby="count" placeholder="count">
								</div>
							</div>
						</div>
					</c:forEach>
					<br/>
					<div class="mb-3">
						<label for="paidBefore">Loại thanh toán</label> <input type="text"
							readonly="readonly" class="form-control"
							value="${order.paidBefore ? 'Trả trước' : 'Trả sau'}"
							aria-describedby="paidBefore" placeholder="paidBefore"
							id="paidBefore" name="paidBefore" path="paidBefore">
					</div>

					<div class="mb-3">
						<label for="amountFromUser">Tiền đã trả:</label> <input type="text"
							readonly="readonly" class="form-control"
							value="${order.amountFromUser}"
							aria-describedby="amountFromUser" placeholder="amountFromUser"
							id="amountFromUser" name="amountFromUser" path="amountFromUser">
					</div>
					
					<div class="mb-3">
						<label for="amountToStore">Tiền shop nhận:</label> <input type="text"
							readonly="readonly" class="form-control"
							value="${order.amountToStore}"
							aria-describedby="amountToStore" placeholder="amountToStore"
							id="amountToStore" name="amountToStore" path="amountToStore">
					</div>
					
					<div class="mb-3">
						<label for="amountToGD">Tiền hệ thống nhận:</label> <input type="text"
							readonly="readonly" class="form-control"
							value="${order.amountToGD}"
							aria-describedby="amountToGD" placeholder="amountToGD"
							id="amountToGD" name="amountToGD" path="amountToGD">
					</div>

					<div class="mb-3">
							<label for="status">Status</label> 
							<c:if test="${order.status == 'not_processed'}">
								<input
								type="text" readonly="readonly" class="form-control"
								value="Chưa xử lý" aria-describedby="status"
								placeholder="status" id="status" name="status" path="status">
							</c:if>
							<c:if test="${order.status == 'processing'}">
								<input
								type="text" readonly="readonly" class="form-control"
								value="Đang xử lý" aria-describedby="status"
								placeholder="status" id="status" name="status" path="status">
							</c:if>
							<c:if test="${order.status == 'shipped'}">
								<input
								type="text" readonly="readonly" class="form-control"
								value="Đang giao" aria-describedby="status"
								placeholder="status" id="status" name="status" path="status">
							</c:if>
							<c:if test="${order.status == 'delivered'}">
								<input
								type="text" readonly="readonly" class="form-control"
								value="Đã giao" aria-describedby="status"
								placeholder="status" id="status" name="status" path="status">
							</c:if>
							<c:if test="${order.status == 'cancelled'}">
								<input
								type="text" readonly="readonly" class="form-control"
								value="Đã hủy" aria-describedby="status"
								placeholder="status" id="status" name="status" path="status">
							</c:if>
						</div>
						
						<div class="mb-3">
							<label for="createAt">Create at</label> 
							<input
							type="text" readonly="readonly" class="form-control"
							value="${order.createAt}" aria-describedby="createAt"
							placeholder="createAt" id="createAt" name="createAt" path="createAt">
						</div>
						
						<c:if test="${order.updateAt != null }">
							<div class="mb-3">
							<label for="updateAt">Update at</label> 
							<input
							type="text" readonly="readonly" class="form-control"
							value="${order.updateAt}" aria-describedby="updateAt"
							placeholder="updateAt" id="updateAt" name="updateAt" path="updateAt">
						</div>
						</c:if>
						
						<div class="col-md-6">
						<div class="float-right">
							<a class="btn btn-outline-success" href="/admin/stores/${storeId}/orders">Back</a>
						</div>
					</div>

					</div>
				</div>
				
				
			
		</div>
	</section>
</body>
</html>