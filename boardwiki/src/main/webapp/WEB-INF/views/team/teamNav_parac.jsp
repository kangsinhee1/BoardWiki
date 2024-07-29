<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- Add JavaScript for content toggling -->
	<div class="widget-item">
	
<div class="categories-widget">
	
	
           <h5 class="widget-title">내가 신청한 모임</h5>
            	<ul>
                <c:forEach var="team" items="${list3}">
                    <li><a href="#" class="navbar-link">-${team.tea_name}-</a></li>
                </c:forEach>
             </ul>
              <h5 class="widget-title">내가 관리하는 모임</h5>
             <ul>
                <c:forEach var="team" items="${list2}">
                    <li ><a href="${pageContext.request.contextPath}/team/teamBoardAdmin?tea_num=${team.tea_num}" >-${team.tea_name}-</a></li>
                </c:forEach>
             </ul>
       	<h5 class="widget-title">내가 가입한 모임</h5>
             <ul>
                <c:forEach var="team" items="${list}">
                    <li ><a href="${pageContext.request.contextPath}/team/teamBoardUser?tea_num=${team.tea_num}" >-${team.tea_name}-</a></li>
                </c:forEach>
             </ul>
      <h5 class="widget-title">비활성화된 모임</h5>
            <ul >
            <c:forEach var="team" items="${list5}">
                <li ><a href="teamBoardAdmin?tea_num=${team.tea_num}">-${team.tea_name}-</a></li>
            </c:forEach>
            </ul>   
</div>
</div>