<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/css/style.css">
<link rel="stylesheet" href="/css/styleForFooter.css">
<link
	href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<script
	src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>User</title>
</head>
<body>

	<%@ include file="/common/user/header.jsp"%>
	<sitemesh:write property='body'></sitemesh:write>
	<%@ include file="/common/web/footer.jsp"%>
	<script type="text/javascript">
		$(document).ready(function() {
			$(".minusButton").on("click", function(event) {
				event.preventDefault();
				decreaseQuantity($(this));
			});
			$(".plusButton").on("click", function(event) {
				event.preventDefault();
				increaseQuantity($(this));
			});
			updateTotal();
		});

		function getById(param) {
			let quantity = document.getElementById("quan").value;
			document.getElementById("add").href = '/user/add/' + param + '/'
					+ quantity;
		}

		function decreaseQuantity(link) {
			id = link.attr("pid");
			qtyInput = $("#quantity" + id);
			newQty = parseInt(qtyInput.val()) - 1;
			if (newQty > 0) {
				qtyInput.val(newQty);
				updateQuantity();
			}
		}

		function increaseQuantity(link) {
			id = link.attr("pid");
			qtyInput = $("#quantity" + id);
			newQty = parseInt(qtyInput.val()) + 1;
			if (newQty < 10) {
				qtyInput.val(newQty);
				updateQuantity();
			}
		}

		function updateQuantity() {

		}

		function updateTotal() {
			total = 0.0;
			$(".productSubtotal").each(function(index, element) {
				total = total + parseFloat(element.innerHTML);
			});
			$("#totalAmount").text(total);
		}
	</script>
</body>
</html>
