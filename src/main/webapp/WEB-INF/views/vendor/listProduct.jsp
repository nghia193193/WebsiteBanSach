<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp" %>
<div>
	<a href="/vendor/product/onsale" class="btn btn-primary">Đang mở bán</a>
	&nbsp;
	<a href="/vendor/product/instorage" class="btn btn-secondary">Đang lưu trữ</a>
</div>
<c:choose>
<c:when test="${onSale==true}">
	<div style="color: red;">Sản phẩm đang mở bán</div>
</c:when>
<c:otherwise>
	<div style="color: red;">Đang được lưu trữ trong kho</div>
</c:otherwise>
</c:choose> 
<div>
	<a href="add" class="btn btn-danger">Thêm sản phẩm</a>
</div>
<c:if test="${message != null}">
	<div class="alert alert-primary" role="alert">
		<i>${message}</i>
	</div>
</c:if>

<table class="table">
	<thead>
		<tr>
			<th>Ảnh</th>
			<th>Tên Sách</th>
			<th>Giá</th>
			<th>Số Lượng</th>
			<th>Tác Giả</th>
			<th>Thể Loại</th>
			<th>Hành Động</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${books}" var="book">
			<tr>
				<td>
				<c:if test="${book.image != null }">
					<img src="${book.image}" width="70">
				</c:if>
				<c:if test="${book.image == null }">
					<img src="templates/images/noimage.png" width="70">
				</c:if>
				&nbsp;&nbsp;
				</td>
				<td>${book.bookName}&nbsp;&nbsp;</td>
				<td>${book.price}&nbsp;&nbsp;</td>
				<td>${book.quantity}&nbsp;&nbsp;</td>
				<td>${book.author}&nbsp;&nbsp;</td>
				<td>${book.category.categoryName}&nbsp;&nbsp;</td>
				
				<td><a href="/vendor/product/edit/${book.bookId}">Chỉnh sửa</a>&nbsp;
					<a href="/vendor/product/delete/${book.bookId}" data-id="${book.bookId}"
					data-name="${book.bookName}">Xóa</a></td>
			</tr>
		</c:forEach>
	</tbody>
</table>