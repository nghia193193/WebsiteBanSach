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
			<form action="<c:url value="/admin/stores/${storeId }/books/saveOrUpdate" />" method="post" enctype="multipart/form-data">
				<div class="card">
					<div class="card-header">
						<h2>${book.isEdit ? "Edit Book" : "Add new book"}</h2>
					</div>
					<div class="card-body">
						<div class="row">
							<div class="col-7">
								<c:if test="${book.isEdit }">
									<div class="mb-3">
										<label for="bookId" class="form-label">Book ID</label>
										<input type="hidden" value="${book.isEdit}" name="isEdit"> 
										
											<input
											type="text" readonly="readonly" class="form-control"
											value="${book.bookId}" aria-describedby="bookIdid"
											placeholder="Book Id" id="bookId" name="bookId" path="bookId">
									</div>
								</c:if>
								
								<!-- Image & Upload -->
								<script type="text/javascript">
									function chooseFile(fileInput) {
										if(fileInput.files && fileInput.files[0]) {
											var reader = new FileReader();
											reader.onload = function(e) {
												$('#images').attr('src', e.target.result);
											}
											reader.readAsDataURL(fileInput.files[0]);
										}
									}
								</script>
								
								<c:if test="${book.image != null }">
									<img alt="" src="${book.image }" width="70px" class="img-fluid rounded border" id="images">
								</c:if>
								<c:if test="${book.image == null }">
									<img alt="" src="/templates/images/noimage.jpg" width="70px" class="img-fluid rounded border" id="images">
								</c:if>
								<br/>
								<!-- Image & Upload -->
								
								<div class="mb-3">
									<label for="imageFile" class="form-label">Image File</label> 
									<input type="file" class="form-control-file"
										value="${book.imageFile}" name="imageFile" id="imageFile"
										aria-describedby="imageFile" placeholder="Book Image"
										onchange="chooseFile(this)" accept=".jpg, .png">
								</div>
								
								<div class="mb-3">
									<label for="bookname" class="form-label">Book Name</label>
									<input type="text" class="form-control"
										value="${book.bookName}" name="bookName" id="bookName" path="bookName"
										aria-describedby="bookNameid" placeholder="Book Name">
								</div>
								
								<div class="mb-3">
									<label for="author" class="form-label">Author</label>
									<input type="text" class="form-control"
										value="${book.author}" name="author" id="author" path="author"
										aria-describedby="author" placeholder="Author">
								</div>
								
								<div class="mb-3">
									<label for="publisher" class="form-label">Publisher</label>
									<input type="text" class="form-control"
										value="${book.publisher}" name="publisher" id="publisher" path="publisher"
										aria-describedby="publisher" placeholder="Publisher">
								</div>
								
								<div class="mb-3">
									<label for="language" class="form-label">Language</label>
									<input type="text" class="form-control"
										value="${book.language}" name="language" id="language" path="language"
										aria-describedby="language" placeholder="Language">
								</div>
								
								<div class="mb-3">
									<label for="price" class="form-label">Price</label>
									<input type="text" class="form-control"
										value="${book.price}" name="price" id="price" path="price"
										aria-describedby="price" placeholder="Price">
								</div>
								
								
								
								<div class="mb-3">
									<label for="quantity" class="form-label">Quantity</label>
									<input type="text" class="form-control"
										value="${book.quantity}" name="quantity" id="quantity" path="quantity"
										aria-describedby="quantity" placeholder="quantity">
								</div>
								
								
								
								<div class="mb-3">
									<label for="categoryId">Category</label>
									<select class="form-select" name="categoryId" aria-label="categoryId" id="categoryId">
										<c:forEach items="${categories }" var="item">
											<c:if test="${item.delete == false }">
												<option value="${item.categoryId }" selected="${item.categoryId == category.categoryId ? 'selected' : '' }">${item.categoryName }</option>
											</c:if>
										</c:forEach>
									</select>
								</div>

								<div class="mb-3">
									<label for="selling">Status</label> <select class="form-select"
										name="selling" aria-label="selling" id="selling">
										<option ${book.selling == false ? 'selected' : '' }
											value="false"">Ngừng bán</option>
										<option ${book.selling == true ? 'selected' : '' }
											value="true"">Đang bán</option>
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
					<a href='<c:url value="/admin/stores/${storeId }/books/add"/>' class="btn btn-secondary"><i class="fa-solid fa-plus"></i> New</a>
					<a href='<c:url value="/admin/stores/${storeId }/books"/>' class="btn btn-success"><i class="fas fa-bars"></i> List Books</a>
					<button class="btn btn-primary" type="submit" ><i class="fas fa-save"></i>
						<c:if test="${book.isEdit }">
						<span>Update</span>
						</c:if>
						<c:if test="${!book.isEdit }">
						<span>Save</span>
						</c:if>	
					</button>
				</div>
			</form>
		</div>
	</section>
</body>
</html>