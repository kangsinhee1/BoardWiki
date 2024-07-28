<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<section class="page-top-section set-bg" data-setbg="/img/page-top-bg/4.jpg" style="background-image: url(&quot;/img/page-top-bg/4.jpg&quot;);">

<h1>Live Broadcasts</h1>
</section>

<style>
.broadcast {
	display: inline-block;
	margin: 20px;
	text-align: center;
}

.thumbnail {
	width: 200px;
	height: 150px;
	background-color: #000;
}

.username {
	margin-top: 10px;
	font-size: 18px;
}
</style>
<section class="blog-page">
<div class="container">
<div class="row">
		<div class="col-lg-12">
<div class="game-main">
	<c:forEach var="broadcast" items="${broadcasts}">
		<div class="broadcast">
			<a
				href="${pageContext.request.contextPath}/streaming/broadcast?str_num=${broadcast.str_num}">
				<div class="thumbnail">
					<img
						src="${pageContext.request.contextPath}/hls/thumbnail.jpg">
				</div>
				<div class="username">${broadcast.mem_nickName}님의 방송</div>
			</a>
		</div>
	</c:forEach>
</div>
<c:if test="${user != null}">
	<button onclick="location.href='${pageContext.request.contextPath}/streaming/broadcast?str_num=${str_num}'">방송시작하기</button>
</c:if>
</div>
</div>
</div>
</section>



