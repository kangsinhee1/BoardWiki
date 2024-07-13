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
	
	/* ========================================================================
	 * 댓글 등록
	 * ======================================================================== */
	//댓글 등록
	$('#re_form').submit(function(event){
		if($('#re_content').val().trim()==''){
			alert('내용을 입력하세요');
			$('#re_content').val('').focus();
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
				if(param.result=='logout'){
					alert('로그인해야 작성할 수 있습니다.');
				}else if(param.result=='success'){
					//폼 초기화
					initForm();
					//댓글 작성이 성공하면 새로 삽입한 글을
					//포함해서 첫번째 페이지의 게시글들을 다시
					//호출함
					selectList(1);
				}else{
					alert('댓글 등록 오류 발생!');
				}
			},
			error:function(){
				alert('네트워크 오류!');
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