<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1 id="mypage-side-bar-name"><a href="${pageContext.request.contextPath}/myPage/myPageMain">MyPage</a></h1>
<nav class="side-nav">
	<ul>
		<li><a href="${pageContext.request.contextPath}/myPage/myAlert">알림</a></li>
		<li><a href="${pageContext.request.contextPath}/myPage/calendar">일정</a></li>
		<li><a href="${pageContext.request.contextPath}/myPage/myChat">채팅방</a></li>
		<li><a href="${pageContext.request.contextPath}/myPage/myOrder">주문</a></li>
		<li><a href="${pageContext.request.contextPath}/myPage/myLog">전적</a></li>
		<li>
		<div class="dropdown">
		  <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		    작성한 글
		  </button>
		  <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
		    <a class="dropdown-item" href="${pageContext.request.contextPath}/myPage/myWrite">자유게시판</a>
		    <a class="dropdown-item" href="${pageContext.request.contextPath}/myPage/myWrite2">팁게시판</a>
		    <a class="dropdown-item" href="${pageContext.request.contextPath}/myPage/myWrite3">후기게시판</a>
		  </div>
		</div>
		</li>
		<li><a href="${pageContext.request.contextPath}/myPage/myPoint">포인트</a></li>
		<li><a href="${pageContext.request.contextPath}/myPage/myQna">내QnA</a></li>	
	</ul>
</nav>