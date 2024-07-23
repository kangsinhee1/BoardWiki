<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 게시판 글쓰기 시작 -->
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

	<!-- Page top section -->
<section class="page-top-section set-bg" data-setbg="/img/page-top-bg/4.jpg">
	<div class="page-info">
		<h2>모임 신청</h2>
		<div class="site-breadcrumb">
			<a href="">Home</a>  /
			<span></span> /
			<span></span>
		</div>
	</div>
</section>
<!-- Page top end-->
<section class="blog-page">
<div class="container">
	<div class="row">
		<div class="col-lg-12">
<div class="page-main">
	<h2>판매자 평가하기</h2>
	<div class="result-display">
	<form action="usedGrade"  method="post" id="board_register" >
	<h4>평가하기</h4>
	<div>평점:</div>
		<input type="hidden" name="useC_num" value="${param.useC_num}" />
		<input type="number" name="useC_grade" min="0" max="5"/>
		<div class="align-center">
			<input type="submit" class="default-btn" value="등록">
			<input type="button" value="취소"
			  class="default-btn"
			  onclick="location.href='${pageContext.request.contextPath}/myPage/myChat'">
		</div>                           
	</form>
</div>
	</div>
	</div>
	</div>
	</div>
	</section>

