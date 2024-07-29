<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="page-main">
<h3>대회 관리</h3>
<c:if test="${count == 0}">
	<div class="result-display">표시할 대회가 없습니다.</div>
</c:if>
<c:if test="${count > 0}">
	<table class="striped-table">
		<tr>
			<th>대회번호</th>
			<th>작성자</th>
			<th>대회명</th>
			<th>등록일</th>
			<th>상태</th>
			<th>시작일</th>
			<th>종료일</th>
			<th>참가인원</th>
			<th>최대인원</th>
			<th></th>
		</tr>
		<c:forEach var="contest" items="${list}">
			<tr>
				<td class="align-center">${contest.con_num}</td>
				<td class="align-center">${contest.mem_num}</td>
				<td class="align-center"><a href="contestAdminListDetail?con_num=${contest.con_num}">${contest.con_name}</a></td>
				<td class="align-center">${contest.con_rdate}</td>
				<td class="align-center">
					<c:if test="${contest.con_status==0}">
		            	진행중
		            </c:if>
		            <c:if test="${contest.con_status==1}">
		            	진행예정
		            </c:if>
		            <c:if test="${contest.con_status==2}">
		            	종료
		            </c:if>
					<c:if test="${contest.con_status==3 }">
						삭제
					</c:if>
				</td>
				<td class="align-center">${contest.con_sdate}</td>
				<td class="align-center">${contest.con_edate}</td>
				<td class="align-center">${contest.con_man}</td>
				<td class="align-center">${contest.con_maxman}</td>
			</tr>
		</c:forEach>
	</table>
	<div class="blog-pagination" style= "text-align : center">${page}</div>
</c:if>
</div>