<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!-- 게시판 목록 시작 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/teamBoard.js"></script>
<!-- Page top end-->
<section class="blog-page">
<div class="container">
	<div class="row">
		<div class="col-lg-12">
<div class="page-main">
    <div class="align-right">
    <div class="font-white">모임 일정 설정 </div>
        <input type="date" id="meetingDate" class="submit-date"  data-num="${Team.tea_num}"value="${Team.tea_time}" min="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>">
        <input type="text" id="meetingDateDisplay" data-num="${Team.tea_num}" value="모임 일정 : ${Team.tea_time}" readonly="readonly">
        <button id="cancelMeeting" type="button">모임 취소</button>
    </div>
    <h2 class="align-center"> (${Team.tea_name}) 모임 일정 / 참석 회원 목록</h2>
    <c:if test="${count == 0}">
        <div class="result-display">회원이 없습니다.</div>
    </c:if>
    <c:if test="${count > 0}">
    <div class="chart-table">
        <table>
        <thead>
            <tr>
                <th>회원 닉네임</th>
                <th>참석 여부</th>
            </tr>
            </thead>
            <c:forEach var="team" items="${list}">
                <tr>
                    <td class="align-center">${team.mem_nickname}</td>
                    <td class="align-center">
                        <c:choose>
                            <c:when test="${team.teaA_attend == 0}">미정</c:when>
                            <c:when test="${team.teaA_attend == 1}">참석</c:when>
                            <c:when test="${team.teaA_attend == 2}">불참</c:when>
                        </c:choose>
                    </td>
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
	