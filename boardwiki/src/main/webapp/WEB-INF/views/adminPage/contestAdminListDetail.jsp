<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:forEach var="contest" items="${list}" varStatus="status">
    <c:if test="${status.first}">
        <h3>${contest.con_name} 관리</h3>
    </c:if>
</c:forEach>
<c:if test="${count == 0}">
	<div class="result-display">표시할 대회 참가자가 없습니다.</div>
</c:if>
<c:if test="${count > 0}">
	<table class="striped-table">
		<tr>
			<th>대회번호</th>
			<th>이메일</th>
			<th>닉네임</th>
			<th>참가신청일</th>
			<th>연락처</th>
		</tr>
		<c:forEach var="contest" items="${list}">
			<tr>
				<td class="align-center">${contest.con_num}</td>
				<td class="align-center">${contest.mem_email}</td>
				<td class="align-center">${contest.mem_nickName}</td>
				<td class="align-center">${contest.cona_rdate}</td>
				<td class="align-center">${contest.mem_phone}</td>
			</tr>
		</c:forEach>
	</table>
	<div class="align-center">${page}</div>
</c:if>
