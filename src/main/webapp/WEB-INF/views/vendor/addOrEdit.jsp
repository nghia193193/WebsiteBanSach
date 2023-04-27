<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>

<c:url value="/vendor/product/saveOrUpdate" var="saveOrUpdateUrl" />
<form action="${saveOrUpdateUrl}" method="post"
	enctype="multipart/form-data">
	<div class="col-sm">
		<!-- Account details card-->
		<div class="card mb-4 align-center">
			<div class="card-body">
				<div class="card-header">
					<h2>${book.isEdit ?'Chỉnh sửa sản phẩm':'Thêm sản phẩm'}</h2>
				</div>
				<div>
					<input class="form-control" id="bookId" name="bookId"
						value="${book.bookId}" style="display: none;"> <label
						class="small mb-1" for="bookName">Tên sách: </label> <input
						class="form-control" id="bookName" name="bookName"
						value="${book.bookName}" placeholder="Nhập tên sách..." />
				</div>

				<!-- Form Row-->
				<div class="row gx-3 mb-3">
					<!-- Form Group (first name)-->
					<div class="col-md-6">
						<label class="small mb-1" for="author">Tên tác giả: </label> <input
							class="form-control" id="author" name="author"
							value="${book.author}" placeholder="Nhập tên tác giả..." />
						<form:errors path="author" />
					</div>
					<!-- Form Group (last name)-->
					<div class="col-md-6">
						<label class="small mb-1" for="publisher">Nhà xuất bản: </label> <input
							class="form-control" id="publisher" name="publisher"
							value="${book.publisher}" placeholder="Nhập nhà xuất bản..." />
						<form:errors path="publisher" />
					</div>

				</div>

				<div class="row gx-3 mb-3">
					<div class="col-md-6">
						<!-- Form Group (first name)-->
						<c:if test="${book.image != null}">
							<img id="image" alt="" src="${book.image}" style="width: 100px;">
						</c:if>
						<c:if test="${book.image == null}">
							<img id="image" alt="" src="/templates/images/noimage.png"
								style="width: 100px;">
						</c:if>
						<label>Choose image: <input type="file"
							onchange="chooseFile(this)" id="imageFile" name="imageFile"
							placeholder="Book image" accept=".jpg, .png"></label>
					</div>
					<div class="col-md-6">
						<label class="small mb-1" for="language">Ngôn ngữ: <select
							name="language" id="language">
								<option ${book.language=="VN"?'selected':''} value="VN">Tiếng
									Việt</option>
								<option ${book.language=="EN"?'selected':''} value="EN">Tiếng
									Anh</option>
						</select></label>
					</div>
				</div>
				<div class="row gx-3 mb-3">
				<div class="col-md-6">
					<label for="price">Giá: <input type="number" id="price"
						name="price" placeholder="Nhập giá tiền..." min="1"
						value="${book.price}"></label>
				</div>
				<div class="col-md-6">
					<label for="promotionalPrice">Giá khuyến mãi: <input
						type="number" id="promotionalPrice" name="promotionalPrice"
						placeholder="Nhập giá khuyến mãi..." min="1"
						value="${book.promotionalPrice}"></label>
				</div>
				</div>
				<div class="row gx-3 mb-3">
				<div class="col-md-6">
					<label for="quantity">Số lượng trong kho: <input
						type="number" id="quantity" name="quantity" min="1"
						value="${book.quantity}"></label>
				</div>
				<div class="col-md-6">
					<label>Tình trạng: <select name="selling" id="selling">
							<option ${book.selling==true?'selected':''} value="1">Mở
								bán</option>
							<option ${book.selling==false?'selected':''} value="0">Lưu
								trữ</option>
					</select>
					</label>
				</div>
				</div>
				<label>Thể loại: </label> <select id="categoryId" name="categoryId">
					<c:forEach items="${categories}" var="category">
						<option ${category.categoryId==book.categoryId ?'selected':''}
							value="${category.categoryId}">${category.categoryName}</option>
					</c:forEach>
				</select>
				<div>
					<c:choose>
						<c:when test="${book.isEdit==true}">
							<input type="radio" checked="checked" id="isEdit" name="isEdit"
								style="display: none;">
							<input type="submit" value="Cập nhật" />
						</c:when>
						<c:otherwise>
							<input type="radio" id="isEdit" name="isEdit"
								style="display: none;">
							<input class="btn btn-danger" type="submit" value="Thêm mới" />
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
	</div>
</form>
