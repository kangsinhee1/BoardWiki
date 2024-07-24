<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/js/boradchat.js"></script>

<section class="blog-page">
<div class="container">
<div class="row">
		<div class="col-lg-12">
		<div class="game-main">
<h2>유저용 미션 목록</h2>
    <c:if test="${count == 0}">
        <div class="result-display">표시할 게시물이 없습니다.</div>
    </c:if>
    <c:if test="${count > 0}">
    <div>
        <c:forEach var="mission" items="${list}">
        
            <div>
                <p class="font-white">${mission.mis_content} / ${mission.mis_point} 포인트</p>
                <c:if test="${mission.mis_status == 1}">
                    <button onclick="deleteMission(${mission.mis_num}, ${mission.mis_point})">취소</button>
                </c:if>
            </div>
            <div>
                <c:if test="${mission.mis_status == 2}">
                    <p class="font-white">수락됨</p>
                    <button onclick="updateMissionStatus(${mission.mis_num}, '3', ${mission.mis_point})">성공</button>
                    <button onclick="updateMissionStatus(${mission.mis_num}, '4', ${mission.mis_point})">실패</button>
                </c:if>
                <c:if test="${mission.mis_status == 3}">
                    <p class="font-white">성공</p>
                </c:if>
                <c:if test="${mission.mis_status == 4}">
                    <p class="font-white">실패</p>
                </c:if>
            </div>
        </c:forEach>
        <div class="align-center">${page}</div>
    </div>
    </c:if>
    </div>
    </div>
    </div>
    </div>
    </section>
    <script>
let strNum = ${param.str_num};
</script>