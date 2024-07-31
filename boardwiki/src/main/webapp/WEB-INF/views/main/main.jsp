<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="KR">
<head>
	<title>EndGam - Gaming Magazine Template</title>
	<meta charset="UTF-8">
</head>
<style>
div.hiddenImage figure{
	display:none; 
}
.blog-item .text-box p {
    overflow: hidden;
    display: -webkit-box;
    -webkit-line-clamp: 6;
    -webkit-box-orient: vertical;
}
</style>
<body>
	<!-- Page Preloder -->
	<div id="preloder">
		<div class="loader"></div>
	</div>
	<!-- Hero section -->
	<section class="hero-section overflow-hidden">
		<div class="hero-slider owl-carousel">
			<div class="hero-item set-bg d-flex align-items-center justify-content-center text-center" data-setbg="/images/maindice1.jpeg">
				<div class="container">
					<p><img class="slider-img" src="/images/brass.png"></p>
					<a href="${pageContext.request.contextPath}/item/item_detail?item_num=20"	 class="site-btn">Read More  <img src="/img/icons/double-arrow.png" alt="#"/></a>
				</div>
			</div>
			<div class="hero-item set-bg d-flex align-items-center justify-content-center text-center" data-setbg="/images/maindice1.jpeg">
				<div class="container">
					<p><img class="slider-img" src="/images/twilight.jpg"></p>
					<a href="${pageContext.request.contextPath}/item/item_detail?item_num=5" class="site-btn">Read More  <img src="/img/icons/double-arrow.png" alt="#"/></a>
				</div>
			</div>
			<div class="hero-item set-bg d-flex align-items-center justify-content-center text-center" data-setbg="/images/maindice1.jpeg">
				<div class="container">
					<p><img class="slider-img" src="${pageContext.request.contextPath}/images/skyteam.jpg"></p>
					<a href="${pageContext.request.contextPath}/item/item_detail?item_num=97" class="site-btn">Read More  <img src="/img/icons/double-arrow.png" alt="#"/></a>
				</div>
			</div>
		</div>
	</section>
	<!-- Hero section end-->


	<!-- Intro section -->
	<section class="intro-section">
		<div class="container">
			<div class="row">
				<div class="col-md-4">
					<div class="intro-text-box text-box2 text-white hiddenImage" style=" overflow: hidden;display: -webkit-box; -webkit-line-clamp: 6; -webkit-box-orient: vertical;">
						<div class="top-meta">${board.boa_rdate}  /  in <a href="">자유게시판</a></div>
						<h3 style="width:100%">${board.boa_title }</h3>
						<p>${board.boa_content }</p><br>
					</div>
						<a href="/board/detail?boa_num=${board.boa_num }" class="read-more">Read More  <img src="/img/icons/double-arrow.png" alt="#"/></a>
				</div>
				<div class="col-md-4">
					<div class="intro-text-box text-box2 text-white hiddenImage" style=" overflow: hidden;display: -webkit-box; -webkit-line-clamp: 6; -webkit-box-orient: vertical;">
						<div class="top-meta">${tnr.tnr_rdate }  /  in <a href="">팁/후기게시판</a></div>
						<h3 style="width:100%">${tnr.tnr_title }</h3>
						<p>${tnr.tnr_content }</p><br>
					</div>
						<a href="/tnrboard/tnrboardDetail?tnr_category=${tnr.tnr_category }&tnr_num=${tnr.tnr_num }" class="read-more">Read More  <img src="/img/icons/double-arrow.png" alt="#"/></a>
				</div>
				<div class="col-md-4">
					<div class="intro-text-box text-box2 text-white hiddenImage" style=" overflow: hidden;display: -webkit-box; -webkit-line-clamp: 6; -webkit-box-orient: vertical;">
						<div class="top-meta">${used.use_rdate }  /  in <a href="">중고게시판</a></div>
						<h3 style="width:100%">${used.use_title }</h3>
						<p>${used.use_content }</p><br>
					</div>
						<a href="/used/usedDetail?use_num=${used.use_num }" class="read-more">Read More  <img src="/img/icons/double-arrow.png" alt="#"/></a>
				</div>
			</div>
		</div>
	</section>
	<!-- Intro section end -->


	<!-- Blog section -->
	<section class="blog-section spad">
		<div class="container">
			<div class="row">
				<div class="col-xl-9 col-lg-8 col-md-7">
					<div class="section-title text-white">
						<h2>Latest News</h2>
					</div>
					<!-- Blog item -->
					<c:forEach var="news" items="${news }">
					<div class="blog-item">
						<div class="blog-text text-box text-white hiddenImage">
							<div class="top-meta">${news.boa_rdate }  /  in <a href="">News</a></div>
							<h3>${news.boa_title }</h3>
							<div class="p-tag">${news.boa_content }</div><br>
							<a href="/board/detail?boa_num=${news.boa_num }" class="read-more">Read More  <img src="/img/icons/double-arrow.png" alt="#"/></a>
						</div>
					</div>
					<hr size="1" width="100%">
					</c:forEach>
				</div>
				<div class="col-xl-3 col-lg-4 col-md-5 sidebar">
					<div id="stickySidebar">
						<div class="widget-item">
							<h4 class="widget-title">Trending</h4>
							<div class="trending-widget">
							<c:forEach var="item" items="${item }">
								<div class="tw-item">
									<div class="tw-thumb">
										<img src="${item.item_thumbnail }" alt="#">
									</div>
									<div class="tw-text">
										<div class="tw-meta">${item.item_year } /  in Games</div>
										<h5><a href="${pageContext.request.contextPath}/item/item_detail?item_num=${item.item_num}">${item.item_name }</a></h5>
									</div>
								</div>
							</c:forEach>
							</div>
						</div>
						<div class="widget-item">
							<div class="categories-widget">
								<h4 class="widget-title">categories</h4>
								<ul>
									<li><a href="${pageContext.request.contextPath}/item/item_main">Games</a></li>
									<li><a href="${pageContext.request.contextPath}/tnrboard/tnrboardList?tnr_category=1">Gaming Tips</a></li>
									<li><a href="${pageContext.request.contextPath}/tnrboard/tnrboardList?tnr_category=2">Game review</a></li>
									<li><a href="${pageContext.request.contextPath}/team/teamList">Team</a></li>
									<li><a href="${pageContext.request.contextPath}/used/usedList">Used</a></li>
									<li><a href="${pageContext.request.contextPath}/streaming/broadcasts">Streaming</a></li>
								</ul>
							</div>
						</div>
						<div class="widget-item">
						<a href="#" class="add">
							<img src="/img/add.jpg" alt="">
						</a>
					</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Blog section end -->


	<!-- Intro section -->
	<section class="intro-video-section set-bg d-flex align-items-end " data-setbg="/img/promo-bg.jpg">
		<a href="https://www.youtube.com/embed/KNexS61fjus?si=6Auo1AqweWngDj5V"	 class="video-play-btn video-popup"><img src="/img/icons/solid-right-arrow.png" alt="#"></a>
		<div class="container">
			<div class="video-text">
				<h2>Promo video of the game</h2>
				<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt.</p>
			</div>
		</div>
	</section>
	<!-- Intro section end -->



	</body>
</html>

