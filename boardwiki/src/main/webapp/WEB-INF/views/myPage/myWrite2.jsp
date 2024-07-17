<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<h3>내가 쓴 글</h3>
<br>
<div class="page-main">
	<c:if test="${count==0}">
		<div class="result-display">표시할 게시물이 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
		<h5>팁게시판</h5>
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
						<td class="align-center">${board.boa_num}</td>
						<td class="align-left"><a
							href="${pageContext.request.contextPath}/board/detail?boa_num=${board.boa_num}">${board.boa_title}(${board.re_cnt})</a></td>
						<td class="align-center"><c:if
								test="${empty board.mem_nickname}">${board.mem_email}</c:if> <c:if
								test="${!empty board.mem_nickname}">${board.mem_nickname}</c:if></td>
						<td class="align-center">${board.boa_rdate}</td>
						<td class="align-center">${board.boa_hit}</td>
						<td class="align-center">${board.fav_cnt}</td>
					</tr>
			</c:forEach>
		</table>
		<div class="align-center">${page}</div>
	</c:if>
</div>
