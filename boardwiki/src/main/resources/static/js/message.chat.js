$(function(){
	let message_socket;
	connectWebSocket();//웹소켓 생성
	/*------------------------------------
		웹소켓 연결
	------------------------------------*/
	function connectWebSocket(){
		message_socket = new WebSocket('ws://192.168.10.85:8000/message-ws');//포트 맞추기 (이번경우는 8000)
		message_socket.onopen=function(evt){
			console.log('채팅 페이지 접속' + $('#talkDetail').length);
			if($('#talkDetail').length ==1){
				message_socket.send('msg'); //message_socket.send("msg:안녕하세요"); 데이터 베이스 안쓸경우 원하는 메시지 모두에게 전송, 
											//이후 구별위한 용도(ex) msg:1, msg:2 (관리자용, 회원용 등)
			}
		};
		//서버로부터 메시지를 받으면 호출되는 함수 지정
		message_socket.onmessage=function(evt){
			//메시지 읽기
			let data = evt.data;
			if($('#talkDetail').length==1 && data.substring(0,3)=='msg'){ // 구별식별자 구하기 위해 substring 사용
			}
			selectMsg();
		};
		message_socket.onclose=function(evt){
			//소켓이 종료된 후 부가적인 작성일 있을경우 명시
			console.log('chat close');
		}
	};
	//채팅 데이터 읽기	
	function selectMsg(){
		$.ajax({
			url:'../chat/chatDetailAjax',
			type:'get',
			data:{chaR_num:$('#chaR_num').val()},
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
						if(chat_date != item.chaT_time.split(' ')[0]){
							chat_date = item.chaT_time.split(' ')[0];
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
								output += '<div class="from-position">'+item.mem_nickname;
								output += '<div>';
							}else{	
								output += '<div class="to-position">';
								output += '<div class="space-message">';
								output += item.mem_nickname;
							}
							output += '<div class="item">';
							output += item.chaT_cnt+ ' <span>' + item.message.replace(/\r\n/g,'<br>').replace(/\r/g,'<br>').replace(/\n/g,'<br>') + '</span>';
							//시간 추출
							output += '<div class="align-right">' + item.chaT_time.split(' ')[1] + '</div>';
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
					message_socket.close();
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
				message_socket.close();
			}
		});	
	}
	

	//채팅 메시지 등록
	$('#detail_form').submit(function(event){
			//기본 이벤트 제거
		event.preventDefault();
		if($('#message').val().trim()==''){
			alert('메시지 입력');
			$('#message').val('').focus();
			return false;
		}
		if($('#message').val().length>1333){
			alert('메시지는 1333자 까지만 입력 가능합니다.');
			return false;
		}
	let form_data = $(this).serialize();
	console.log(form_data);
	$.ajax({
		url:'/chat/writeChat',
		type:'post',
		data:form_data,
		dataType:'json',
		success:function(param){
			if(param.result == 'logout'){
				alert('로그인해야 작성 할 수 있습니다.');
				message_socket.close();
			}else if(param.result == 'success'){
				//폼 초기화
				$('#message').val('').focus();
				message_socket.send('msg');
			}else{
				alert('채팅메시지 오류 발생');
				message_socket.close();
			}
		},
		error:function(){
			alert('네트 워크 오류 발생')
		}
	}); //end of ajax

	});
		$('#message').keydown(function(event){
		if(event.keyCode ==13 && !event.shiftKey){
			//트리거를 이용해서 엔터 누르게 되면 submit 처리
			$('#detail_form').trigger('submit');
		}
	});
});