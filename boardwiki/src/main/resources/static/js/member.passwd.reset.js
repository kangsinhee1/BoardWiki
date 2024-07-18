$(function() {
	/*--------------------
	*	   인증번호 발송
	----------------------*/
	$('#sendResetCodebtn').click(function(event){
		if($('#mem_email').val().trim()==''){
			alert('이메일을 입력 하세요')
			$('#mem_email	').val('').focus();
			return false;
		}
		var mem_email = $('#mem_email').val();
		 
		//서버와 통신
		$.ajax({
			url:'getSendResetCode',
			type:'post',
			data:{mem_email:$('#mem_email').val()},
			dataType:'json',
			beforSend:function(){
				$('#loading').show()//표시
			},
			complete:function(){
				$('#loading').hide();//숨김
			},
			success:function(param) {
				if(param.result == 'invalidInfo') {
					alert('아이디 또는 이메일 불일치');
				}else if(param.result == 'noAuthority'){
					alert('정지 회원입니다.');
				}else if(param.result == 'notMatchProvider'){
					alert('소셜 로그인 계정은 비밀번호 초기화가 불가합니다 소셜 로그인을 이용해주세요.');
				}else if(param.result == 'success') {
					alert('이메일로 인증번호가 발송되었습니다.');
					$('#insertResetCodeForm').show(); // 인증번호 입력 폼 보이기
				}else {
					alert('비밀번호 찾기 오류 발생')
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		});
		//기본 이벤트 제거
		event.preventDefault();
	});
	/*--------------------
	*	   인증번호 체크
	----------------------*/
	$('#checkResetCodebtn').click(function(event){
		if($('#resetCode').val().trim()==''){
			alert('인증번호를 입력 하세요')
			$('#resetCode').val('').focus();
			return false;
		}
		var mem_email = $('#mem_email').val();
		 
		//서버와 통신
		$.ajax({
			url:'getSendResetCode',
			type:'post',
			data:{mem_email:$('#mem_email').val()},
			dataType:'json',
			beforSend:function(){
				$('#loading').show()//표시
			},
			complete:function(){
				$('#loading').hide();//숨김
			},
			success:function(param) {
				if(param.result == 'invalidInfo') {
					alert('아이디 또는 이메일 불일치');
				}else if(param.result == 'noAuthority'){
					alert('정지 회원입니다.');
				}else if(param.result == 'notMatchProvider'){
					alert('소셜 로그인 계정은 비밀번호 초기화가 불가합니다 소셜 로그인을 이용해주세요.');
				}else if(param.result == 'success') {
					alert('이메일로 인증번호가 발송되었습니다.');
					$('#insertResetCodeForm').show(); // 인증번호 입력 폼 보이기
				}else {
					alert('비밀번호 찾기 오류 발생')
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		});
		//기본 이벤트 제거
		event.preventDefault();
	});
});