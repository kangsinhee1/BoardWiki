<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="/js/manageGame.js"></script>
<h1>Manage Your Games</h1>
<div id="gameManagementContainer">
    <c:forEach var="game" items="${createdGames}">
        <div class="game">
            <h2>${game.poiG_content}</h2>
            <button class="cancelGameButton" data-game-id="${game.poiG_num}">Cancel Game</button>
            <div>
                <label for="winningOption_${game.poiG_num}">Select Winning Option:</label>
                <select class="winningOption" id="winningOption_${game.poiG_num}">
                    <c:forEach var="option" items="${game.options}">
                        <option value="${option.poiO_num}">${option.poiO_content}</option>
                    </c:forEach>
                </select>
                <button class="selectWinnerButton" data-game-id="${game.poiG_num}">Select Winner</button>
            </div>
        </div>
</c:forEach>
</div>