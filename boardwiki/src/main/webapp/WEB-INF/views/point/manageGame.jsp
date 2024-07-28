<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="/js/manageGame.js"></script>
<section class="blog-page">
<div class="container">
	<div class="row">
		<div class="col-lg-12">
		<div class="page-main">
<section class="page-top-section set-bg" data-setbg="/img/page-top-bg/4.jpg" style="background-image: url(&quot;/img/page-top-bg/4.jpg&quot;);">
<h1>게임 관리</h1>
</section>

<div id="gameManagementContainer">
    <c:forEach var="game" items="${createdGames}">
    <c:if test="${game.poiG_end==null}">
        <div class="game">
            <h2>${game.poiG_content}</h2>
            <button class="cancelGameButton" data-game-id="${game.poiG_num}">게임 취소</button>
            <div>
                <label for="winningOption_${game.poiG_num}">정답 선택:</label>
                <select class="winningOption" id="winningOption_${game.poiG_num}">
                    <c:forEach var="option" items="${game.options}">
                        <option value="${option.poiO_num}">${option.poiO_content}</option>
                    </c:forEach>
                </select>
                <button class="selectWinnerButton" data-game-id="${game.poiG_num}">게임 종료</button>
            </div>
        </div>
     </c:if>
</c:forEach>
</div>
</div>
</div>
</div>
</div>
</section>
