<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>이메일 결과</title>
</head>
<body>

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
		<section class="blog-page">
<div class="container">
	<div class="row">
<div class="page-main">
    <h2>아이디 찾기 결과</h2>
    <c:if test="${!empty foundProvider}">
    	<p>회원님은 <strong>${foundProvider}</strong>가입 계정입니다 <strong>${foundProvider}</strong>로그인을 이용해주세요</p>
    </c:if>
    <c:if test="${empty foundProvider}">
	    <c:if test="${!empty foundEmail}">
	        <p>회원님의 이메일 주소는 <strong>${foundEmail}</strong> 입니다.</p>
	    </c:if>
    </c:if>
    <c:if test="${!empty error}">
        <p>${error}</p>
    </c:if>
    <div class="align-center">
        <input type="button" value="홈으로"
               class="default-btn"
               onclick="location.href='${pageContext.request.contextPath}/main/main'">
    </div>
</div>
</div>
</div>
</section>
</body>
</html>
