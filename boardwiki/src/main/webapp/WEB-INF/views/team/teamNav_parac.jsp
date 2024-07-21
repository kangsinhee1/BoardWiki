<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- Add JavaScript for content toggling -->

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
<div class="align-center">
	<nav class="navbar">
        <div class="navbar-container">
            <a href="#" class="navbar-logo ">내가 신청한 모임</a>
            <ul class="navbar-menu">
                <c:forEach var="team" items="${list3}">
                    <li class="navbar-item" id="navbar-requested"><a href="#" class="navbar-link">${team.tea_name}</a></li>
                </c:forEach>
            </ul>
        </div>
    </nav>
    <nav class="navbar">
        <div class="navbar-container">
            <a href="#" class="navbar-logo">내가 가입한 모임</a>
            <ul class="navbar-menu">
                <c:forEach var="team" items="${list}">
                    <li class="navbar-item" id="navbar-applied"><a href="${pageContext.request.contextPath}/team/teamBoardUser?tea_num=${team.tea_num}" class="navbar-link">${team.tea_name}</a></li>
                </c:forEach>
            </ul>
        </div>
    </nav>
    <nav class="navbar">
        <div class="navbar-container">
            <a href="#" class="navbar-logo">내가 관리하는 모임</a>
            <ul class="navbar-menu">
                <c:forEach var="team" items="${list2}">
                    <li class="navbar-item" id="navbar-authorized"><a href="${pageContext.request.contextPath}/team/teamBoardAdmin?tea_num=${team.tea_num}" class="navbar-link">${team.tea_name}</a></li>
                </c:forEach>
            </ul>
        </div>
    </nav>
      <nav class="navbar">
        <div class="navbar-container">
            <a href="#" class="navbar-logo">비활성화된 모임</a>
            <ul class="navbar-menu">
            <c:forEach var="team" items="${list5}">
                <li class="navbar-item" id="navbar-authorized"><a href="teamBoardAdmin?tea_num=${team.tea_num}" class="navbar-link">${team.tea_name}</a></li>
            </c:forEach>
            </ul>
        </div>
    </nav>
    
</div>

