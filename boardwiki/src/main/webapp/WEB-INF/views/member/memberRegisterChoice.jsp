<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 회원로그인 시작 -->
<div class="page-main">
	<h2>회원가입 플랫폼 선택</h2>
	<form:form action="memberRegisterChoice" id="member_login"
	                            modelAttribute="memberVO">
	    <div>
	    	<a href="${pageContext.request.contextPath}/member/memberRegister">보드위키</a>
	    </div>
	    <div>
	    	<img src="${pageContext.request.contextPath}/images/Naver.png" onclick="location.href='${naverUrl}'">
	    </div>
	    <div>
	    	<img src="${pageContext.request.contextPath}/images/Google.png" onclick="location.href='${GoogleUrl}'">
	    </div>   
	    <div>
	    	<img src="${pageContext.request.contextPath}/images/Kakao.png" onclick="location.href='${KakaoUrl}'">
	    </div>                           
	</form:form>
	<p class="align-center">
		<input type="button" value="홈으로"
			  class="default-btn"
			  onclick="location.href='${pageContext.request.contextPath}/main/main'">
	</p>
</div>
<!-- 회원로그인 끝 -->


