<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
<!-- 게시판 목록 시작 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<div class="page-main">
	<h2>모임 게시판</h2>
	<form action="teamBoardList" id="search_form" method="get">
		<ul class="search">
			<li>
				<select name="keyfield" id="keyfield">
					<option value="1" <c:if test="${param.keyfield == 1}">selected</c:if>>제목</option>
					<option value="2" <c:if test="${param.keyfield == 2}">selected</c:if>>내용</option>
				</select>
			</li>
			<li>
				<input type="search" name="keyword"
				  id="keyword" value="${param.keyword}">
			</li>
			<li>
				<input type="submit" value="찾기">
			</li>
		</ul> 
		<div class="align-right">
			<select id="order" name="order">
				<option value="1" <c:if test="${param.order == 1}">selected</c:if>>최신순</option>
				<option value="2" <c:if test="${param.order == 2}">selected</c:if>>조회수</option>
				<option value="3" <c:if test="${param.order == 3}">selected</c:if>>좋아요</option>
			</select>
			<script type="text/javascript">
				$('#order').change(function(){
					location.href='teamList?keyfield='
							         +$('#keyfield').val()+'&keyword='
							         +$('#keyword').val()+'&order='
							         +$('#order').val();
				});
			</script>
			
			<input type="button" value="글쓰기" 
			                    onclick="location.href='teamBoardWrite'">
		</div>                     
	</form>
	<c:if test="${count == 0}">
	<div class="result-display">표시할 게시물이 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
	<table class="striped-table">
		<tr>
			<th>번호</th>
			<th width="400">제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
			<th>좋아요수</th>
		</tr>
		<c:forEach var="team" items="${list4}">
		<tr>
			<td class="align-center">${team.tea_num}</td>
			<td class="align-left"><a href="teamBoardDetail?teaB_num=${team.teaB_num}">${team.teaB_name}</a></td>
			<td class="align-center">
				${team.mem_email}
			</td>
			<td class="align-center">${team.tea_rdate}</td>
			<td class="align-center">${team.tea_hit}</td>
			<td class="align-center">${team.fav_cnt}</td>
		</tr>
		</c:forEach>
	</table>
	<div class="align-center">${page}</div>
	</c:if>	
</div>
<!-- 게시판 목록 끝 -->





