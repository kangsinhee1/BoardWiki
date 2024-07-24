<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<section class="page-top-section set-bg" data-setbg="/img/page-top-bg/4.jpg">
		<div class="page-info">
			<h2>룰북</h2>
			<div class="site-breadcrumb">
				<a href="rulebookList">Home</a>  /
				<span>RuleBook</span>
			</div>
			
		</div>
</section>
<!-- 룰북 목록 시작 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<section class="blog-page">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
<div class="page-main">
	<form action="rulebookList" id="search_form" method="get">
		<ul class="search">
			<li>
				<select name="keyfield" id="keyfield">
					<option value="1" <c:if test="${param.keyfield == 1}">selected</c:if>>게임</option>
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
			<c:if test="${!empty user && user.mem_auth == 9}">
			<input type="button" value="글쓰기" 
			                    onclick="location.href='rulebookWrite'">
			</c:if>
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
			<th width="400">게임</th>
			<th>등록일</th>
		</tr>
		</thead>
		<c:forEach var="rulebook" items="${list}">
		<tr>
			<td class="align-center">${rulebook.rulB_num}</td>
			<td class="align-left"><a href="rulebookDetail?rulB_num=${rulebook.rulB_num}">${rulebook.item_name}</a></td>
			<td class="align-center">${rulebook.rulB_rdate}</td>
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













