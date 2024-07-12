<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<!-- 회원로그인 시작 -->
<div class="page-main">
	<h2>회원로그인</h2>
	<form:form action="login" id="member_login"
	                            modelAttribute="memberVO">
	    <form:errors element="div" cssClass="error-color"/>
		<ul>
			<li class="floating-label">
				<form:input path="mem_email" placeholder="이메일"
				                             autocomplete="off" cssClass="form-input"/>
				<form:label path="mem_email">이메일</form:label>
				<form:errors path="mem_email" cssClass="error-color"/> 
			</li>
			<li class="floating-label">
				<form:password path="mem_passwd" placeholder="비밀번호" cssClass="form-input"/>
				<form:label path="mem_passwd">비밀번호</form:label>
				<form:errors path="mem_passwd" cssClass="error-color"/>
			</li>
			<li>
				<label for="auto"><input type="checkbox" name="auto" id="auto">로그인상태유지</label>
			</li>
		</ul>
		<div>
			<form:button class="login-btn">로그인</form:button>
		</div>     
		<div class="login_hr">
			<hr>
		</div>
		<div class="button_group">
			<div>
			<img src="${pageContext.request.contextPath}/images/naverbanner.png" 
								onclick="location.href='/member/login/naver'" height="32" width="300">
			</div>
			<div>			
			<img src="${pageContext.request.contextPath}/images/kakaobanner.png" 
								onclick="location.href='/member/login/kakao'" height="32" width="300">
			</div>
			<div>
			<img src="${pageContext.request.contextPath}/images/googlebanner.png" 
								onclick="location.href='/member/login/google'" height="32" width="300">
			</div>
		</div>
	</form:form>
	<p class="align-center">
		<input type="button" value="홈으로"
			  class="default-btn"
			  onclick="location.href='${pageContext.request.contextPath}/main/main'">
		<input type="button" value="비밀번호찾기" class="default-btn"
					onclick="location.href='sendPassword'">
	</p>
</div>
<!-- 회원로그인 끝 -->





