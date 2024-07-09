<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 게시판 글쓰기 시작 -->
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<div class="page-main">
	<h2>모임 신청하기</h2>
	<form:form action="teamApply" id="board_register" modelAttribute="teamApplyVO" >
	
		<form:hidden path="tea_num" value="${param.tea_num}"/>
		<form:label path="teaA_content">하고싶은말</form:label>
		<form:textarea path="teaA_content"/>
	
		<div class="align-center">
			<form:button class="default-btn">신청</form:button>
			<input type="button" value="취소"
			  class="default-btn"
			  onclick="location.href='teamList'">
		</div>                           
	</form:form>
</div>

