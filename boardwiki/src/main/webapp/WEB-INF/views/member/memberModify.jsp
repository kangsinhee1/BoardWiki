<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 회원정보 수정 시작 -->
<div class="page-main">
	<h2>회원정보 수정</h2>
	<form:form action="memberUpdate" id="member_modify"
	                            modelAttribute="memberVO">
		<ul>
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
				<form:label path="mem_phone">전화번호</form:label>
				<form:input path="mem_phone"/>
				<form:errors path="mem_phone" cssClass="error-color"/>
			</li>
		</ul> 
		<div class="align-center">
			<form:button class="default-btn">전송</form:button>
			<input type="button" value="MY페이지"
			  class="default-btn"
			  onclick="location.href='myPage'">
		</div>                           
	</form:form>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/member.register.js"></script>	
</div>
<!-- 회원정보 수정 끝 -->










