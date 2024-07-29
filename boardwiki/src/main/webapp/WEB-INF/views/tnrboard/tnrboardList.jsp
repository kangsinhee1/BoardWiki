<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 게시판 목록 시작 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<section class="page-top-section set-bg" data-setbg="/img/page-top-bg/4.jpg">
		<div class="page-info">
		<c:choose>
        	<c:when test="${param.tnr_category == 1}">
           		 <h2>팁게시판</h2>
       		 </c:when>
        	<c:when test="${param.tnr_category == 2}">
           		 <h2>후기게시판</h2>
       		 </c:when>
    	</c:choose>
			<c:choose>
        	<c:when test="${param.tnr_category == 1}">
           		 <div class="site-breadcrumb">
				<a href="tnrboardList?tnr_category=1">Home</a>  /
				<span>Tip</span>
			</div>
       		 </c:when>
        	<c:when test="${param.tnr_category == 2}">
           		<div class="site-breadcrumb">
				<a href="tnrboardList?tnr_category=2">Home</a>  /
				<span>Review</span>
			</div>
       		 </c:when>
    	</c:choose>
		</div>
</section>
<section class="blog-page">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
<div class="page-main">
	<form action="tnrboardList" id="search_form" method="get">
		<input type="hidden" name="tnr_category" value="${param.tnr_category}">
		<ul class="search">
			<li>
				<select name="keyfield" id="keyfield">
					<option value="1"<c:if test="${param.keyfield == 1}">selected</c:if>>제목</option>
					<option value="2"<c:if test="${param.keyfield == 2}">selected</c:if>>내용</option>
					<option value="3"<c:if test="${param.keyfield == 3}">selected</c:if>>제목+내용</option>
				</select>
			</li>
			<li>
				<input type="search" name="keyword" id="keyword" value="${param.keyword}">
			</li>
			<li>
				<input type="submit" value="찾기">
			</li>
		</ul>
		<div class="align-right">
			<select id="order" name="order">
				<option value="1"<c:if test="${param.order == 1}">selected</c:if>>최신순</option>
				<option value="2"<c:if test="${param.order == 2}">selected</c:if>>조회수</option>
				<option value="3"<c:if test="${param.order == 3}">selected</c:if>>좋아요</option>
				<option value="4"<c:if test="${param.order == 4}">selected</c:if>>댓글수</option>
			</select>
			<script type="text/javascript">
				$('#order').change(function(){
					location.href='tnrboardList?tnr_category=${param.tnr_category}&keyfield='
							+$('#keyfield').val()+'&keyword='
							+$('#keyword').val()+'&order='
							+$('#order').val();
				});
			</script>
			<c:choose>
				<c:when test="${param.tnr_category == 1}">
					<c:if test="${!empty user}">
						<input type="button" value="글쓰기" onclick="location.href='tnrwrite?tnr_category=1'">
					</c:if>
	  			</c:when>
	  			<c:when test="${param.tnr_category == 2}">
					<c:if test="${!empty user}">
						<input type="button" value="글쓰기" onclick="location.href='tnrwrite?tnr_category=2'">
					</c:if>
	  			</c:when>
			</c:choose>
		</div>
	</form>
	<c:if test="${count==0}">
	<div class="result-display">표시할 게시물이 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
	<div class="chart-table">
	<table>
		<thead>
		<tr>
			<th>번호</th>
			<th class="chart-th-title">제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
			<th>좋아요수</th>
		</tr>
		</thead>
		<c:forEach var="tnrboard" items="${list}">
		<tr>
			<td class="align-center">${tnrboard.tnr_num}</td>
			<td class="align-left chart-th-title"><a href="tnrboardDetail?tnr_num=${tnrboard.tnr_num}">${tnrboard.tnr_title}(${tnrboard.re_cnt})</a></td>
			<td class="align-center">
				<c:if test="${empty tnrboard.mem_nickname}">${tnrboard.mem_email}</c:if>
				<c:if test="${!empty tnrboard.mem_nickname}">${tnrboard.mem_nickname}</c:if>
			</td>
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
<!-- 게시판 목록 끝 -->













