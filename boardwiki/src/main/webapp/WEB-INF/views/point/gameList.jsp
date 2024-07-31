<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
.row{
min-height: 600px;
}
.wwwr{
text-align: right;
}
.sidebar-menu li {
margin-top:20px;
 height:80px;
 text-align:center;
}
.ssstt{
background-color: #503c6e;
width:800px;
display: inline-block;
color: white;
border: none;
padding: 20px 20px;
cursor: pointer;
font-size: 20px;
border-radius: 5px;
margin: 5px;
}
.qwer{
font-weight: bold;
font-size: 35px;
color: white;
text-align: center;
}
</style>

<section class="page-top-section set-bg" data-setbg="/img/page-top-bg/4.jpg" style="background-image: url(&quot;/img/page-top-bg/4.jpg&quot;);">
<div class="page-info">
<h2>Quiz 목록</h2>
<div class="site-breadcrumb">
<a href="${pageContext.request.contextPath}/item/item_main">Home</a>/ <span>Quiz</span>
</div>
</div>
</section>
<section class="blog-page">
<div class="container">
	<div class="row">
		<div class="col-lg-12">
		<div class="page-main">
		<div class="wwwr">
		<c:if test="${mem_auth == 9}">
<button id="createGameButton">Quiz 생성</button>
<button onclick="location.href='/pointgame/manageGames'">Quiz 관리</button>
</c:if>
</div>
<div class="qwer">현재 진행중인 Quiz</div>
<div class="sidebar-menu">
<ul id="gameList">
    <c:forEach var="game" items="${list}">
    	<c:if test="${game.poiG_end == null}">
        <li>
            <a class="ssstt" href="/pointgame/participate?poiG_num=${game.poiG_num}">${game.poiG_content}</a>
        </li>
        </c:if>
    </c:forEach>
</ul>
</div>
</div>
</div>
</div>
</div>
</section>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $('#createGameButton').click(function() {
        window.location.href = '/pointgame/create';
    });
</script>
