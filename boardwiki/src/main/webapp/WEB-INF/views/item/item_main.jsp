<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<!-- Games section -->
<section class="games-section">
	<div class="container">
			<div class="game-main">
				<c:if test="${count > 0}">
						<c:forEach var="item" items="${list}" varStatus="status">
							<div class="game-box">
								<div class="game-item">
									<img onclick="location.href='${pageContext.request.contextPath}/item/item_detail?item_num=${item.item_num}'"
											src="${item.item_image}" class="card-img-top" alt="#">
										<div class="card-body">
											<h5 class="card-title">${item.item_name}</h5>
											<p class="card-text">
												순위: ${item.item_rank}위<br> 평점: ${item.item_average}점<br>
												출시연도: ${item.item_year}년
											</p>
											<a href="${pageContext.request.contextPath}/item/item_detail?item_num=${item.item_num}"
												class="btn btn-primary">상세보기</a>
										</div>
									</div>
								</div>
								<c:if test="${status.index % 6 == 5 && !status.last}">
				</c:if>
				</c:forEach>

		
		<div class="align-center" style= "text-align : center">${page}</div>
		</c:if>

		<c:if test="${count == 0}">
			<h5>검색 결과가 없습니다.</h5>
			<hr size="1" noshade="noshade" width="100%">
		</c:if>
	</div>
	</div>

	</div>
</section>
<!-- Games end-->
