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
}