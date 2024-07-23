<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    .dropdown {
        position: relative;
        display: inline-block;
    }

    .dropdown-content {
        display: none;
        position: absolute;
        background-color: #f9f9f9;
        min-width: 160px;
        box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
        z-index: 1;
    }

    .dropdown-content a {
        color: black;
        padding: 12px 16px;
        text-decoration: none;
        display: block;
    }

    .dropdown-content a:hover {
        background-color: #f1f1f1;
    }

    .dropdown:hover .dropdown-content {
        display: block;
    }

    .dropdown:hover .dropbtn {
        background-color: #3e8e41;
    }
</style>

<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        $('.dropdown-content a').on('click', function(event) {
            event.preventDefault();
            var url = $(this).attr('href');
            window.location.href = url;
        });
    });
</script>

<div class="page-main">
    <h2>게시판 목록</h2>
    <div class="dropdown">
        <button>메뉴 선택</button>
        <div class="dropdown-content">
            <a href="list">전체</a>
            <a href="list?poi_status=1">후원</a>
            <a href="list?poi_status=2">미션후원</a>
            <a href="list?poi_status=3">포인트게임</a>
            <a href="list?poi_status=4">출석체크</a>
            <a href="list?poi_status=5">시청시간뽀너스</a>
        </div>
    </div>

    <c:if test="${count == 0}">
        <div class="result-display">표시할 게시물이 없습니다.</div>
    </c:if>

    <c:if test="${count > 0}">
        <table class="striped-table">
            <tr>
                <th>번호</th>
                <th>사용처</th>
                <th>포인트</th>
                <th>총 포인트</th>
                <th>사용일</th>
            </tr>
            <c:forEach var="point" items="${list}">
                <tr>
                    <td class="align-center">${point.poi_num}</td>
                    <td class="align-left">${point.poi_status}</td>
                    <td class="align-center">
                        <c:choose>
                            <c:when test="${point.poi_increase == 1}">
                                -${point.poi_use}
                            </c:when>
                            <c:when test="${point.poi_increase == 2}">
                                +${point.poi_use}
                            </c:when>
                        </c:choose>
                    </td>
                    <td class="align-center">
                        <c:choose>
                            <c:when test="${point.poi_increase == 1}">
                                ${point.point_total}(-${point.poi_use})
                            </c:when>
                            <c:when test="${point.poi_increase == 2}">
                                ${point.point_total}(+${point.poi_use})
                            </c:when>
                        </c:choose>
                    </td>
                    <td class="align-center">${point.poi_date}</td>
                </tr>
            </c:forEach>
        </table>
        <div class="align-center">${page}</div>
    </c:if>    
</div>