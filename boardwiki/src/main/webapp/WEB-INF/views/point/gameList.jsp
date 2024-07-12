<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<h1>Game List</h1>
<ul id="gameList">
    <c:forEach var="game" items="${list}">
    	<c:if test="${game.poiG_end == null}">
        <li>
            <a href="/pointgame/participate?poiG_num=${game.poiG_num}">${game.poiG_content}</a>
        </li>
        </c:if>
    </c:forEach>
</ul>
<button id="createGameButton">Create Game</button>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $('#createGameButton').click(function() {
        window.location.href = '/pointgame/create';
    });
</script>
