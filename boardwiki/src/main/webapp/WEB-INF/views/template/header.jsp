<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 상단 시작 -->
<div class="search-bar">
  <form class="form-inline">  
	<a class="navbar-brand">Boardwiki</a>
    <input id="main_search" class="form-control mr-sm-2" style="width:500px;" type="search" placeholder="Search" aria-label="Search">
    <button class="btn btn-outline-success my-2 my-sm-0" type="submit" >Search</button>
  </form>
</div>
<div class="container">
	<div class="row">
		<div class="dropdown">
		  <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		    게임
		  </button>
		  <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
		    <a class="dropdown-item" href="${pageContext.request.contextPath}/item/item_main">게임 메인</a>
		    <a class="dropdown-item" href="${pageContext.request.contextPath}/rent/list">게임 대여</a>
		  </div>
		</div>
		<div class="dropdown">
		  <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		    커뮤니티
		  </button>
		  <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
		    <a class="dropdown-item" href="${pageContext.request.contextPath}/board/list?boa_category=1">자유게시판</a>
		    <a class="dropdown-item" href="${pageContext.request.contextPath}/board/list?boa_category=2">팁게시판	</a>
		    <a class="dropdown-item" href="${pageContext.request.contextPath}/board/list?boa_category=3">후기게시판</a>
		    <a class="dropdown-item" href="${pageContext.request.contextPath}/team/teamList">모임게시판</a>
		    <a class="dropdown-item" href="${pageContext.request.contextPath}/used/usedList">중고게시판</a>
		  </div>
		</div>
		<div class="dropdown">
		  <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		    공지
		  </button>
		  <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
		    <a class="dropdown-item" href="${pageContext.request.contextPath}/board/list?boa_category=4">공지</a>
		    <a class="dropdown-item" href="${pageContext.request.contextPath}/board/list?boa_category=5">QnA</a>
		  </div>
		</div>
		<div class="dropdown">
		  <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		    스트리밍
		  </button>
		  <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
		    <a class="dropdown-item" href="#">실시간 보드게임</a>
		    <a class="dropdown-item" href="#">스트리밍</a>
		  </div>
		</div>
	</div>
</div>
<!-- 상단 끝 -->





