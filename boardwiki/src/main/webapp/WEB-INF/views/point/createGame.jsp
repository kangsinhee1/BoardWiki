<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="/js/createGame.js"></script>
<section class="page-top-section set-bg" data-setbg="/img/page-top-bg/4.jpg" style="background-image: url(&quot;/img/page-top-bg/4.jpg&quot;);">

<h1>게임 생성</h1>
</section>
<form id="createGameForm">
    <label for="gameTitle">주제:</label> 
    <input type="text" id="gameTitle" name="poiG_content" required><br><br>
    <div id="choicesContainer">
        <label>선택지:</label><br>
        <div class="choice">
            <input type="text" name="choices" required>
        </div>
        <div class="choice">
            <input type="text" name="choices" required>
        </div>
    </div>
    <button type="button" id="addChoice">선택지 추가</button><br><br>
    
    <button type="submit">생성</button>
</form>
