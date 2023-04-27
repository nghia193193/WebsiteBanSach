<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>
<h1>Shopping Cart</h1>
<div class="row m-1">
	<div class="col-sm-8">
		<c:forEach items="${cartItems}" var="item">
			<div class="row border rounded">
				<div class="col-1">
					<div>${item.id}</div>
					<div>
						<a href="/cart/remove/${item.id}">Remove</a>
					</div>
				</div>
				<div class="col-2">
					<img alt="" src="${item.book.image}" class="img-fluid">
				</div>
				<div class="col-3">
					<a><b>
							<div>${item.book.bookName}</div>
					</b> </a>
				</div>
				<div>
					<%-- <input type="number" value="${item.count}"> --%>
					<p>${item.count}</p>
				</div>
				<div>
					<span> X</span> <span>${item.book.promotionalPrice}</span>
				</div>
				<div></div>
			</div>
			<div class="row m-1">&nbsp;</div>
		</c:forEach>
		<div class="col"></div>
	</div>
	<div class="col-sm-4">
		<div class="mt-2">
			<a href="/cart/checkout">
				<button class="btn btn-danger p-3 mt-2 ">Check out</button>
			</a>
		</div>
	</div>
</div>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script>$(document).ready(function() {
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

function updateQuantity(){
    
}

function updateTotal() {
    total = 0.0;
    $(".productSubtotal").each(function (index, element) {
        total = total + parseFloat(element.innerHTML);
    });
    $("#totalAmount").text(total);
}</script>