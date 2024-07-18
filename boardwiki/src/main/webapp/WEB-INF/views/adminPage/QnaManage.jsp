<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<h3>질문글 관리</h3>
<c:if test="${count==0}">
	<div class="result-display">표시할 게시물이 없습니다.</div>
</c:if>
<c:if test="${count > 0}">
	<table class="striped-table">
		<tr>
			<th>번호</th>
			<th width="300">제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
			<th>좋아요수</th>
			<th>답변여부</th>
		</tr>
		<c:forEach var="board" items="${list}">
		<tr>
			<td class="align-center">${board.boa_num}</td>
			<td class="align-left"><a href="${pageContext.request.contextPath}/board/detail2?boa_num=${board.boa_num}">${board.boa_title}(${board.re_cnt})</a></td>
			<td class="align-center">
				<c:if test="${empty board.mem_nickname}">${board.mem_email}</c:if>
				<c:if test="${!empty board.mem_nickname}">${board.mem_nickname}</c:if>
			</td>
			<td class="align-center">${board.boa_rdate}</td>
			<td class="align-center">${board.boa_hit}</td>
			<td class="align-center">${board.fav_cnt}</td>
				<td class="align-center">
					<c:if test="${board.admin_reply == 'Y'}">
						<span style="color: green;">답변 완료</span>
					</c:if>
					<c:if test="${board.admin_reply != 'Y'}">
						<span style="color: red;">미답변</span>
					</c:if>
				</td>
			</tr>
		</c:forEach>
	</table>
	<div class="align-center">${page}</div>
</c:if>