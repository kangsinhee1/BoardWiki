<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="/js/createGame.js"></script>
<style>
.blog-page{
min-height:800px;
}
input[type="text"] {
        border-radius: 5px;
        border: 2px solid white;
        padding: 5px;
        font-size: 16px;
        outline: none;
        margin:2px;
        -moz-appearance: textfield; /* Firefox */
        
}
input::placeholder{
		color:#CFCFCF;
}
</style>
<section class="page-top-section set-bg" data-setbg="/img/page-top-bg/4.jpg" style="background-image: url(&quot;/img/page-top-bg/4.jpg&quot;);">
<div class="page-info">
        <h2>Quiz 생성</h2>
        <div class="site-breadcrumb">
            <a href="${pageContext.request.contextPath}/item/item_main">Home</a>/<a href="${pageContext.request.contextPath}/pointgame/list">Quiz</a>/<span>Quiz 생성</span>
        </div>
    </div>
</section>
<section class="blog-page">
<div class="container">
	<div class="row">
		<div class="col-lg-12">
		<div class="page-main">
<form id="createGameForm">
    <label for="gameTitle" class="font-white">주제:</label><br>	
    <input type="text" id="gameTitle" name="poiG_content" placeholder="주제를 입력해주세요" required><br><br>
    <div id="choicesContainer">
        <label class="font-white">선택지:</label><br>
        <div class="choice">
            <input type="text" name="choices" placeholder="선택지를 입력해주제요" required>
        </div>
        <div class="choice">
            <input type="text" name="choices" placeholder="선택지를 입력해주제요" required>
        </div>
    </div>
    <button type="button" id="addChoice">선택지 추가</button><button type="button" id="addChoice2">선택지 삭제</button><br>
    
    <button type="submit">생성</button>
</form>
</div>
</div>
</div>
</div>
</section>
