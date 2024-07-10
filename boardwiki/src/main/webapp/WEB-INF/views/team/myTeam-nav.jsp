<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 
 <div class="align-center">
   
  <nav class="navbar">
        <div class="navbar-container">
            <a href="#" class="navbar-logo">내가 가입한 모임</a>
            <ul class="navbar-menu">
            <c:forEach var="team" items="${list}">
                <li class="navbar-item"><a href="myteam?tea_num=${team.tea_num}" class="navbar-link">${team.tea_name}</a></li>
            </c:forEach>
            </ul>
        </div>
    </nav>
     <nav class="navbar">
        <div class="navbar-container">
            <a href="#" class="navbar-logo">내가 관리하는 모임</a>
            <ul class="navbar-menu">
            <c:forEach var="team" items="${list2}">
                <li class="navbar-item"><a href="myteam?tea_num=${team.tea_num}" class="navbar-link">${team.tea_name}</a></li>
            </c:forEach>
            </ul>
        </div>
    </nav>
    <nav class="navbar">
        <div class="navbar-container">
            <a href="#" class="navbar-logo">내가 신청한 모임</a>
            <ul class="navbar-menu">
            <c:forEach var="team" items="${list3}">
                <li class="navbar-item"><a href="myteam?tea_num=${team.tea_num}" class="navbar-link">${team.tea_name}</a></li>
            </c:forEach>
            </ul>
        </div>
    </nav>
   </div>