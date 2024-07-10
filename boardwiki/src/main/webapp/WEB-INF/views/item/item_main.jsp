<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<div class="game-main">
    <div class="game topic">
        <h2 class="big-name">인기 게임</h2>
           <div class="small-name">
           <c:forEach var="item" items="${list}">
               <div class="big-box" style="display:inline-block;vertical-align:top;">
                   <div class="image-box" style="display:inline-block;vertical-align:top;">
                       <img onclick="location.href='${pageContext.request.contextPath}/item/item_detail?item_num=${item.item_num}'" src="${item.item_image}" width="180" height="180">
                   </div>
                   <div class="text-box" style="display:inline-block;vertical-align:top;">
                       <a>${item.item_name}</a><br>
                       <a>${item.minplayers}~${item.maxplayers}명</a><br>
                       <a>순위:${item.item_rank}</a><br>
                       <a>평점:${item.item_average}</a>
                   </div>
               </div>
           </c:forEach>
           </div>
        
        <h2 class="big-name">최고 평점</h2>
           <div class="small-name">
           <c:forEach var="item" items="${list2}">
               <div class="big-box" style="display:inline-block;vertical-align:top;">
               <div class="image-box" style="display:inline-block;vertical-align:top;">
                   <img onclick="location.href='${pageContext.request.contextPath}/item/item_detail?item_num=${item.item_num}'" src="${item.item_image}" width="180" height="180">
               </div>
               <div class="text-box" style="display:inline-block;vertical-align:top;">
                   <a>${item.item_name}</a><br>
                   <a>${item.minplayers}~${item.maxplayers}명</a><br>
                   <a>순위:${item.item_rank}</a><br>
                   <a>평점:${item.item_average}</a>
               </div>
               </div>
           </c:forEach>
           </div>
           <div class="small-name">
        <!-- 
        <h2 class="big-name">신작 게임</h2>
           <c:forEach var="item_start" items="${list}">
               <div class="big-box" style="display:inline-block;vertical-align:top;">
               <div class="image-box" style="display:inline-block;vertical-align:top;">
                   <img onclick="location.href='${pageContext.request.contextPath}/item/item_detail?item_num=${item.item_num}'" src="${item.item_image}" width="180" height="180">
               </div>
               <div class="text-box" style="display:inline-block;vertical-align:top;">
                   <a>${item.item_name}</a><br>
                   <a>${item.minplayers}~${item.maxplayers}명</a><br>
                   <a>순위:${item.item_rank}</a><br>
                   <a>평점:${item.item_average}</a>
               </div>
               </div>
           </c:forEach>
           </div>
        -->
       </div>
   </div>
</div>