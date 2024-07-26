<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 대여 목록 시작 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="/css/common.css" type="text/css">
<link rel="stylesheet" href="/css/main.css" type="text/css">
<link rel="stylesheet" href="/css/rent.css" type="text/css">

<div class="page-main">
    <h2>대여 목록(관리자)</h2>
    <form action="rentListAdmin" id="search_form" method="get">
        <input type="hidden" name="item_name" value="${param.item_name}">
        
        <ul class="search">
            <li>
                <select name="keyfield" id="keyfield">
                    <option value="1" <c:if test="${param.keyfield == 1}">selected</c:if>>게임명</option>
                    <option value="2" <c:if test="${param.keyfield == 2}">selected</c:if>>ID+별명</option>
                    <option value="3" <c:if test="${param.keyfield == 3}">selected</c:if>>내용</option>
                    <option value="4" <c:if test="${param.keyfield == 4}">selected</c:if>>제목+내용</option>
                </select>
            </li>
            <li>
                <input type="search" name="keyword" id="keyword" value="${param.keyword}">
            </li>
            <li>
                <input type="submit" value="찾기">
            </li>
        </ul>
        <div class="align-right">
            <select id="order" name="order">
                <option value="1" <c:if test="${param.order == 1}">selected</c:if>>최신순</option>
                <option value="2" <c:if test="${param.order == 2}">selected</c:if>>조회수</option>
                <option value="3" <c:if test="${param.order == 3}">selected</c:if>>좋아요</option>
                <option value="4" <c:if test="${param.order == 4}">selected</c:if>>댓글수</option>
            </select>
            <script type="text/javascript">
                $('#order').change(function() {
                    location.href='rentListAdmin?category=${param.category}&keyfield='+$('#keyfield').val()+'&keyword='+$('#keyword').val()+'&order='+$('#order').val();
                });
            </script>
        </div>
    </form>
    <c:if test="${count == 0}">
        <div class="result-display">표시할 대여 목록이 없습니다.</div>
    </c:if>
    <c:if test="${count > 0}">
        <table class="striped-table">
            <tr>
                <th>대여번호</th>
                <th width="400">보드게임명</th>
                <th>대여시작일</th>
                <th>대여종료일</th>
                <th>대여기간</th>
                <th>대여회원 ID</th>
                <th>대여회원 닉네임</th>
                <th>대출/반납</th>
            </tr>
            <c:forEach var="rent" items="${list}">
                <tr>
                    <td class="align-center">${rent.rent_num}</td>
                    <td>${rent.item_name}</td>
                    <td class="align-center">${rent.rent_sdate}</td>
                    <td class="align-center">${rent.rent_edate}</td>
                    <td class="align-center">${rent.rent_period}</td>
                    <td class="align-center">${rent.mem_email}</td> <!-- 회원 Email 표시 -->
        			<td class="align-center">${rent.mem_nickname}</td> <!-- 회원 Nickname 표시 -->
                    <td class="align-center">
                        <c:choose>
                            <c:when test="${rent.rent_status == 1}">
                                <a href="${pageContext.request.contextPath}/rent/return?rent_num=${rent.rent_num}" onclick="return confirm('반납하시겠습니까?');">대여중</a>
                            </c:when>
                            <c:when test="${rent.rent_status == 2}">반납</c:when>
                            <c:otherwise>상태 불명</c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>
        </table>
        <div class="blog-pagination" style= "text-align : center">${page}</div>
    </c:if>
</div>
<!-- 대여 목록 끝 -->
