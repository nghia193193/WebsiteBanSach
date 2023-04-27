<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/css/style.css">
<link rel="stylesheet" href="/css/styleForFooter.css">
<link rel="stylesheet" href="templates/css/storePro.css">
<link
	href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<script
	src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<meta charset="UTF-8">
<title>Your Store</title>
</head>
<body>
	<%@ include file="/common/vendor/header.jsp"%>
	<div>
		<sitemesh:write property='body'></sitemesh:write>
	</div>

	<div>
	<%-- <%@ include file="/common/vendor/footer.jsp"%> --%>
	</div>
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
	<script type="text/javascript">
		function changeEdit() {
			var edit = document.getElementById("StoreEditButton");
			var cancel = document.getElementById("StoreCancelEdit");
			var update = document.getElementById("StoreUpdateButton");

			document.getElementById("storeName").removeAttribute("readonly");
			document.getElementById("storeAvatar").style.display = "block";
			document.getElementById("storeDescription").removeAttribute(
					"readonly");
			document.getElementById("isOpen").removeAttribute("disabled");
			edit.style.display = "none";
			update.style.display = "block";
			cancel.style.display = "block";
		}

		function cancelChange() {
			var edit = document.getElementById("StoreEditButton");
			var cancel = document.getElementById("StoreCancelEdit");
			var update = document.getElementById("StoreUpdateButton");

			document.getElementById("storeName").setAttribute("readonly",
					"readonly");
			document.getElementById("storeAvatar").style.display = "none";
			document.getElementById("storeDescription").setAttribute(
					"readonly", "readonly");
			document.getElementById("isOpen").setAttribute("disabled",
					"disabled");
			document.getElementById("storeName").value = document
					.getElementById("storeName").defaultValue;
			document.getElementById("storeDescription").value = document
					.getElementById("storeDescription").defaultValue;
			;
			edit.style.display = "block";
			update.style.display = "none";
			cancel.style.display = "none";
		}
	</script>
	<script type="text/javascript">
		function cateChart(id, xValues, yValues) {
			const data = {
				labels : yValues,
				datasets : [ {
					label : 'Doanh thu',
					data : xValues,
					fill : false,
					borderColor : 'rgb(75, 192, 192)',
					tension : 0.1
				} ]
			};

			const config = {
				type : 'line',
				data : data,
			};

			let ctx = document.getElementById(id)
			new Chart(ctx, config)
		}

		document.getElementById('today').valueAsDate = new Date();
		document.getElementById('fromday').value = '2022-01-01';

		function updateDate() {
			let date = document.getElementById('today').valueAsDate;
			document.getElementById('today').value = date.toString();
		}
	</script>
	<script>
		//var xValues = [50,60,70,80,90,100,110,120,130,140,150];
		//var yValues = ['7','8','8','9','9','9','10','11','14','14','15'];
		
		let xValues = [], yValues = [];
		<c:forEach items="${listThongKe}" var ="o">
			yValues.push('${o.createAt}');
			xValues.push('${o.total}');
		</c:forEach>
		window.onload = function() {
			cateChart("chartElement", xValues, yValues)
		}
	</script>
</body>
</html>
