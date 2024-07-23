$(function(){
	$('.change_auth').submit(function(event){
		
		let form_data= $(this).serialize();
		//서버와 통신
		$.ajax({
			url:'changeAuth',
			type:'post',
			data:form_data,
			dataType:'json',
			success:function(param){
				if(param.result == 'error'){
					alert('에러');
				}else if(param.result == 'success'){
					alert('등급 수정 완료!');
				}else{
					alert('등급 수정 오류 발생');
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		});
		event.preventDefault();
	});
});