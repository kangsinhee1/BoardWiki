<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 룰북 목록 시작 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<div class="page-main">
	<h2>룰북</h2>
	<form action="rulebookList" id="search_form" method="get">
		<ul class="search">
			<li>
				제목
			</li>
			<li>
				<input type="search" name="keyword" id="keyword" value="${param.keyword}">
			</li>
			<li>
				<input type="submit" value="찾기">
			</li>
		</ul>
		<div class="align-right">
			<c:if test="${!empty user}">
			<input type="button" value="글쓰기" 
			                    onclick="location.href='rulebookwrite'">
			</c:if>
		</div>
	</form>
	<c:if test="${count==0}">
	<div class="result-display">표시할 게시물이 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
	<table class="striped-table">
		<tr>
			<th>번호</th>
			<th width="400">제목</th>
			<th>작성일</th>
		</tr>
		<c:forEach var="rulebook" items="${list}">
		<tr>
			<td class="align-center">${rulebook.rulB_num}</td>
			<td class="align-left"><a href="detail?rulB_num=${rulebook.rulB_num}">${rulB.item_name}</a></td>
			<td class="align-center">${rulbook.rulB_rdate}</td>
		</tr>
		</c:forEach>
	</table>
	<div class="align-center">${page}</div>
	</c:if>
</div>
<!-- 게시판 목록 끝 -->













