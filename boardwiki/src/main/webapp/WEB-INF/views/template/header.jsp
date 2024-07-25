<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="/css/main.css" type="text/css"/>

<!-- Header section -->
<meta charset="UTF-8">
<header class="header-section">
    <div class="header-warp">
        <div class="align-center">
            <div class="search-bar">
                <form class="form-inline" action="mainList" method="get">
                    <a class="navbar-brand"></a>
                    <input id="main_search" class="form-control mr-sm-2" style="width: 500px;" type="search"
                           placeholder="Search" aria-label="Search" name="keyword1" id="keyword1" value="${param.keyword1}">
                    <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
                </form>
            </div>
        </div>
        <div class="header-social d-flex justify-content-end">
          	<c:if test="${user.mem_auth!=9 && user != null}">
           		<a href="${pageContext.request.contextPath}/myPage/myPage">MyPage</a>
          	</c:if>
          	<c:if test="${user.mem_auth==9 && user != null}">
            	<a href="${pageContext.request.contextPath}/admin/adminPage">관리자 페이지</a>
          	</c:if>
	        <a href="${pageContext.request.contextPath}/cart/cart" class="cart">장바구니</a>
	        <a href="${pageContext.request.contextPath}/attendance/attendance">출석체크</a>
            <c:if test="${user.mem_auth!=9 && user != null}">
            </c:if>
        </div>
        <div class="header-bar-warp d-flex">
           	<a href="${pageContext.request.contextPath}/main/main" class="site-logo">
                <img src="/img/logo.png" alt="">
            </a> 
            <nav class="top-nav-area w-100">
            	<c:if test="${empty user }">
                <div class="user-panel">
                    <a href="${pageContext.request.contextPath}/member/login">Login</a> / <a href="${pageContext.request.contextPath}/member/memberRegister">Register</a>
                </div>
                </c:if>
            	<c:if test="${!empty user }">
                <div class="user-panel">
                    <a href="${pageContext.request.contextPath}/member/logout">LogOut</a>
                </div>
                </c:if>
                <ul class="main-menu primary-menu">
                    <li><a href="#">게임메인</a>
                        <ul class="sub-menu">
                            <li><a href="${pageContext.request.contextPath}/item/item_main">게임메인</a></li>
                            <li><a href="${pageContext.request.contextPath}/rent/list">게임 대여</a></li>
                            <li><a href="${pageContext.request.contextPath}/rulebook/rulebookList">룰북</a></li>
                        </ul>
                    </li>
                    <li><a href="#">커뮤니티</a>
                        <ul class="sub-menu">
                            <li><a href="${pageContext.request.contextPath}/board/list?boa_category=1">자유게시판</a></li>
                            <li><a href="${pageContext.request.contextPath}/tnrboard/tnrboardList?tnr_category=1">팁게시판</a></li>
                            <li><a href="${pageContext.request.contextPath}/tnrboard/tnrboardList?tnr_category=2">후기</a></li>
                           <c:if test="${user.mem_auth==9 && user != null}">
            				<li><a href="${pageContext.request.contextPath}/team/teamListAdmin">모임게시판(관리자)</a></li>
          					</c:if>
          					 <c:if test="${user.mem_auth!=9}">
                            <li><a href="${pageContext.request.contextPath}/team/teamList">모임게시판</a></li>
                            </c:if>
                            <li><a href="${pageContext.request.contextPath}/used/usedList">중고게시판</a></li>
                        </ul>
                    </li>
                    <li><a href="#">공지</a>
                        <ul class="sub-menu">
                            <li><a href="${pageContext.request.contextPath}/board/list2?boa_category=4">공지</a></li>
                            <li><a href="${pageContext.request.contextPath}/board/list2?boa_category=5">QnA</a></li>
                        </ul>
                    </li>
                    <li><a href="#">스트리밍</a>
                        <ul class="sub-menu">
                            <li><a href="${pageContext.request.contextPath}/pointgame/list">실시간 보드게임</a></li>
                            <li><a href="${pageContext.request.contextPath}/streaming/broadcasts">스트리밍</a></li>
                        </ul>
                    </li>
                    <li><a href="#">대회</a>
                        <ul class="sub-menu">
                            <li><a href="${pageContext.request.contextPath}/contest/contestList">대회</a></li>
                        </ul>
                    </li>
                </ul>
            </nav>
        </div>
    </div>
</header>
<!-- Header section end -->

<!-- 상단 끝 -->







