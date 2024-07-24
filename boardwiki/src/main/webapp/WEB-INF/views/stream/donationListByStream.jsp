<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="${pageContext.request.contextPath}/js/boradchat.js"></script>

<h2>도네이션 목록 (방송 기준)</h2>
	<c:if test="${count == 0}">
        <div class="result-display">표시할 게시물이 없습니다.</div>
    </c:if>

    <c:if test="${count > 0}">
        <table class="striped-table" id="donation-list2">
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
        <div class="align-center">${page}</div>
    </c:if>