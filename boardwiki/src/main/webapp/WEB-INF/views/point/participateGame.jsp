<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="/js/participateGame.js"></script>

<h2>${game.poiG_content}</h2>
<form id="participateGameForm">
    <input type="hidden" id="gameId" name="gameId" value="${game.poiG_num}">
    <c:forEach var="option" items="${list}">
        <div>
            <input type="radio" name="choice" value="${option.poiO_num}" required>
            ${option.poiO_content}
            <input type="hidden" id="poiG_num" name="poiG_num" value="${option.poiG_num}">
        </div>
    </c:forEach>
    <label for="betPoints">Points to bet:</label> 
    <input type="number" id="betPoints" name="betPoints" required><br><br>
    <button type="submit">Place Bet</button>
</form>