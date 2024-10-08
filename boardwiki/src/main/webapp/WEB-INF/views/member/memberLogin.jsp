<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!-- 회원로그인 시작 -->

		<!-- Page top section -->
	<section class="page-top-section set-bg" data-setbg="/img/page-top-bg/4.jpg">
		<div class="page-info">
			<h2>로그인</h2>
			<div class="site-breadcrumb">
				<a href="/main/main">Home</a>  /
				<span>Login</span>
			</div>
		</div>
	</section>
	<!-- Page top end-->


	<section class="contact-page">
		<div class="container">
		<div class="align-center">
<div class="page-main">
	<h2 class="register-h2">로그인</h2>
	

	<form:form action="login" id="member_login" modelAttribute="memberVO">
		<form:errors element="div" cssClass="error-color" />
		<ul>
			<li class="floating-label"><form:input path="mem_email"
					placeholder="이메일" autocomplete="off" cssClass="form-input" /> <form:label
					path="mem_email">이메일</form:label></li>
			<li class="floating-label"><form:password path="mem_passwd"
					placeholder="비밀번호" cssClass="form-input" /> <form:label
					path="mem_passwd">비밀번호</form:label></li>
			<li>
				<label for="auto"><input type="checkbox" name="auto" id="auto">로그인상태유지</label>
			</li>
			
		</ul>
		<div class="align-center">
			<form:button class="login-btn">로그인</form:button>
		</div>
		<p class="align-center font-white">
			<a onclick="location.href='memberRegister'">간편회원가입 | </a>
			<a onclick="location.href='memberFindEmail'">이메일 찾기 | </a>
			<a onclick="location.href='sendResetCode'">비밀번호 찾기</a>
		</p>
			<hr>
			<div class="button_group">
				<div>
					<img src="${pageContext.request.contextPath}/images/Naver.png"
						onclick="location.href='/member/login/naver'" height="50"
						width="50">
				</div>
				<div>
					<img src="${pageContext.request.contextPath}/images/Kakao.png"
						onclick="location.href='/member/login/kakao'" height="50"
						width="50">
				</div>
				<div>
					<img
						src="${pageContext.request.contextPath}/images/Google.png"
						onclick="location.href='/member/login/google'" height="50"
						width="50">
				</div>
			</div>
	</form:form>
</div>
</div>
</div>

</section>

<!-- 회원로그인 끝 -->





