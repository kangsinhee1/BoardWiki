<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
<!-- 게시판 목록 시작 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<!-- Page top section -->
<section class="page-top-section set-bg" data-setbg="/img/page-top-bg/4.jpg">
    <div class="page-info">
        <h2>Contact</h2>
        <div class="site-breadcrumb">
            <a href="">Home</a>  /
            <span>Contact</span>
        </div>
    </div>
</section>
<!-- Page top end-->

<div class="page-main">
    <h2>대회</h2>
    <form action="contestList" id="search_form" method="get">
        <ul class="search">
            <li>
                <select name="keyfield" id="keyfield" class="form-control">
                    <option value="1" <c:if test="${param.keyfield == 1}">selected</c:if>>대회명</option>
                    <option value="2" <c:if test="${param.keyfield == 2}">selected</c:if>>지역</option>
                </select>
            </li>
            <li>
                <input type="search" name="keyword" class="form-control"
                  id="keyword" value="${param.keyword}">
            </li>
            <li>
                <input type="submit" value="찾기" class="btn btn-primary">
            </li>
        </ul> 
        <div class="align-right">
            <select id="order" name="order" class="form-control">
                <option value="1" <c:if test="${param.order == 1}">selected</c:if>>최신순</option>
                <option value="2" <c:if test="${param.order == 2}">selected</c:if>>조회순</option>
                <option value="3" <c:if test="${param.order == 3}">selected</c:if>>진행중대회</option>
                <option value="4" <c:if test="${param.order == 4}">selected</c:if>>종료된대회</option>
            </select>
            <script type="text/javascript">
                $('#order').change(function(){
                    location.href='contestList?keyfield='
                                 +$('#keyfield').val()+'&keyword='
                                 +$('#keyword').val()+'&order='
                                 +$('#order').val();
                });
            </script>
            <c:if test="${user.mem_auth==9}">
                <input type="button" value="글쓰기" 
                    onclick="location.href='contestWrite'" class="btn btn-primary">
            </c:if>
        </div>                     
    </form>
    <c:if test="${count == 0}">
    <div class="alert alert-info">표시할 게시물이 없습니다.</div>
    </c:if>
    <c:if test="${count > 0}">
    <table class="chart-table">
        <thead>
        <tr>
            <th>번호</th>
            <th width="400">제목</th>
            <th>작성일</th>
            <th>조회수</th>
            <th>진행여부</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="contest" items="${list}">
        <tr>
            <td class="align-center">${contest.con_num}</td>
            <td class="align-left"><a href="contestDetail?con_num=${contest.con_num}">(${fn:substring(contest.con_address1,0,2)}) ${contest.con_name}</a></td>
            <td class="align-center">${contest.con_rdate}</td>
            <td class="align-center">${contest.con_hit}</td>
            <c:if test="${contest.con_status==0}">
            	<td>진행중</td>
            </c:if>
            <c:if test="${contest.con_status==1}">
            	<td>종료</td>
            </c:if>
            <c:if test="${contest.con_status==2}">
            	<td>진행예정</td>
            </c:if>
        </tr>
        </c:forEach>
        </tbody>
    </table>
    <div class="align-center">${page}</div>
    </c:if>    
</div>
<!-- 게시판 목록 끝 -->

