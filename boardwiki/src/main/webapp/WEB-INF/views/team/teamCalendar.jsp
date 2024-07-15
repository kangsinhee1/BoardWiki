<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!-- 게시판 목록 시작 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/teamBoard.js"></script>
<div class="page-main">
    <div class="align-right">
        모임 일정 설정
        <input type="date" id="meetingDate" class="submit-date" value="${tea_time}" min="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>">
        <input type="text" id="meetingDateDisplay" value="모임 일정 : ${tea_time}" readonly="readonly">
        <button id="cancelMeeting" type="button">모임 취소</button>
    </div>
    <h2 class="align-center"> (${tea_name}) 모임 일정 / 참석 회원 목록</h2>
    <c:if test="${count == 0}">
        <div class="result-display">회원이 없습니다.</div>
    </c:if>
    <c:if test="${count > 0}">
        <table class="striped-table">
            <tr>
                <th>회원 닉네임</th>
                <th>참석 여부</th>
            </tr>
            <c:forEach var="team" items="${list}">
                <tr>
                    <td class="align-center">${team.mem_nickname}</td>
                    <td class="align-center">
                        <c:choose>
                            <c:when test="${team.teaA_attend == 1}">참석</c:when>
                            <c:when test="${team.teaA_attend == 0}">불참</c:when>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>
        </table>
        <div class="align-center">${page}</div>
    </c:if>
</div>
	