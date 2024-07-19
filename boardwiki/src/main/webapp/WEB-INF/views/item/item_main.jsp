<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>

<%-- <div class="game-main">
	<c:if test="${count>0 }">
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
		<div class="align-center">${page}</div>
	</c:if>
	<c:if test="${count==0 }">
		<h5>검색 결과가 없습니다.</h5>
		<hr size="1" noshade="noshade" width="100%">
	</c:if>
</div> --%>



<!-- Games section -->
<section class="games-section">
	<div class="container">

		<div class="row">

			<div class="game-main">
				<c:if test="${count > 0}">

					<div class="col-xl-12 col-lg-12 col-md-12">
						<div class="row">
							<c:forEach var="item" items="${list}" varStatus="status">
								<div class="col-lg-2 col-md-4">
									<div class="game-item">
										<img
											onclick="location.href='${pageContext.request.contextPath}/item/item_detail?item_num=${item.item_num}'"
											src="${item.item_image}" class="card-img-top" alt="#">
										<div class="card-body">
											<h5 class="card-title">${item.item_name}</h5>
											<p class="card-text">
												순위: ${item.item_rank}위<br> 평점: ${item.item_average}점<br>
												출시연도: ${item.item_year}년
											</p>
											<a
												href="${pageContext.request.contextPath}/item/item_detail?item_num=${item.item_num}"
												class="btn btn-primary">상세보기</a>
										</div>
									</div>
								</div>
								<c:if test="${status.index % 6 == 5 && !status.last}">
						</div>
						<div class="row">
				</c:if>
				</c:forEach>
			</div>

		</div>

		<div class="align-center">${page}</div>
		</c:if>

		<c:if test="${count == 0}">
			<h5>검색 결과가 없습니다.</h5>
			<hr size="1" noshade="noshade" width="100%">
		</c:if>
	</div>

	<!-- <div class="col-xl-12 col-lg-12 col-md-12">
        <div class="row">
            <div class="col-lg-2 col-md-4">
                <div class="game-item">
                    <img src="img/games/1.jpg" alt="#">
                    <h5>Zombie Appocalipse 2</h5>
                    <a href="game-single.html" class="read-more">Read More <img src="img/icons/double-arrow.png" alt="#"/></a>
                </div>
            </div>
            <div class="col-lg-2 col-md-4">
                <div class="game-item">
                    <img src="img/games/2.jpg" alt="#">
                    <h5>Dooms Day</h5>
                    <a href="game-single.html" class="read-more">Read More <img src="img/icons/double-arrow.png" alt="#"/></a>
                </div>
            </div>
            <div class="col-lg-2 col-md-4">
                <div class="game-item">
                    <img src="img/games/3.jpg" alt="#">
                    <h5>The Huricane</h5>
                    <a href="game-single.html" class="read-more">Read More <img src="img/icons/double-arrow.png" alt="#"/></a>
                </div>
            </div>
            <div class="col-lg-2 col-md-4">
                <div class="game-item">
                    <img src="img/games/4.jpg" alt="#">
                    <h5>Star Wars</h5>
                    <a href="game-single.html" class="read-more">Read More <img src="img/icons/double-arrow.png" alt="#"/></a>
                </div>
            </div>
            <div class="col-lg-2 col-md-4">
                <div class="game-item">
                    <img src="img/games/5.jpg" alt="#">
                    <h5>Candy land</h5>
                    <a href="game-single.html" class="read-more">Read More <img src="img/icons/double-arrow.png" alt="#"/></a>
                </div>
            </div>
            <div class="col-lg-2 col-md-4">
                <div class="game-item">
                    <img src="img/games/6.jpg" alt="#">
                    <h5>E.T.</h5>
                    <a href="game-single.html" class="read-more">Read More <img src="img/icons/double-arrow.png" alt="#"/></a>
                </div>
            </div>
            <div class="col-lg-2 col-md-4">
                <div class="game-item">
                    <img src="img/games/7.jpg" alt="#">
                    <h5>Zombie Appocalipse 2</h5>
                    <a href="game-single.html" class="read-more">Read More <img src="img/icons/double-arrow.png" alt="#"/></a>
                </div>
            </div>
            <div class="col-lg-2 col-md-4">
                <div class="game-item">
                    <img src="img/games/8.jpg" alt="#">
                    <h5>Dooms Day</h5>
                    <a href="game-single.html" class="read-more">Read More <img src="img/icons/double-arrow.png" alt="#"/></a>
                </div>
            </div>
            <div class="col-lg-2 col-md-4">
                <div class="game-item">
                    <img src="img/games/9.jpg" alt="#">
                    <h5>The Huricane</h5>
                    <a href="game-single.html" class="read-more">Read More <img src="img/icons/double-arrow.png" alt="#"/></a>
                </div>
            </div>
            <div class="col-lg-2 col-md-4">
                <div class="game-item">
                    <img src="img/games/10.jpg" alt="#">
                    <h5>The Huricane</h5>
                    <a href="game-single.html" class="read-more">Read More <img src="img/icons/double-arrow.png" alt="#"/></a>
                </div>
            </div>
            <div class="col-lg-2 col-md-4">
                <div class="game-item">
                    <img src="img/games/11.jpg" alt="#">
                    <h5>The Huricane</h5>
                    <a href="game-single.html" class="read-more">Read More <img src="img/icons/double-arrow.png" alt="#"/></a>
                </div>
            </div>
            <div class="col-lg-2 col-md-4">
                <div class="game-item">
                    <img src="img/games/12.jpg" alt="#">
                    <h5>The Huricane</h5>
                    <a href="game-single.html" class="read-more">Read More <img src="img/icons/double-arrow.png" alt="#"/></a>
                </div>
            </div>
        </div>
        <div class="site-pagination">
            <a href="#" class="active">01.</a>
            <a href="#">02.</a>
            <a href="#">03.</a>
        </div>
    </div> -->

	</div>

	</div>
</section>
<!-- Games end-->
