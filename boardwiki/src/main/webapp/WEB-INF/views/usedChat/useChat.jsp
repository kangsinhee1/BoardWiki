<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/usedChat.js"></script>
<!-- 채팅 메시지 처리 시작 -->
<div id="usedChat" class="page-main">
	<h3 id="chatroom_title"><span id="useC_name">${useC_name}</span> 채팅방</h3> 
	<div class="align-right">
</div>  
	<div id="chatting_message"></div>
	<form id="detail_form">
		<input type="hidden" name="useC_num" id="useC_num" value="${useC_num}">	
		<input type="hidden" name="use_num" id="use_num" value="${use_num}">	
	    <textarea rows="5" cols="40" name="chaC_txt" id="chaC_txt"></textarea>
		<div id="message_btn">
			<input type="submit" value="전송">
		</div>
	</form>
</div>
<!-- 채팅 메시지 처리 끝 -->