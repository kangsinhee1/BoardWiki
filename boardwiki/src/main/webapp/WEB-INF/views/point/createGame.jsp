<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="/js/createGame.js"></script>
<h1>Create Game</h1>
<form id="createGameForm">
    <label for="gameTitle">Title:</label> 
    <input type="text" id="gameTitle" name="poiG_content" required><br><br>
    <div id="choicesContainer">
        <label>Choices:</label><br>
        <div class="choice">
            <input type="text" name="choices" required>
        </div>
        <div class="choice">
            <input type="text" name="choices" required>
        </div>
    </div>
    <button type="button" id="addChoice">Add Choice</button><br><br>
    <button type="submit">Create Game</button>
</form>
