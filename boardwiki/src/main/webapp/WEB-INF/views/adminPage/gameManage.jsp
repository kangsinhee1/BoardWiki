<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="page-main">
<h3>게임 관리</h3>
<c:if test="${count == 0}">
	<div class="result-display">표시할 제품이 없습니다.</div>
</c:if>
<c:if test="${count > 0}">
	<input type="button" value="등급 수정" class="align-right">
	<table class="striped-table">
		<tr>
			<th>제품ID</th>
			<th>제품명</th>
			<th>제품가격</th>
			<th>제품평점</th>
			<th>장르</th>
		</tr>
		<c:forEach var="item" items="${list}">
			<tr>
				<td class="align-center">${item.item_id}</td>
				<td class="align-center" style="width:200px;">${item.item_name}</td>
				<td class="align-center">${item.item_price}</td>
				<td class="align-center">${item.item_average}</td>
				<td class="align-center">${item.item_genre}</td>
			</tr>
		</c:forEach>
	</table>
	<div class="blog-pagination" style= "text-align : center">${page}</div>
</c:if>
</div>