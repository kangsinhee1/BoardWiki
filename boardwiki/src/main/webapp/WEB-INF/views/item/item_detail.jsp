<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<div class="game-main">
    <div class="game topic">
        <h2 class="big-name">${item.item_name}</h2>
           <div class="small-name">
           <c:forEach var="item_detail" items="${detail}">
               <div class="big-box1" style="display:inline-block;vertical-align:top;">
               <div class="image-box1" style="display:inline-block;vertical-align:top;">
                   <img onclick="location.href='${pageContext.request.contextPath}/item/item_detail?item_num=${item.item_num}'" src="${item.item_image}" width="180" height="180">
               </div>
               <div class="text-box1" style="display:inline-block;vertical-align:top;">
                   <a>${item.item_name}</a><br>
                   <a>${item.minplayers}~${item.maxplayers}명</a><br>
                   <a>순위:${item.item_rank}</a><br>
                   <a>평점:${item.item_average}</a>
               </div>
               <div class="text-box2" style="display:inline-block;vertical-align:top;">
                   <a>${item.item_name}</a><br>
                   <a>${item.minplayers}~${item.maxplayers}명</a><br>
                   <a>순위:${item.item_rank}</a><br>
                   <a>평점:${item.item_average}</a>
               </div>
               </div>
           </c:forEach>
           </div>
    </div>
</div>