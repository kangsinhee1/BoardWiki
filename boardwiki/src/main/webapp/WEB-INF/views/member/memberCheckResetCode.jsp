<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>     
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>    
<!-- 중앙 컨텐츠 시작 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/member.passwd.reset.js"></script>  
<div class="page-main">
	<h2>비밀번호 찾기</h2>
	<div>
		비밀번호를 분실하셨나요?<br>
		가입할 때 사용한 아이디와 이메일를 입력하시면<br>
		이메일로 임시비밀번호를 보내드립니다.<br><br>		
	</div>
	<form id="member_passwdReset">
		<ul>
			<li>
				<label for="mem_email">이메일</label>
				<input type="email" name="mem_email" id="mem_email"/>
				<input type="button" id="sendResetCodebtn" value="인증번호 전송" class="default-btn">
			</li>
			<li id="insertResetCodeForm" style="display:none;">
				<label for="resetCode">인증번호</label>
				<input type="text" name="resetCode" id="resetCode"/>
				<input type="button" id="checkResetCodebtn" value="인증번호 확인" class="default-btn">
			</li>
		</ul>
		<div class="align-center">
			<input type="submit" value="전송">
			<input type="button" value="홈으로" onclick="location.href='${pageContext.request.contextPath}/main/main'">
		</div>
		<div id="loading" style="display:none;">
			<img src="${pageContext.request.contextPath}/images/loading.gif">
		</div>
	</form>
</div>