$(function(){
	let message_socket;	//웹소캣 식별자
	/*================
	*	채팅하기
	*=================*/
	//채팅 데이터 읽기
	function selectMsg(){
		
	}
	//메시지 입력 후 enter 이벤트 처리
	$('#message').keydown(function(event){
		if(event.keyCode == 13 && !event.shiftKey){
			$('#detail_form').trigger('submit');
		}
	});
	//채팅 메시지 등록
	$('#detail_form').submit(function(event){
		if($('#useC_txt').val().trim()==''){
			alert('메시지를 입력하세요');
			$('#useC_txt').val('').focus();
			return false;
		}
		if($('#useC_txt').val().length>1333){
			alert('메시지를 1333자까지만 입력 가능합니다');
			return false;
		}
		//입력한 데이터 읽기
		let form_data = $(this).serialize();
		//서버와 통신
		$.ajax({
			url:'../used/usedChatWrite',
			type:'post',
			data:form_data,
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인해야 작성할 수 있습니다.');
				}else if(param.result == 'success'){
					//폼초기화
					$('#useC_txt').val('').focus();
					selectMsg();
				}else{
					alert('채팅 메시지 등록 오류발생');
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		});//end of ajax
		//기본 이벤트 제거
		event.preventDefault();
	});//end of 채팅 메시지 등록
	//채팅 데이터 읽기	
	/*function selectMsg(){
		$.ajax({
			url:'../used/usedChatDetailAjax',
			type:'get',
			data:{talkroom_num:$('#talkroom_num').val()},
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인 후 사용하세요!');
					message_socket.close();
				}else if(param.result == 'success'){
						
					//메시지 표시 UI 초기화	
					$('#chatting_message').empty();
					
					let chat_date='';	
					$(param.list).each(function(index,item){
						let output = '';
						//날짜 추출
						if(chat_date != item.chat_date.split(' ')[0]){
							chat_date = item.chat_date.split(' ')[0];
							output += '<div class="date-position"><span>'+chat_date+'</span></div>';
						}
						
						if(item.message.indexOf('@{member}@')>=0){//멤버등록/탈퇴 메시지 처리
							//신규, 탈퇴 회원 메시지
							output += '<div class="member-message">';
							output += item.message.substring(0,item.message.indexOf('@{member}@'));
							output += '</div>';
						}else{
							//멤버등록/탈퇴 메시지가 아닌 일반 메시지
							if(item.mem_num == param.user_num){
								output += '<div class="from-position">'+item.id;
								output += '<div>';
							}else{	
								output += '<div class="to-position">';
								output += '<div class="space-photo">';
								output += '<img src="../member/viewProfile?mem_num='+ item.mem_num +'" width="40" height="40" class="my-photo">';
								output += '</div><div class="space-message">';
								output += item.id;
							}
							output += '<div class="item">';
							output += item.read_count + ' <span>' + item.message.replace(/\r\n/g,'<br>').replace(/\r/g,'<br>').replace(/\n/g,'<br>') + '</span>';
							//시간 추출
							output += '<div class="align-right">' + item.chat_date.split(' ')[1] + '</div>';
							output += '</div>';
							output += '</div><div class="space-clear"></div>';
							output += '</div>';
						}
						
						//문서 객체에 추가
						$('#chatting_message').append(output);
						//스크롤을 하단에 위치시킴
						$('#chatting_message').scrollTop($("#chatting_message")[0].scrollHeight);
					});	
				}else{
					alert('채팅 메시지 읽기 오류 발생');	
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		});	
	}*/
	selectMsg();
});















