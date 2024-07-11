<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1 id="mypage-side-bar-name">MyPage</h1>
<nav class="side-nav">
	<ul>
		<li><a>알림</a></li>
		<li><a href="${pageContext.request.contextPath}/member/calendar">일정</a></li>
		<li><a>채팅방</a></li>
		<li><a>주문</a></li>
		<li><a>전적</a></li>
		<li><a href="${pageContext.request.contextPath}/member/myWrite">작성한글</a></li>
		<li><a>포인트</a></li>
		<li><a>내QnA</a></li>	
	</ul>
</nav>