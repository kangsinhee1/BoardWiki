<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<div class="game-main">
    
    <div class="game topic">
        <h2 class="big-name">인기 게임</h2>
           <div class="small-name">
           <c:forEach var="item" items="${list}">
               <div>
                   <img src="${item.item_image}" width="200" height="200">
                   <p>${item.item_name}</p>
                   <p>${item.minplayers}~${item.maxplayers}명</p>
                   <p>순위:${item.item_rank}</p>
                   <p>평점:${item.item_average}</p>
               </div>
           </c:forEach>
           </div>
    </div>
    
  
</div>