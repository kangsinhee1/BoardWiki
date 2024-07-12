
/*----------------------
* 좋아요 등록/삭제
	 *---------------------*/
	$('#output_fav').click(function(){
		//서버와 통신
		$.ajax({
			url:'writeFav',
			type:'post',
			data:{boa_num:$('#output_fav').attr('data-num')},
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인 후 좋아요를 눌러주세요');
				}else if(param.result == 'success'){
					displayFav(param);
				}else{
					alert('좋아요 등록/삭제 오류 발생');
				}				
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		});
	});	