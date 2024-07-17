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