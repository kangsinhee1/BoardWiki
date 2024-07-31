<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
			<c:if test="${user == null}">
<div class="result-display">
${logout}<br>
<button onclick="window.close()">닫기</button>
</div>
</c:if>
<c:if test="${user != null}">
				<c:if test="${count == 0}">
					<div class="result-display">표시할 게시물이 없습니다.</div>
				</c:if>
				<c:if test="${count > 0}">
					<div class="game-main">
						<h2>유저용 미션 목록</h2>

						<table id="mission-list">
							<thead>
								<tr>
									<th>내용</th>
									<th>포인트</th>
									<th>유저</th>
									<th>날짜</th>
									<th>버튼</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="mission" items="${list}">
									<tr>
										<td class="align-center">${mission.mis_content}</td>
										<td class="align-center">${mission.mis_point}</td>
										
										<td class="align-center">${user.mem_nickName}</td>
										<td class="align-center">${mission.mis_date}</td>
										<td>
										<c:if test="${mission.mis_status == 1}">
											 <button class="delete-mission" data-mis-num="${mission.mis_num}" data-mis-point="${mission.mis_point}">취소</button>
										</c:if>
										<c:if test="${mission.mis_status == 2}">
											<button class="success-mission" data-mis-num="${mission.mis_num}" data-mis-point="${mission.mis_point}">성공</button>
                							<button class="fail-mission" data-mis-num="${mission.mis_num}" data-mis-point="${mission.mis_point}">실패</button>
										</c:if>
										<c:if test="${mission.mis_status == 3}">
											<p class="font-white">성공</p>
										</c:if>
										<c:if test="${mission.mis_status == 4}">
											<p class="font-white">실패</p>
										</c:if>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<div class="align-center">${page}</div>
				</c:if>
				</c:if>
				
			</div>
		</div>
	</div>
</section>
<style>
.align-center{
text-align: center;
}
</style>