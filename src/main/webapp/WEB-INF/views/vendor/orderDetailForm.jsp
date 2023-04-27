<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Order detail</title>
</head>
<body>
	<a href="/vendor/order">Trở về</a>
	<form action="/vendor/order/updatestatus" method="post">
		<input name="orderId" value="${orderItems[0].order.orderId}" style="display: none;">
		<p>Họ tên người đặt: ${orderItems[0].order.user.lastName} ${orderItems[0].order.user.firstName}</p>
		<p>Địa chỉ giao hàng: ${orderItems[0].order.address}</p>
		<p>Số điện thoại người nhận: ${orderItems[0].order.phone}</p>
		<p>Ngày đặt: ${orderItems[0].order.createAt}</p>
		<p>Danh sách sản phẩm mua: </p>
		<table>
			<thead>
			 <tr>
			 	<th>| Ảnh</th>
				<th>| Tên</th>
				<th>| Số lượng</th>
				<th>| Giá</th>
			</tr>
			</thead>
			
			<tbody>
			     <c:forEach items="${orderItems}" var="o">
			        <tr style="margin: 8px 0;">
			            <td><img id="image" alt="" src="${o.book.image}" style="width: 50px;"></td>
			            <td>| ${o.book.bookName}</td>
			            <td>| ${o.count}</td>
			            <td>| ${o.book.price * o.count}</td>
			        </tr>
			    </c:forEach>
			</tbody>
		</table>
		<p>Tổng số tiền của đơn hàng: ${totalOrderPrice}</p>
			<label for="">Tình trạng đơn hàng: 
			<select id="orderStatus" name="status">
				<option	${orderItems[0].order.status=="not_processed"?'selected':''} value="not_processed">Chờ xử lý</option>
				<option	${orderItems[0].order.status=="processing"?'selected':''} value="processing">Đang xử lý</option>
				<option	${orderItems[0].order.status=="shipped"?'selected':''} value="shipped">Đang giao</option>
				<option	${orderItems[0].order.status=="delivered"?'selected':''} value="delivered">Đã giao</option>
				<option	${orderItems[0].order.status=="cancelled"?'selected':''} value="cancelled">Đã hủy</option>
			</select></label>
		<input type="submit" value="Cập nhật tình trạng">
	</form>
</body>
</html>