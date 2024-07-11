<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<h1>Game List</h1>
<ul id="gameList">
	<c:forEach var="game" items="${games}">
		<li><a href="/pointgame/participate/${game.poiG_num}">${game.poiG_content}</a></li>
	</c:forEach>
</ul>

