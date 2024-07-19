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


<!-- 회원가입 시작 -->
		
<section class="contact-page">
		<div class="container">
		<div class="align-center">



<div class="page-main">
	<h2>회원가입</h2>
	<form:form action="memberRegister" id="member_register"
	                            modelAttribute="memberVO">
		<ul>
			<li>
				<form:label path="mem_email">이메일</form:label>
				<form:input path="mem_email" placeholder="영문,숫자만 4~12자" autocomplete="off"/>
				<input type="button" id="confirmId" value="이메일중복체크"
				                                 class="default-btn">                  
				<span id="message_id"></span>
				<form:errors path="mem_email" cssClass="error-color"/>                             
			</li>
			<li>
				<form:label path="mem_name">이름</form:label>
				<form:input path="mem_name"/>
				<form:errors path="mem_name" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="mem_nickName">별명</form:label>
				<form:input path="mem_nickName"/>
				<input type="button" id="confirmNickname" value="별명중복체크"
				                                 class="default-btn">                  
				<span id="message_nickName"></span>
				<form:errors path="mem_nickName" cssClass="error-color"/>  
			</li>
			<li>
				<form:label path="mem_passwd">비밀번호</form:label>
				<form:password path="mem_passwd" placeholder="영문,숫자만 4~12자"/>
				<form:errors path="mem_passwd" cssClass="error-color"/>
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

<!-- 회원가입 끝 -->




