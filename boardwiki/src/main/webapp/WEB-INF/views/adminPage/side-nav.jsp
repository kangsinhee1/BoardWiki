<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="adminPage-side-bar-name"><a href="${pageContext.request.contextPath}/adminPage/adminPageMain">관리자 페이지</a></div>
<nav class="side-nav">
	<ul>
		<li><a href="${pageContext.request.contextPath}/adminPage/memberManage">회원관리</a></li>
		<li><a href="${pageContext.request.contextPath}/adminPage/gameManage">게임관리</a></li>
		<li><a href="${pageContext.request.contextPath}/adminPage/orderManage">주문관리</a></li>
		<li><a href="${pageContext.request.contextPath}/adminPage/streamingManage">스트리밍관리</a></li>
		<li><a href="${pageContext.request.contextPath}/adminPage/pointManage">포인트 관리</a></li>
		<li><a href="${pageContext.request.contextPath}/adminPage/reportManage">신고관리</a></li>	
		<li><a href="${pageContext.request.contextPath}/adminPage/QnaManage">QnA</a></li>	
	</ul>
	
</nav>