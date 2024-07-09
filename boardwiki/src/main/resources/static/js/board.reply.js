$(function(){
	let rowCount = 10;
	let currentPage;
	let count;
	
	
	/*--------------------
	 * 댓글 등록
	 *--------------------*/
	//댓글 등록
	$('#re_form').submit(function(event){
		if($('#boaR_content').val().trim()==''){
			alert('내용을 입력하세요');
			$('#boaR_content').val('').focus();
			return false;
		}
		
		let form_data = $(this).serialize();
		console.log(form_data);
		
		//서버와 통신
		$.ajax({
			url:'writeReply',
			type:'post',
			data:form_data,
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인해야 작성할 수 있습니다.');
				}else if(param.result == 'success'){
					//폼 초기화
					initForm();
					//댓글 작성시 성공하면 새로 삽입한 글을 포함해서
					//첫번째 페이지의 게시글들을 다시 호출함
					selectList(1);
				}else{
					alert('댓글 등록 오류 발생');
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		});
		
		//기본 이벤트 제거
		event.preventDefault();
	});
	//댓글 작성 폼 초기화
	function initForm(){
		$('textarea').val('');
		$('#re_first .letter-count').text('300/300');
	}
	
	/*--------------------
	 * 댓글 수정
	 *--------------------*/
	//댓글 수정 버튼 클릭시 수정폼 노출
	$(document).on('click','.modify-btn',function(){
		//댓글 번호 
		let re_num = $(this).attr('data-num');
		//댓글 내용
		let re_content = $(this).parent()
		                     .find('p')
		                     .html()
		                     .replace(/<br>/gi,'\r\n');
		                     //g:지정문자열 모두, i:대소문자 무시
		//댓글 수정폼 UI
		let modifyUI = '<form id="mre_form">';
		modifyUI += '<input type="hidden" name="re_num" id="re_num" value="'+re_num+'">'; 
		modifyUI += '<textarea rows="3" cols="50" name="re_content" id="mre_content" class="rep-content">'+re_content+'</textarea>';    
		modifyUI += '<div id="mre_first"><span class="letter-count">300/300</span></div>';
		modifyUI += '<div id="mre_second" class="align-right">'; 
		modifyUI += ' <input type="submit" value="수정">';
		modifyUI += ' <input type="button" value="취소" class="re-reset">';
		modifyUI += '</div>';
		modifyUI += '<hr size="1" noshade width="96%">';
		modifyUI += '</form>';   
		
		//답글이 있는 경우 답글 초기화
		
		//답글이 있는 경우 답글 초기화 
		
		//이전에 이미 수정하는 댓글이 있을 경우 수정 버튼을 클릭하면
		//숨김 sub-item를 환원시키고 수정폼을 초기화함
		initModifyForm();
		//지금 클릭해서 수정하고자 하는 데이터는 감추기
		//(수정 버튼을 감싸고 있는 div)   
		$(this).parent().hide();
		
		//수정폼을 수정하고자하는 데이터가 있는 div에 노출
		$(this).parents('.item').append(modifyUI);
		
		//입력한 글자수 셋팅
		let inputLength = $('#mre_content').val().length;
		let remain = 300 - inputLength;
		remain += '/300';
		
		//문서 객체에 반영
		$('#mre_first .letter-count').text(remain);                
	});
	//수정폼에서 취소 버튼 클릭시 수정폼 초기화
	$(document).on('click','.re-reset',function(){
		initModifyForm();
	});
	
	//댓글 수정폼 초기화
	function initModifyForm(){
		$('.sub-item').show();
		$('#mre_form').remove();
	}
	
	//댓글 수정
	$(document).on('submit','#mre_form',function(event){
		if($('#mre_content').val().trim()==''){
			alert('내용을 입력하세요!');
			$('#mre_content').val().focus();
			return false;
		}
		//폼에 입력한 데이터 반환
		let form_data = $(this).serialize();
		//서버와 통신
		$.ajax({
			url:'updateReply',
			type:'post',
			data:form_data,
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인해야 수정할 수 있습니다.');
				}else if(param.result == 'success'){
					$('#mre_form').parent().find('p')
					             .html($('#mre_content').val()
					                                    .replace(/</g,'&lt;')
					                                    .replace(/>/g,'&gt;')
					                                    .replace(/\r\n/g,'<br>')
					                                    .replace(/\r/g,'<br>')
					                                    .replace(/\n/g,'<br>'));
					//최근 수정일 처리
					$('#mre_form').parent()
					              .find('.modify-date')
					              .text('최근 수정일 : 5초미만'); 
					//수정폼 초기화
					initModifyForm();               
				}else if(param.result == 'wrongAccess'){                                  
					alert('타인의 글은 수정할 수 없습니다.');
				}else{
					alert('댓글 수정 오류 발생');
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
	 * 댓글(답글) 등록, 수정 공통
	 *--------------------*/
	//textarea에 내용 입력시 글자수 체크
	$(document).on('keyup','textarea',function(){
		//입력한 글자수 구하기
		let inputLength = $(this).val().length;
		
		if(inputLength>300){//300자를 넘어선 경우
			$(this).val($(this).val().substring(0,300));
		}else{//300자 이하인 경우
			//남은 글자수 구하기
			let remain = 300 - inputLength;
			remain += '/300';
			if($(this).attr('id')=='re_content'){
				//댓글 등록 폼 글자수
				$('#re_first .letter-count').text(remain);
			}else if($(this).attr('id')=='mre_content'){
				//댓글 수정 폼 글자수
				$('#mre_first .letter-count').text(remain);
			}else if($(this).attr('id')=='resp_content'){
				//답글 등록 폼 글자수
				$('#resp_first .letter-count').text(remain);
			}else{
				//답글 수정 폼 글자수
				$('#mresp_first .letter-count').text(remain);
			}
		}		
	});
	
	/*--------------------
	 * 댓글 삭제
	 *--------------------*/
	$(document).on('click','.delete-btn',function(){
		//댓글 번호
		let re_num = $(this).attr('data-num');
		//서버와 통신
		$.ajax({
			url:'deleteReply',
			type:'post',
			data:{re_num:re_num},
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인해야 삭제할 수 있습니다.');
				}else if(param.result == 'success'){
					alert('삭제 완료!');
					selectList(1);
				}else if(param.result == 'wrongAccess'){
					alert('타인의 글을 삭제할 수 없습니다.');
				}else{
					alert('댓글 삭제 오류 발생');
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		});
	});
	
	/*--------------------
	 * 댓글수 표시
	 *--------------------*/
	function displayReplyCount(count){
		let output;
		if(count>0){
			output = '댓글수('+count+')';
		}else{
			output = '댓글수(0)';
		}
		//문서 객체에 추가
		$('#output_rcount').text(output);
	}
	
	/*--------------------
	 * 댓글 좋아요 등록
	 *--------------------*/
	$(document).on('click','.output_rfav',function(){
		let heart = $(this);
		//서버와 통신
		$.ajax({
			url:'writeReFav',
			type:'post',
			data:{re_num:heart.attr('data-num')},
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인 후 좋아요를 눌러주세요');
				}else if(param.result == 'success'){
					displayFav(param,heart);
				}else{
					alert('댓글 좋아요 등록/삭제 오류');
				}
			}
		});
	});
	/*--------------------
	 * 댓글 좋아요 표시
	 *--------------------*/
	function displayFav(param,heart){
		let output;
		if(param.status == 'noFav'){
			output = '../images/heart01.png';
		}else{
			output = '../images/heart02.png';
		}
		//문서 객체에 추가
		heart.attr('src',output);
		heart.parent().find('.output_rfcount')
		              .text(param.count);
	}
	
	/*--------------------
	 * 답글 수정
	 *--------------------*/
	
	/*--------------------
	 * 답글 삭제
	 *--------------------*/
	
	/*--------------------
	 * 초기 데이터 호출
	 *--------------------*/
	selectList(1);
});




