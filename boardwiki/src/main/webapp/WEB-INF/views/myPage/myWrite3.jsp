<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<section class="blog-page">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
<h3>내가 쓴 글</h3>
<br>
<div class="page-main">
	<c:if test="${count==0}">
		<div class="result-display">표시할 게시물이 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
		<h5>후기게시판</h5>
		<div class="chart-table">
		<table>
		<thead>
			<tr>
				<th>번호</th>
				<th width="400">제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>조회수</th>
				<th>좋아요수</th>
			</tr>
			</thead>
			<c:forEach var="tnrboard" items="${list}">
					<tr>
						<td class="align-center">${tnrboard.tnr_num}</td>
						<td class="align-left"><a
							href="${pageContext.request.contextPath}/tnrboard/tnrboardDetail?tnr_num=${tnrboard.tnr_num}">${tnrboard.tnr_title}(${tnrboard.re_cnt})</a></td>
						<td class="align-center"><c:if
								test="${empty tnrboard.mem_nickname}">${tnrboard.mem_email}</c:if> <c:if
								test="${!empty tnrboard.mem_nickname}">${tnrboard.mem_nickname}</c:if></td>
						<td class="align-center">${tnrboard.tnr_rdate}</td>
						<td class="align-center">${tnrboard.tnr_hit}</td>
						<td class="align-center">${tnrboard.fav_cnt}</td>
					</tr>
			</c:forEach>
		</table>
		</div>
		<div class="align-center">
		<div class="blog-pagination">${page}</div>
		</div>
	</c:if>
</div>
</div>
</div>
</div>
</section>