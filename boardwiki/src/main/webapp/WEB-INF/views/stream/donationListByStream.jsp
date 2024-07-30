<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="${pageContext.request.contextPath}/js/boradchat.js"></script>
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
<section class="blog-page">
<div class="container">
<div class="row">
		<div class="col-lg-12">
		<div class="game-main">
<h2>도네이션 목록 (방송 기준)</h2>
	<c:if test="${count == 0}">
        <div class="result-display">표시할 게시물이 없습니다.</div>
    </c:if>

    <c:if test="${count > 0}">
    <div class="chart-table">
        <table  id="donation-list2">
            <tr>
                <th>내용</th>
                <th>포인트</th>
                <th>유저</th>
                <th>날짜</th>
            </tr>
            <c:forEach var="donation" items="${list}">
                <tr>
                    <td class="align-center">${donation.don_content}</td>
                    <td class="align-center">${donation.don_point}</td>
                    <td class="align-center">${donation.mem_nickName}</td>
                    <td class="align-center">${donation.don_date}</td>
                </tr>
            </c:forEach>
        </table>
        </div>
        <div class="align-center">${page}</div>
    </c:if>
    </div>
    
    </div>
    </div>
    </div>
    </section>
    <style>
.align-center{
text-align: center;
}
</style>