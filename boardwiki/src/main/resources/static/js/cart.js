/*----------------------
*
*---------------------*/
	$('#cart_button').click(function(){
		//서버와 통신
		$.ajax({
			url:'writecart',
			type:'post',
			data:{mem_num:$('#cart_button').attr('data-num')},
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인 후 장바구니에 담아주세요');
				}else if(param.result == 'success'){
					displayFav(param);
				}else{
					alert('장바구니 담기 오류 발생');
				}				
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		});
	});	