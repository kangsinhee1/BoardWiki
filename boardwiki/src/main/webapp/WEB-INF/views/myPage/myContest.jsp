<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<h3>신청대회</h3>
<c:if test="${count == 0}">
	<div class="result-display">표시할 대회가 없습니다.</div>
</c:if>
<c:if test="${count > 0}">
	<table class="striped-table">
		<tr>
			<th>대회명</th>
			<th>시작일</th>
			<th>종료일</th>
			<th>대회상태</th>
			<th>참가인원</th>
			<th>최대인원</th>
			<th>개최주소</th>
		</tr>
		<c:forEach var="contest" items="${list}">
			<tr>
				<td class="align-center"><a href="${pageContext.request.contextPath}/contest/contestDetail?con_num=${contest.con_num}">${contest.con_name}</a></td>
				<td class="align-center">${contest.con_sdate}</td>
				<td class="align-center">${contest.con_edate}</td>
				<c:if test="${contest.con_status == 0}">
					<td>모집진행중</td>
				</c:if>
				<c:if test="${contest.con_status == 2}">
					<td>모집마감</td>
				</c:if>
				<td class="align-center">${contest.con_man}</td>
				<td class="align-center">${contest.con_maxman}</td>
				<td class="align-center">${contest.con_address1} ${contest.con_address2}</td>
				
			</tr>
		</c:forEach>
	</table>
	<div class="align-center">${page}</div>
</c:if>
