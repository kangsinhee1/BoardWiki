<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<h3>내질문</h3>
<div class="page-main">
	<table class="striped-table">
		<tr>
			<th>번호</th>
			<th width="400">제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
			<th>좋아요수</th>
		</tr>
		<c:forEach var="board" items="${list}">
			<tr>
				<td class="align-center"></td>
				<td class="align-left"></td>
				<td class="align-center"></td>
				<td class="align-center"></td>
				<td class="align-center"></td>
				<td class="align-center"></td>
			</tr>
		</c:forEach>
	</table>
	
</div>
