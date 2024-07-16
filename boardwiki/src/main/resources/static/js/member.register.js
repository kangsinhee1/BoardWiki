$(function(){
	/*------------------
	 *       회원가입
	 *------------------*/
	
	//아이디 중복 여부 저장 변수 : 0은 아이디 중복 또는 중복 체크 미실행,
	//                     1은 아이디 미중복
	let checkId = 0;
	
	//아이디 중복 체크
	$('#confirmId').click(function(){
		if($('#mem_email').val().trim()==''){
			$('#message_id').css('color','red').text('아이디를 입력하세요');
			$('#mem_email').val('').focus();
			return;
		}
		
		$('#message_id').text('');//메시지 초기화
		
		//서버와 통신
		$.ajax({
			url:'confirmId',
			type:'get',
			data:{mem_email:$('#mem_email').val()},
			dataType:'json',
			success:function(param){
				if(param.result == 'idNotFound'){
					checkId = 1;
					$('#message_id').css('color','#000')
					                .text('등록 가능한 이메일');
				}else if(param.result == 'idDuplicated'){
					checkId = 0;
					$('#message_id').css('color','red')
					                .text('중복된 이메일');
					$('#id').val('').focus();               
				}else if(param.result == 'notMatchPattern'){
					checkId = 0;
					$('#message_id').css('color','red')
					                .text('이메일 형식에 맞지 않습니다.');
					$('#id').val('').focus();                
				}else{
					checkId = 0;
					alert('이메일 중복 체크 오류');
				}
			},
			error:function(){
				checkId = 0;
				alert('네트워크 오류 발생');
			}
		});
	});//end of click
	
	let checknickName = 0;
	
	//이메일 중복 체크
	$('#confirmNickname').click(function(){
		if($('#mem_nickName').val().trim()==''){
			$('#message_nickName').css('color','red').text('닉네임을 입력하세요');
			$('#mem_nickName').val('').focus();
			return;
		}
		
		$('#message_nickName').text('');//메시지 초기화
		
		//서버와 통신
		$.ajax({
			url:'confirmNickname',
			type:'get',
			data:{mem_nickName:$('#mem_nickName').val()},
			dataType:'json',
			success:function(param){
				if(param.result == 'idNotFound'){
					checkId = 1;
					$('#message_nickName').css('color','#000')
					                .text('등록 가능한 닉네임');
				}else if(param.result == 'idDuplicated'){
					checkId = 0;
					$('#message_nickName').css('color','red')
					                .text('중복된 닉네임');
					$('#mem_nickName').val('').focus();                            
				}else{
					checkId = 0;
					alert('닉네임 중복 체크 오류');
				}
			},
			error:function(){
				checkId = 0;
				alert('네트워크 오류 발생');
			}
		});
	});//end of click
	
	//아이디 중복 안내 메시지 초기화 및 아이디 중복 값 초기화
	$('#member_register #mem_email').keydown(function(){
		checkId=0;
		$('#message_id').text('');			
	});//end of keydown
	
	//submit 이벤트 발생시 아이디 중복 체크 여부 확인
	$('#member_register').submit(function(){
		if(checkId==0){
			$('#message_id').css('color','red')
			                .text('이메일 중복 체크 필수!');
			if($('#mem_email').val().trim()==''){
				$('#mem_email').val('').focus();
			}     
			return false;           
		}
	});//end of submit
	
	//아이디 중복 안내 메시지 초기화 및 아이디 중복 값 초기화
	$('#member_register #mem_nickName').keydown(function(){
		checkId=0;
		$('#message_id').text('');			
	});//end of keydown
	
	//submit 이벤트 발생시 아이디 중복 체크 여부 확인
	$('#member_register').submit(function(){
		if(checkId==0){
			$('#message_nickName').css('color','red')
			                .text('닉네임 중복 체크 필수!');
			if($('#mem_nickName').val().trim()==''){
				$('#mem_nickName').val('').focus();
			}     
			return false;           
		}
	});//end of submit
});






