<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
<!-- 게시판 목록 시작 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<style>

</style>

	<!-- Page top section -->
<section class="page-top-section set-bg" data-setbg="/img/page-top-bg/4.jpg">
	<div class="page-info">
		<h2>모임 신청</h2>
		<div class="site-breadcrumb">
			<a href="teamList">Home</a>  /
			<span>모임신청</span> /
			<span><a href="myTeam2"> 내 모임 보기</a></span>
		</div>
	</div>
</section>
<!-- Page top end-->
<section class="blog-page">
<div class="container">
	<div class="row">
		<div class="col-lg-12">
	<form action="teamList" id="search_form" method="get">
		<ul class="search">
			<li>
				<select name="keyfield" id="keyfield" class="form-control" >
					<option value="1" <c:if test="${param.keyfield == 1}">selected</c:if>> 모임명 &nbsp; </option>
					<option value="2" <c:if test="${param.keyfield == 2}">selected</c:if>> 지역 </option>
				</select>
			</li>
			<li>
				<input type="search" name="keyword" class="form-control"
				  id="keyword" value="${param.keyword}">
			</li>
			<li>
				<input type="submit" value="찾기" class="btn btn-primary">
			</li>
		</ul> 
		<div class="align-right">
			<select id="order" name="order" class="form-control">
				<option value="1" <c:if test="${param.order == 1}">selected</c:if>>최신순 &nbsp; </option>
				<option value="2" <c:if test="${param.order == 2}">selected</c:if>>조회수 </option>
				<option value="3" <c:if test="${param.order == 3}">selected</c:if>>좋아요 </option>
			</select>
			<script type="text/javascript">
				$('#order').change(function(){
					location.href='teamList?keyfield='
							         +$('#keyfield').val()+'&keyword='
							         +$('#keyword').val()+'&order='
							         +$('#order').val();
				});
			</script>
			<!-- <c:if test="${!empty user}"> -->
			
			<!--</c:if>
			-->
			<input type="button" value="글쓰기"  
			                    onclick="location.href='teamWrite'">
		</div>                     
	</form>
	<c:if test="${count == 0}">
	<div class="alert alert-info mt-3">표시할 게시물이 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
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
		<c:forEach var="team" items="${list}">
		<tbody>
		<tr>
			<td >${team.tea_num}</td>
			<td><a href="teamDetail?tea_num=${team.tea_num}">(${fn:substring(team.tea_address1,0,2)}) ${team.tea_name}</a></td>
			<td>
				${team.mem_nickname}
			</td>
			<td >${team.tea_rdate}</td>
			<td >${team.tea_hit}</td>
			<td >${team.fav_cnt}</td>
		</tr>
		</tbody>
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
</section>
<!-- 게시판 목록 끝 -->





