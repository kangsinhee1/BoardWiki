<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<!-- 채팅 메시지 처리 시작 -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/message.chat.js"></script>
	<!-- Page top section -->
<section class="page-top-section set-bg" data-setbg="/img/page-top-bg/4.jpg">
	<div class="page-info">
		<h2>모임 신청</h2>
		<div class="site-breadcrumb">
			<a href="">Home</a>  /
			<span>모임신청</span> /
			<span><a href="myTeam2"> 내 모임 보기</a></span>
		</div>
	</div>
</section>
<!-- Page top end-->
<section class="blog-page">
<div class="container">
	<div class="row">
		<div class="col-lg-12">
<div id="talkDetail" class="page-main">
	<h2 id="chatroom_title"><span id="chatroom_name">${room_name}</span> 채팅방
	</h2> 
	<div class="align-right">
	<c:if test="${team.mem_num == user.mem_num}">
	    <input type="button" value="게시판으로" onclick="location.href='${pageContext.request.contextPath}/team/teamBoardAdmin?tea_num=${team.tea_num}'">
	</c:if>
	
	<c:if test="${team.mem_num!=user.mem_num}">
	    <input type="button" value="게시판으로" onclick="location.href='${pageContext.request.contextPath}/team/teamBoardUser?tea_num=${team.tea_num}'">
	</c:if>
	 <input type="button" value="채팅목록" onclick="location.href='${pageContext.request.contextPath}/myPage/myChat2'">
	</div>    
	<p>
		채팅 멤버 : 
		<span id="chat_member">${chatMember}</span><span id="chat_mcount">(${chatCount}명)</span>
	</p>    
	<div id="chatting_message"></div>
	<form id="detail_form">
		<input type="hidden" name="chaR_num" id="chaR_num" value="${param.chaR_num}">	
	    <textarea rows="5" cols="40" name="message" id="message"></textarea>
		<div id="message_btn">
			<input type="submit" value="전송">
		</div>
	</form>
</div>
</div>
</div>
</div>
</section>
<!-- 채팅 메시지 처리 끝 -->







