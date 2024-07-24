<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

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
<!-- 이메일찾기 시작 -->
	<section class="blog-page">
<div class="container">
	<div class="row">
<div class="page-main">
	<h2>아이디 찾기</h2>
	<form:form action="memberFindEmail" id="member_register"
	                            modelAttribute="memberVO">
		<ul>
			<li>
				<form:label path="mem_name">이름</form:label>
				<form:input path="mem_name"/>
				<form:errors path="mem_name" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="mem_phone">전화번호</form:label>
				<form:input path="mem_phone"/>
				<form:errors path="mem_phone" cssClass="error-color"/>
			</li>
		</ul> 
		<div class="align-center">
			<form:button class="default-btn">전송</form:button>
			<input type="button" value="홈으로"
			  class="default-btn"
			  onclick="location.href='${pageContext.request.contextPath}/main/main'">
		</div>                           
	</form:form>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/member.register.js"></script>	
</div>
</div>
</div>
</section>
<!-- 이메일찾기 끝 -->




