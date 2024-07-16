<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 비밀번호 재설정 -->
<div class="page-main">
	<h2>비밀번호 재설정</h2>
	<form:form action="forgotPasswd" id="member_register"
	                            modelAttribute="memberVO">
		<ul>
			<li>
				<form:label path="mem_newPasswd">새 비밀번호</form:label>
				<form:input path="mem_email" placeholder="영문,숫자만 4~12자"
				                             autocomplete="off"/>
				<input type="button" id="confirmId" value="이메일중복체크"
				                                 class="default-btn">                  
				<span id="message_id"></span>
				<form:errors path="mem_email" cssClass="error-color"/>                             
			</li>
			<li>
				<form:label path="mem_name">새 비밀번호 확인</form:label>
				<form:input path="mem_name"/>
				<form:errors path="mem_name" cssClass="error-color"/>
			</li>
			
		</ul> 
		<div class="align-center">
			<form:button class="default-btn">전송</form:button>
		</div>                           
	</form:form>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
</div>
<!-- 비밀번호 재설정 끝 -->




