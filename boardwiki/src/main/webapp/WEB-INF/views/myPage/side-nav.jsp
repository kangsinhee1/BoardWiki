<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<nav class="side-nav">
	<ul>
		<li><a href="${pageContext.request.contextPath}/myPage/myAlert">알림</a></li>
		<li><a href="${pageContext.request.contextPath}/myPage/calendar">일정</a></li>
		<li><a href="${pageContext.request.contextPath}/myPage/myChat">중고 채팅(구매/판매)</a></li>
		<li><a href="${pageContext.request.contextPath}/myPage/myChat2">모임 채팅</a></li>
		<%-- <li>
			<div class="dropdown">
			 	<button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
			    채팅
			  	</button>
			  	<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
				    <a class="dropdown-item" href="${pageContext.request.contextPath}/myPage/myChat">중고 채팅</a>
				    <a class="dropdown-item" href="${pageContext.request.contextPath}/myPage/myChat2">모임 채팅</a>
			 	</div>
			</div>
		</li> --%>
		<li><a href="${pageContext.request.contextPath}/myPage/myOrder">주문</a></li>
		<li><a href="${pageContext.request.contextPath}/myPage/myWrite">자유게시판</a></li>
		<li><a href="${pageContext.request.contextPath}/myPage/myWrite2">팁게시판</a></li>
		<li><a href="${pageContext.request.contextPath}/myPage/myWrite3">후기게시판</a></li>
		<%-- <li>
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
		</li> --%>
		<li><a href="${pageContext.request.contextPath}/myPage/pointList">포인트</a></li>
		<li><a href="${pageContext.request.contextPath}/myPage/myQna">내QnA</a></li>	
	</ul>
</nav>