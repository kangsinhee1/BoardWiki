/*----------------------
*
*---------------------*/
//$.ajax({
//    type: "POST",
//    url: "/item/addToCart",
//    data: {
//        item_num: itemNum,
//        item_quantity: itemQuantity
//    },
//    success: function(response) {
//        console.log(response); // 응답 확인
//        if (response.result === "success") {
//            alert("Item added to cart successfully!");
//        } else if (response.result === "overquantity") {
//            alert("Quantity exceeds stock!");
//        } else if (response.result === "noitem") {
//            alert("Item does not exist!");
//        } else if (response.result === "logout") {
//            alert("You need to log in first!");
//        }
//    },
//    error: function(xhr, status, error) {
//        console.error("AJAX error:", status, error);
//    }
//});

$(function(){
	$('#deleteX').click(function(){
		const mem_num = $('#mem_num').val();
	const item_num = $('#item_num').val();
	$.ajax({
		url:"/cart/delete",
		type:"GET",
		dataType:"json",
		data:{
			mem_num: mem_num,
			item_num: item_num
		},
		success: function(){
			alert('품목이 삭제되었습니다');
			
		},
		error: function(){
			
		}

	});
	location.reload();
  });
});

$(document).ready(function() {
    function updateTotalSum() {
        var totalSum = 0;
        $('.total-price').each(function() {
            var priceText = $(this).text().replace('원', '').trim();
            var price = parseInt(priceText);
            totalSum += price;
        });
        $('#total_sum_value').text(totalSum);
    }

    updateTotalSum(); // Initialize total sum on page load

    $('.quantity').on('change', function() {
        var itemNum = $(this).data('item-num');
        var quantity = $(this).val();
        
        $.ajax({
            type: 'POST',
            url: '/cart/cart',
            dataType:'json',
            data: {
                item_num: itemNum,
                item_quantity: quantity
            },
            success: function(response) {
                if(response.result === 'success') {
                    var itemPrice = $('#item_price_' + itemNum).data('price');
                    var totalPrice = quantity * itemPrice;
                    $('#total_price_' + itemNum).text(totalPrice + '원');
                    updateTotalSum();
                } else if(response.result === 'overquantity') {
                    alert('재고 수량을 초과했습니다.');
                } else if(response.result === 'noitem') {
                    alert('상품이 존재하지 않습니다.');
                }
            },
            error: function() {
                alert('오류가 발생했습니다.');
            }
        });
    });
});