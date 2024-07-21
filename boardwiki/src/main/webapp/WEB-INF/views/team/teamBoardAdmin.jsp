<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>

	<!-- Page top section -->
<section class="page-top-section set-bg" data-setbg="/img/page-top-bg/4.jpg">
	<div class="page-info">
		<h2>모임 신청</h2>
		<div class="site-breadcrumb">
			<a href="">Home</a>  /
			<span>모임신청</span> /
			<span><a href="myTeam2"> 내 모임 보기</a></span> /
			<span><a href="teamBoardAdmin?tea_num=${tea_num}">${TEAM.tea_name}</a></span>
		</div>
	</div>
</section>
<!-- Page top end-->
<section class="blog-page">
<div class="container">
	<div class="row">
		<div class="col-lg-12">

<div class="page-main">
    <h2>(${TEAM.tea_name}) 모임 게시판</h2>
    <div class="align-right">
        <input type="button" value="모임관리" onclick="location.href='${pageContext.request.contextPath}/team/teamControl?tea_num=${tea_num}'">
    </div>
    <hr>
    <div><a href="${pageContext.request.contextPath}/chat/chatDetail?chaR_num=${chaR_num}">채팅 하기</a></div>
    <form action="teamBoardAdmin" id="search_form" method="get">
        <input type="hidden" id="tea_num" name="tea_num" value="${tea_num}">
        <ul class="search">
            <li>
                <select name="keyfield" id="keyfield">
                    <option value="1" <c:if test="${param.keyfield == 1}">selected</c:if>>제목&nbsp; </option>
                    <option value="2" <c:if test="${param.keyfield == 2}">selected</c:if>>내용&nbsp; </option>
                </select>
            </li>
            <li>
                <input type="search" name="keyword" id="keyword" value="${param.keyword}">
            </li>
            <li>
                <input id="submit2" type="submit" value="찾기">
            </li>
        </ul>

        <div class="align-right">
            <select id="order" name="order">
                <option value="1" <c:if test="${param.order == 1}">selected</c:if>>최신순&nbsp; </option>
                <option value="2" <c:if test="${param.order == 2}">selected</c:if>>조회수&nbsp; </option>
                <option value="3" <c:if test="${param.order == 3}">selected</c:if>>댓글순&nbsp; </option>
            </select>
            <input type="button" value="글쓰기" onclick="location.href='${pageContext.request.contextPath}/team/teamBoardWrite?tea_num=${tea_num}'">
        </div>
    </form>

    <c:if test="${count == 0}">
        <div class="result-display">표시할 게시물이 없습니다.</div>
    </c:if>

    <c:if test="${count > 0}">
        <table class="striped-table">
            <tr>
                <th>번호</th>
                <th>분류</th>
                <th width="400">제목</th>
                <th>작성자</th>
                <th>작성일</th>
                <th>조회수</th>
            </tr>
            <c:forEach var="team" items="${list}">
                <tr>
                    <td class="align-center">${team.teaB_num}</td>
                    <td>
                        <c:choose>
                            <c:when test="${team.teaB_category == 1}">
                                공지사항
                            </c:when>
                            <c:when test="${team.teaB_category == 2}">
                                잡담
                            </c:when>
                            <c:when test="${team.teaB_category == 3}">
                                후기
                            </c:when>
                            <c:otherwise>
                                기타
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td class="align-left">
                        <a href="teamBoardDetail?teaB_num=${team.teaB_num}">
                            ${team.teaB_title}(${team.teaR_cnt})
                        </a>
                    </td>
                    <td class="align-center">${team.mem_nickname}</td>
                    <td class="align-center">${fn:substring(team.teaB_rdate, 0, 10)}</td>
                    <td class="align-center">${team.teaB_hit}</td>
                </tr>
            </c:forEach>
        </table>
        <div class="align-center">${page}</div>
    </c:if>
</div>
</div>
</div>
</div>
</section>

<script type="text/javascript">
    $(document).ready(function() {
        $('#search_form').submit(function(event) {
            event.preventDefault();
            location.href = 'teamBoardAdmin?tea_num=' + $('#tea_num').val() +
                '&keyfield=' + $('#keyfield').val() +
                '&keyword=' + $('#keyword').val() +
                '&order=' + $('#order').val();
        });

        $('#order').change(function() {
            location.href = 'teamBoardAdmin?tea_num=' + $('#tea_num').val() +
                '&keyfield=' + $('#keyfield').val() +
                '&keyword=' + $('#keyword').val() +
                '&order=' + $('#order').val();
        });
    });
</script>
