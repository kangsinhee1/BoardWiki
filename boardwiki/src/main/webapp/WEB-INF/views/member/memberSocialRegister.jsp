<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!-- Page top section -->
<section class="page-top-section set-bg"
	data-setbg="/img/page-top-bg/4.jpg">
	<div class="page-info">
		<h2>SNS회원가입</h2>
		<div class="site-breadcrumb">
			<a href="/main/main">Home</a> / <span>SNS회원가입</span>
		</div>
	</div>
</section>
<!-- Page top end-->
<section class="contact-page">
	<div class="container">
		<div class="align-center">
			<div class="page-main">
				<h2 class="register-h2">SNS 회원가입</h2>
				<form:form action="memberNaverRegister" id="member_register"
					modelAttribute="memberVO">
					<ul>
						<li>
							<form:label path="mem_email">이메일</form:label> 
							<form:input path="mem_email" readonly="true" />
						</li>
						<li>
							<form:label path="mem_name">이름</form:label> 
							<form:input path="mem_name" /></li>
						<li>
							<form:label path="mem_nickName">별명 </form:label> 
							<form:input path="mem_nickName" /> 
							<input type="button" id="confirmNickname" value="별명중복체크" class="default-btn"> 
							<span id="message_nickName" style="color:white;"></span> 
							<form:errors path="mem_nickName" cssClass="error-color" />
						</li>
						<li>
							<form:label path="mem_phone">전화번호</form:label> 
							<form:input path="mem_phone" /> 
							<form:errors path="mem_phone" cssClass="error-color" />
						</li>
						<li>
							<form:label path="mem_passwd"></form:label> 
							<form:hidden path="mem_passwd" />
						</li>
						<li>
							<form:label path="mem_provider"></form:label> 
							<form:hidden path="mem_provider" />
						</li>
					</ul>
					<div class="align-center">
						<form:button class="default-btn">전송</form:button>
						<input type="button" value="홈으로" class="default-btn"
							onclick="location.href='${pageContext.request.contextPath}/main/main'">
					</div>
				</form:form>
				<script type="text/javascript"
					src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
				<script type="text/javascript"
					src="${pageContext.request.contextPath}/js/member.register.js"></script>
			</div>
		</div>
	</div>
</section>
<!-- 회원가입 끝 -->




