<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>
<c:if test="${success==true}">
	<h1>Cập nhật thành công</h1>
</c:if>
<h1 class="text-center">Thông tin của shop</h1>

<div class="container-xl px-4 mt-4">
	<!-- Account page navigation-->
	<hr class="mt-0 mb-4">
	<div class="row">
		<div class="col-xl-4">
			<!-- Profile picture card-->
			<div class="card mb-4 mb-xl-0">
				<div class="card-header">Profile Picture</div>
				<div class="card-body text-center">
					<!-- Profile picture image-->
					<!-- <img class="img-account-profile rounded-circle mb-2"
						src="http://bootdey.com/img/Content/avatar/avatar1.png" alt=""> -->
					<!-- Profile picture help block-->
					<!-- <div class="small font-italic text-muted mb-4">JPG or PNG no
						larger than 5 MB</div>
					Profile picture upload button
					<button class="btn btn-primary" type="button">Upload new
						image</button> -->

					<c:if test="${store.avatar != null}">
						<img id="image" alt="" src="${store.avatar}" style="width: 100px;">
					</c:if>
					<c:if test="${store.avatar == null}">
						<img id="image" alt="" src="/templates/images/nostoreavatar.png"
							style="width: 100px;">
					</c:if>
					<div class="container">
						<div class="row">
							<div class="col text-center">
								<input class="btn btn-primary" id="storeAvatar" type="file"
									name="avatarFile" onchange="chooseFile(this)"
									style="display: none;" />
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="col-xl-8">
			<!-- Account details card-->
			<div class="card mb-4">
				<div class="card-header">Account Details</div>
				<div class="card-body">
					<form>
						<!-- Form Group (username)-->
						<div class="mb-3">
							<!-- <label class="small mb-1" for="inputUsername">Username (how your name will appear to other users on the site)</label>
                            <input class="form-control" id="inputUsername" type="text" placeholder="Enter your username" value="username">
                        	 -->
							<label class="small mb-1" for="storeName">Tên của cửa
								hàng:</label> <input class="form-control" id="storeName"
								name="storeName" type="text" placeholder="Tên cửa hàng..."
								value="${store.storeName}" readonly="readonly" />
							<form:errors path="storeName" />
						</div>
						<!-- Form Row-->
						<div class="row gx-3 mb-3">
							<!-- Form Group (first name)-->
							<label class="small mb-1" for="storeDescription">Mô tả:</label>
							<textarea id="storeDescription" name="description"
								placeholder="Mô tả về cửa hàng..." readonly="readonly"
								class="form-control">${store.description}</textarea>
							<form:errors path="description" />
							<!-- Form Group (last name)-->
						</div>
						<!-- Form Row        -->
						<div class="row gx-3 mb-3">
							<!-- Form Group (organization name)-->
							<label class="small mb-1" for="isOpen">Trạng thái cửa
								hàng:</label> <select name="open" id="isOpen" disabled="disabled"
								class="form-control">
								<option ${store.open==true?'selected':''} value="1">Mở
									cửa</option>
								<option ${store.open==false?'selected':''} value="0">Đóng
									cửa</option>
							</select>
							<!-- Form Group (location)-->
							<!-- Save changes button-->
							<p>&nbsp;</p>
							<input class="btn btn-primary" id="StoreEditButton"
								type="button" onclick="changeEdit()" value="Chỉnh sửa"
								style="display: block;" /> <input class="btn btn-light"
								id="StoreUpdateButton" type="submit" value="Cập nhật"
								style="display: none;" /> <input class="btn btn-dark"
								id="StoreCancelEdit" type="button" onclick="cancelChange()"
								value="Hủy" style="display: none;" />
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>

<%-- 

<form action="storeprofile" method="post" enctype="multipart/form-data">
	<div>
		<label for="storeName">Tên của cửa hàng:</label> <input id="storeName"
			name="storeName" type="text" placeholder="Tên cửa hàng..."
			value="${store.storeName}" readonly="readonly" />
		<form:errors path="storeName" />
	</div>
	<div>
		<label for="storeAvatar">Ảnh đại diện của cửa hàng:</label>
		<c:if test="${store.avatar != null}">
			<img id="image" alt="" src="${store.avatar}" style="width: 100px;">
		</c:if>
		<c:if test="${store.avatar == null}">
			<img id="image" alt="" src="/templates/images/nostoreavatar.png"
				style="width: 100px;">
		</c:if>
		<input id="storeAvatar" type="file" name="avatarFile"
			onchange="chooseFile(this)" style="display: none;" />
	</div>
	<div>
		<label for="storeDescription">Mô tả:</label>
		<textarea id="storeDescription" name="description"
			placeholder="Mô tả về cửa hàng..." readonly="readonly">${store.description}</textarea>
		<form:errors path="description" />
	</div>
	<div>
		<label for="isOpen">Trạng thái cửa hàng:</label> <select name="open"
			id="isOpen" disabled="disabled">
			<option ${store.open==true?'selected':''} value="1">Mở cửa</option>
			<option ${store.open==false?'selected':''} value="0">Đóng
				cửa</option>
		</select>
	</div>
	<input id="StoreEditButton" type="button" onclick="changeEdit()"
		value="Chỉnh sửa" style="display: block;" /> <input
		id="StoreUpdateButton" type="submit" value="Cập nhật"
		style="display: none;" /> <input id="StoreCancelEdit" type="button"
		onclick="cancelChange()" value="Hủy" style="display: none;" />
</form> --%>