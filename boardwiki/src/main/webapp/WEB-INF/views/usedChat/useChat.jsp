<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<!-- 채팅 메시지 처리 시작 -->
<section class="page-top-section set-bg" data-setbg="/img/page-top-bg/4.jpg">
		<div class="page-info">
			<h2>1:1 채팅</h2>
			<div class="site-breadcrumb">
				<a href="">Home</a>  /
				<span>Contact</span>
			</div>
		</div>
	</section>
	<!-- Page top end-->

<script src="${pageContext.request.contextPath}/js/usedChat.js"></script>
<section class="blog-page">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
<div class="page-main">
   <div id="usedChat" class="page-main" onloadeddata="selectMsg()">
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
</div>
</div>
</div>
</div>
</section>
<!-- 채팅 메시지 처리 끝 -->