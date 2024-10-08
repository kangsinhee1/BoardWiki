<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/js/boradchat.js"></script>
<style>
input[type="number"]::-webkit-inner-spin-button,
    input[type="number"]::-webkit-outer-spin-button {
        -webkit-appearance: none;
        margin: 0;
    }
.qwe{
color:white;
margin-top:10px;
margin-bottom:10px;
}
input{
margin-bottom:10px;
} 
</style>
<section class="blog-page">
<div class="container">
<div class="row">
		<div class="col-lg-12">
		<div class="game-main">
<c:if test="${user == null}">
<div class="result-display">
${logout}<br>
<button onclick="window.close()">닫기</button>
</div>
</c:if>
<c:if test="${user != null}">
    <h2>미션 신청</h2>
    <form id="missionForm">
    <div class="qwe">(${user.mem_nickName})님의 현재 포인트 : ${point}</div>
        <label for="mission_content" class="font-white">내&nbsp;용:</label>&nbsp;&nbsp;
        <input type="text" id="mission_content" name="mission_content" required><br>
        <label for="mission_point" class="font-white">포인트:</label>
        <input type="number" id="mission_point" name="mission_point" required><br>
        <input type="hidden" id="mem_nickName" name="mem_nickName" value="${user.mem_nickName}">
        <button type="submit">미션 보내기</button>
    </form>
    <button onclick="window.close()">닫기</button>
    </c:if>
    </div>
    </div>
    </div>
    </div>
    </section>
<script>
let strNum = ${param.str_num};
$(document).ready(function() {

    function resizeWindow() {
        var section = $('section.blog-page');
        var sectionWidth = section.outerWidth();
        var sectionHeight = section.outerHeight();

        var strWidth;
        var strHeight;

        if (window.innerWidth && window.innerHeight && window.outerWidth && window.outerHeight) {
            strWidth = sectionWidth + (window.outerWidth - window.innerWidth);
            strHeight = sectionHeight + (window.outerHeight - window.innerHeight);
        } else {
            var strDocumentWidth = $(document).outerWidth();
            var strDocumentHeight = $(document).outerHeight();
            window.resizeTo(strDocumentWidth, strDocumentHeight);

            var strMenuWidth = strDocumentWidth - $(window).width();
            var strMenuHeight = strDocumentHeight - $(window).height();

            strWidth = sectionWidth + strMenuWidth;
            strHeight = sectionHeight + strMenuHeight;
        }

        // Resize the window
        window.resizeTo(strWidth, strHeight);
    }

    resizeWindow();

    // Recalculate on window resize just in case
    $(window).resize(function() {
        resizeWindow();
    });
});
</script>