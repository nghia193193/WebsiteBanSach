<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Đăng ký bán hàng</title>
</head>
<body>
	<form action="storeregister" method="post" enctype="multipart/form-data">
			<p>Tên Shop</p>
	
            <div>
                <input id="name" name="storeName" type="text" placeholder="Tên cửa hàng..."/>
                <form:errors path="storeName"/>
			</div>
			
			<img id="image" alt="" src="/templates/images/nostoreavatar.png"
				style="width: 60px;">
			<p>Ảnh đại diện của cửa hàng: </p>
			<div>
				<input type="file" name="avatarFile" onchange="chooseFile(this)"/>
			</div>

			<label for="storeDescription">Mô tả:</label>
		    <textarea id="storeDescription" name="description" placeholder="Mô tả về cửa hàng..."></textarea>
		    <form:errors path="description"/>
                       


		<label class="content_content_form_text">Danh mục sản phẩm</label> 
	<div class="content_content_btn">
		<button type="submit">Đăng kí</button>
	</div>
</form>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
	<script type="text/javascript">
		function chooseFile(fileInput) {
			if (fileInput.files && fileInput.files[0]) {
				var reader = new FileReader();
				reader.onload = function(e) {
					$('#image').attr('src', e.target.result);
				}
				reader.readAsDataURL(fileInput.files[0]);
			}
		}
	</script>
</body>
</html>