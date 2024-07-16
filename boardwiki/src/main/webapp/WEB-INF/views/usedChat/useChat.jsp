<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 채팅 메시지 처리 시작 -->
<div id="talkDetail" class="page-main">
	<h1 id="chatroom_title"><span id="chatroom_name">${useC_name}</span> 채팅방</h1> 
	<div class="align-right">
</div>  
	<div id="chatting_message"></div>
	<form id="detail_form">
		<input type="hidden" name="useC_num" id="useC_num" value="${useC_num}">	
		<input type="hidden" name="use_num" id="use_num" value="${use_num}">	
	    <textarea rows="5" cols="40" name="useC_txt" id="useC_txt"></textarea>
		<div id="message_btn">
			<input type="submit" value="전송">
		</div>
	</form>
</div>
<!-- 채팅 메시지 처리 끝 -->