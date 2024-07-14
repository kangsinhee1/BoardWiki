<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<div class="game-main">
	<c:if test="${count>0 }">
		<c:forEach var="item" items="${list4}">
			<div class="card" style="width: 18rem;">
				<img
					onclick="location.href='${pageContext.request.contextPath}/item/item_detail?item_num=${item.item_num}'"
					src="${item.item_image}" class="card-img-top">
				<div class="card-body">
					<h5 class="card-title">${item.item_name}</h5>
					<p class="card-text">
						순위:${item.item_rank}위<br> 평점:${item.item_average}점<br>
						출시연도:${item.item_year}년
					</p>
					<a
						href="${pageContext.request.contextPath}/item/item_detail?item_num=${item.item_num}"
						class="btn btn-primary">상세보기</a>
				</div>
			</div>
		</c:forEach>
		<div class="align-center">${page}</div>
	</c:if>
	<c:if test="${count==0 }">
		<h5>검색 결과가 없습니다.</h5>
		<hr size="1" noshade="noshade" width="100%">
		<h2>인기 게임</h2>
		<c:forEach var="item" items="${list}">
			<div class="card" style="width: 18rem;">
				<img
					onclick="location.href='${pageContext.request.contextPath}/item/item_detail?item_num=${item.item_num}'"
					src="${item.item_image}" class="card-img-top">
				<div class="card-body">
					<h5 class="card-title">${item.item_name}</h5>
					<p class="card-text">
						순위:${item.item_rank}위<br> 평점:${item.item_average}점<br>
						출시연도:${item.item_year}년
					</p>
					<a
						href="${pageContext.request.contextPath}/item/item_detail?item_num=${item.item_num}"
						class="btn btn-primary">상세보기</a>
				</div>
			</div>
		</c:forEach>
		<h2>최고 평점</h2>
		<c:forEach var="item" items="${list2}">
			<div class="card" style="width: 18rem;">
				<img
					onclick="location.href='${pageContext.request.contextPath}/item/item_detail?item_num=${item.item_num}'"
					src="${item.item_image}" class="card-img-top">
				<div class="card-body">
					<h5 class="card-title">${item.item_name}</h5>
					<p class="card-text">
						순위:${item.item_rank}위<br> 평점:${item.item_average}점<br>
						출시연도:${item.item_year}년
					</p>
					<a
						href="${pageContext.request.contextPath}/item/item_detail?item_num=${item.item_num}"
						class="btn btn-primary">상세보기</a>
				</div>
			</div>
		</c:forEach>
		<h2>신작 게임</h2>
		<c:forEach var="item" items="${list3}">
			<div class="card" style="width: 18rem;">
				<img
					onclick="location.href='${pageContext.request.contextPath}/item/item_detail?item_num=${item.item_num}'"
					src="${item.item_image}" class="card-img-top">
				<div class="card-body">
					<h5 class="card-title">${item.item_name}</h5>
					<p class="card-text">
						순위:${item.item_rank}위<br> 평점:${item.item_average}점<br>
						출시연도:${item.item_year}년
					</p>
					<a
						href="${pageContext.request.contextPath}/item/item_detail?item_num=${item.item_num}"
						class="btn btn-primary">상세보기</a>
				</div>
			</div>
		</c:forEach>
	</c:if>
</div>
