<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<div class="page-main">
	<h2>채팅리스트</h2>
	<form action="chatList" id="search_form" method="get">
		<ul class="search">
			<li>
				<input type="search" name="keyword" id="keyword" value="${param.keyword}">
			</li>
			<li>
				<input type="submit" value="찾기">
				<input type="button" value="목록" onclick="location.href='chatList'">
			</li>
		</ul>
	</form>
	<c:if test="${count==0}">
	<div class="result-display">표시할 채팅방이 없습니다.</div>
	</c:if>
	<c:if test="${count>0}">
	<table class="striped-table">
		<tr>
			<th>채팅방 번호</th>
			<th>채팅방 이름</th>
			<th>채팅 개설일</th>
		</tr>
		<c:forEach var="used" items="${list}">
		<tr>
			<td>${used.useC_num}</td>
			<td style="text-align:left;">
				<a href="${pageContext.request.contextPath}useChat?use_num=${used.use_num}&useC_name=${used.useC_name}">
					<b>${used.useC_name}</b>
				</a>
			</td>
			<td>${used.useC_date }</td>
		</tr>
		</c:forEach>
	</table>
	<div class="align-center">${page}</div>
	</c:if>
</div>