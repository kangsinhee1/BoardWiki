<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 비밀번호 변경 시작 -->
<div class="page-main">
	<h2>회원탈퇴</h2>
	<form:form action="memberDelete" id="member_change"
	                            modelAttribute="memberVO">
		<form:errors element="div" cssClass="error-color"/>
		<ul>
			<li>
				<form:label path="mem_passwd">비밀번호</form:label>
				<form:password path="mem_passwd"/>
				<form:errors path="mem_passwd" cssClass="error-color"/>
			</li>
			<li>
				<label for="confirm_passwd">비밀번호 확인</label>
				<input type="password" id="confirm_passwd">
				<span id="message_password"></span>
			</li>
		</ul> 
		<div class="align-center">
			<form:button>탈퇴</form:button>
			<input type="button" value="MY페이지"
			             onclick="location.href='/main/main'">
		</div>                           
	</form:form>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/member.delete.js"></script>	
</div>
<!-- 비밀번호 변경 끝 -->












