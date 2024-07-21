<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<section class="page-top-section set-bg" data-setbg="/img/page-top-bg/4.jpg" style="background-image: url(&quot;/img/page-top-bg/4.jpg&quot;);">
<h1>Game List</h1>
</section>
<ul id="gameList">
    <c:forEach var="game" items="${list}">
    	<c:if test="${game.poiG_end == null}">
        <li>
            <a href="/pointgame/participate?poiG_num=${game.poiG_num}">${game.poiG_content}</a>
        </li>
        </c:if>
    </c:forEach>
</ul>
<button id="createGameButton">게임 생성</button>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $('#createGameButton').click(function() {
        window.location.href = '/pointgame/create';
    });
</script>
