<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="page-main">
	<c:if test="${count==0}">
	<div class="result-display">표시할 게시물이 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
	<table class="striped-table">
		<tr>
			<th>번호</th>
			<th>채팅방</th>
			<th>개설일</th>
		</tr>
		<c:forEach var="chat" items="${list}">
		<tr>
			<td class="align-center">${chat.useC_num}</td>
			<td class="align-left"><a href="${pageContext.request.contextPath}useChatSeller?use_num=${chat.use_num}&useC_name=${chat.useC_name}">${chat.useC_name}</a></td>
			<td class="align-center">${chat.useC_date}</td>
		</tr>
		</c:forEach>
	</table>
	<div class="align-center">${page}</div>
	</c:if>
</div>