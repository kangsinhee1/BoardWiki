<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="/js/participateGame.js"></script>

<h1>Participate in Game</h1>
<h2>${game.poiG_content}</h2>
<form id="participateGameForm">
	<c:forEach var="option" items="${options}">
		<div>
			<input type="radio" name="choice" value="${option.poiO_num}" required>
			${option.poiO_content}
		</div>
	</c:forEach>
	<label for="betPoints">Points to bet:</label> <input type="number"
		id="betPoints" name="betPoints" required><br>
	<br>

	<button type="submit">Place Bet</button>
</form>

