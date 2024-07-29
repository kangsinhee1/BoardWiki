<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- Page top section -->

<section class="page-top-section set-bg"
	data-setbg="/img/page-top-bg/4.jpg">
	<div class="page-info">
		<h2>Live Broadcasts</h2>
		<div class="site-breadcrumb">
			<a href="${pageContext.request.contextPath}/item/item_main">Home</a>
			/ <span>Detail</span>
		</div>
	</div>
</section>
<!-- Page top end-->

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
		<div class="align-right">
		<c:if test="${user != null}">
	<button onclick="location.href='${pageContext.request.contextPath}/streaming/broadcast?str_num=${str_num}'">방송시작하기</button>
</c:if>
		</div>
<div class="game-main">

	<c:forEach var="broadcast" items="${broadcasts}">
	
		<div class="broadcast">
			<a
				href="${pageContext.request.contextPath}/streaming/broadcast?str_num=${broadcast.str_num}">
				<div class="thumbnail">
					<img
						src="${pageContext.request.contextPath}/upload/boardimage.png" style=" height:100%; width:180px;">
				</div>
				<div class="username">${broadcast.mem_nickName}님의 방송</div>
			</a>
		</div>
	</c:forEach>
</div>

</div>
</div>
</div>
</section>



