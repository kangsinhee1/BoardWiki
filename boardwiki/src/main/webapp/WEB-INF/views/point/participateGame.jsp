<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="/js/participateGame.js"></script>
<style>
    .blog-page {
        min-height: 800px;
    }
    .qqttqq {
        font-size: 18px;
        color: white;
        display: inline-block;
        width: 400px;
    }
    .q1 {
        color: white;
        position: absolute;
        top: 10px;
        right: 10px;
        font-size: 18px;
    }
    label {
        color: white;
        font-size:18px;
    }
    h1{
    width:800px;
    }
    .option-button {
    	text-align:center;
        display: inline-block;
        padding: 10px 20px;
        margin: 5px;
        border: 2px solid white;
        border-radius: 5px;
        cursor: pointer;
        transition: background-color 0.3s, color 0.3s;
        vertical-align: middle;
    }
    .option-button.selected {
        background-color: white;
        color: red;
    }
    
    .option-button.selected2{
    	pointer-events: none;
    }
    .option-button:hover {
        background-color: lightgray;
    }
    input[type="radio"] {
        display: none;
    }
    #participateGameForm {
        margin-top: 30px;
    }
    .bet-info {
        color: white;
        display: inline-block;
        vertical-align: middle;
        margin-left: 10px;
    }
    .ws{
    	text-align:right;
    	margin-top: 20px;
    }
    .ws button{
    	margin-left: 10px;
    }
    input[type="number"] {
        border-radius: 5px;
        border: 2px solid white;
        padding: 5px;
        font-size: 16px;
        outline: none;
        -moz-appearance: textfield; /* Firefox */
    }
    input[type="number"]::-webkit-inner-spin-button,
    input[type="number"]::-webkit-outer-spin-button {
        -webkit-appearance: none;
        margin: 0;
    }
</style>
<script>
    $(document).ready(function() {
        $('.option-button').click(function() {
            $('.option-button').removeClass('selected');
            $(this).addClass('selected');
            $(this).find('input[type="radio"]').prop('checked', true);
        });
    });
</script>

<section class="page-top-section set-bg" data-setbg="/img/page-top-bg/4.jpg" style="background-image: url(&quot;/img/page-top-bg/4.jpg&quot;);">
    <div class="page-info">
        <h2>quiz</h2>
        <div class="site-breadcrumb">
            <a href="${pageContext.request.contextPath}/item/item_main">Home</a>/<a href="${pageContext.request.contextPath}/pointgame/list">quiz</a>/<span>${game.poiG_content}</span>
        </div>
    </div>
</section>
<section class="blog-page">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="page-main">
                    <h1>${game.poiG_content}</h1>
                    <div class="q1">현재 걸린 총 포인트 : ${total}</div>
                    <form id="participateGameForm">
                        <input type="hidden" id="gameId" name="gameId" value="${game.poiG_num}">
                        <c:forEach var="option" items="${list}">
                            <div>
                                <div class="qqttqq option-button <c:if test='${option.poiO_num == point.poiO_num}'>selected</c:if> <c:if test='${point!=null}'>selected2</c:if>">
                                	
                                    <input type="radio" id="choice_${option.poiO_num}" name="choice" value="${option.poiO_num}" required>
                                    
                                    ${option.poiO_content}
                                    <input type="hidden" id="poiG_num" name="poiG_num" value="${option.poiG_num}">
                                </div>
                                <div class="bet-info">선택지에 걸린 총 포인트 : ${option.bet_point}</div>
                            </div>
                        </c:forEach>
                        <div class="ws">
                        <c:if test="${point==null}">
                        <label for="betPoints">배팅할 포인트:</label> 
                        <input type="number" id="betPoints" name="betPoints" required>
                        <button type="submit">배팅 완료</button>
                        </c:if>
                        <c:if test="${point!=null}">
                        <label for="betPoints">배팅한 포인트:${point.bet_point}</label> 
                        </c:if>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>