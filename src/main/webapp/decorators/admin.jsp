<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>UTE bookstore admin</title>
<link href="/templates/css/adminstyle.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css" rel="stylesheet">

</head>
<body>
	<div id="main-wrapper">
		<!-- header  -->
		<%@ include file="/common/admin/header.jsp" %>
		<!-- end header  -->
		
		<!-- sidebar  -->
		<%@ include file="/common/admin/sidebar.jsp" %>
		<!-- end sidebar -->
		
		<!-- 	content -->
		<div class="content-body">
			<sitemesh:write property='body'></sitemesh:write>
		</div>
		<!-- end content -->
	</div>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
	<script src="/templates/js/global.min.js"></script>
    <script src="/templates/js/quixnav-init.js"></script>
    <script src="/templates/js/custom.min.js"></script>
</body>
</html>