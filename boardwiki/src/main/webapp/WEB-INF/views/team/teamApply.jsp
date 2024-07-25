<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 게시판 글쓰기 시작 -->
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

	<!-- Page top section -->
<section class="page-top-section set-bg" data-setbg="/img/page-top-bg/4.jpg">
	<div class="page-info">
		<h2>모임 신청</h2>
		<div class="site-breadcrumb">
			<a href="">Home</a>  /
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
<div class="page-main">
	<h2>모임 신청하기</h2>
	<div class="result-display2">
	<form:form action="teamApply" id="board_register" modelAttribute="teamApplyVO" >
	<div>하고싶은 말:</div>
		<form:hidden path="tea_num" value="${param.tea_num}"/>
		<form:textarea path="teaA_content" cols="35" rows="5"/>
	
		<div class="align-center">
			<form:button class="default-btn">신청</form:button>
			
			<input type="button" value="취소"
			  class="default-btn"
			  onclick="location.href='teamList'">
		</div>                           
	</form:form>
</div>
	</div>
	</div>
	</div>
	</div>
	</section>

