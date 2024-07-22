$(function(){
	$('#chaC_txt').focus();
	let message_socket;	//웹소캣 식별자
	/*------------------------------------
		웹소켓 연결
	------------------------------------*/
	function connectWebSocket(){
		message_socket = new WebSocket('ws://192.168.10.92:8000/message-ws');//포트 맞추기 (이번경우는 8000)
		message_socket.onopen=function(evt){
			console.log('채팅 페이지 접속' + $('#usedChat').length);
			if($('#usedChat').length ==1){
				message_socket.send('msg'); //message_socket.send("msg:안녕하세요"); 데이터 베이스 안쓸경우 원하는 메시지 모두에게 전송, 
											//이후 구별위한 용도(ex) msg:1, msg:2 (관리자용, 회원용 등)
			}
		};
		//서버로부터 메시지를 받으면 호출되는 함수 지정
		message_socket.onmessage=function(evt){
			//메시지 읽기
			let data = evt.data;
			if($('#usedChat').length==1 && data.substring(0,3)=='msg'){ // 구별식별자 구하기 위해 substring 사용
				selectMsg();
			}
		};
		message_socket.onclose=function(evt){
			//소켓이 종료된 후 부가적인 작성일 있을경우 명시
			console.log('chat close');
		}
	};
	connectWebSocket();
	/*================
	*	채팅하기
	*=================*/
	
	//메시지 입력 후 enter 이벤트 처리
	$('#chaC_txt').keydown(function(event){
		if(event.keyCode == 13 && !event.shiftKey){
			$('#detail_form').trigger('submit');
		}
	});
	//채팅 메시지 등록
	$('#detail_form').submit(function(event){
		if($('#chaC_txt').val().trim()==''){
			alert('메시지를 입력하세요');
			$('#chaC_txt').val('').focus();
			return false;
		}
		//입력한 데이터 읽기
		let form_data = $(this).serialize();
		console.log(form_data);
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
					$('#chaC_txt').val('').focus();
					console.log(form_data);
					message_socket.send('msg');
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
	
	function selectMsg(){
		$.ajax({
			url:'../used/usedChatDetailAjax',
			type:'get',
			data:{useC_num:$('#useC_num').val()},
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인 후 사용하세요!');
					message_socket.close();
				}else if(param.result == 'success'){
						
					//메시지 표시 UI 초기화	
					$('#chatting_message').empty();
					
					let chat_time='';	
					$(param.list).each(function(index,item){
						let output = '';
						//날짜 추출
						if(chat_time != item.chaC_time.split(' ')[0]){
							chat_time = item.chaC_time.split(' ')[0];
							output += '<div class="date-position"><span>'+chat_time+'</span></div>';
						}
						
						if(item.mem_num == param.user_num){
							output += '<div class="from-position">'+item.mem_nickname;
							output += '<div>';
						}else{	
							output += '<div class="to-position">';
							output += '<div class="space-photo">';
							output += item.mem_num
							output += '</div><div class="space-message">';
							output += item.mem_nickname;
						}
						output += '<div class="item">';
						output += ' <span>' + item.chaC_txt.replace(/\r\n/g,'<br>').replace(/\r/g,'<br>').replace(/\n/g,'<br>') + '</span>';
						//시간 추출
						output += '<div class="align-right">' + item.chaC_time.split(' ')[1] + ' </div>';
						output += '</div>';
						output += '</div><div class="space-clear"></div>';
						output += '</div>';
						
						
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
	}
	// 1초마다 selectMsg 함수 호출
    //setInterval(selectMsg, 500);
    
});















