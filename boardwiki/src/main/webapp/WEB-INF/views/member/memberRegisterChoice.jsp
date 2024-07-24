<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 회원로그인 시작 -->

		<!-- Page top section -->
	<section class="page-top-section set-bg" data-setbg="/img/page-top-bg/4.jpg">
		<div class="page-info">
			<h2>Contact</h2>
			<div class="site-breadcrumb">
				<a href="">Home</a>  /
				<span>Contact</span>
			</div>
		</div>
	</section>
	<!-- Page top end-->

	<!-- Page top section -->
	<section class="page-top-section set-bg" data-setbg="/img/page-top-bg/4.jpg">
		<div class="page-info">
			<h2>회원가입</h2>
			<div class="site-breadcrumb">
				<a href="">Home</a>  /
				<span>Contact</span>
			</div>
		</div>
	</section>
	<!-- Page top end-->
	
<section class="contact-page">
		<div class="container">
		<div class="align-center">

<div class="page-main">
	<!-- <h2>회원가입 플랫폼 선택</h2> -->
	<form:form action="memberRegisterChoice" id="memberregister"
	                            modelAttribute="memberVO">
	    <div>
	    	<%-- <a href="${pageContext.request.contextPath}/member/memberRegister">보드위키</a> --%>
	    </div>
	    <div class="register_hr">
			<hr>
		</div>
			<div class="button_group">
				<div>
					<img src="/img/favicon.ico"
						onclick="location.href='${pageContext.request.contextPath}/member/memberRegister'" height="50"
						width="50">
				</div>
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
					<img src="${pageContext.request.contextPath}/images/Google.png"
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


