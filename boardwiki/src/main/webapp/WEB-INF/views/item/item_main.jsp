<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<div class="game-main">
    <div class="game topic">
        <h2 class="big-name">인기 게임</h2>
           <div class="small-name">
               <img src="${item.item_image}">
               <a>${item.item_name}</a><br>
               <a>${item.minplayers}~${item.maxplayers}명</a><br>
               <a>순위:${item.item_rank}</a><br>
               <a>평점:${item.item_average}</a>
           </div>
    </div>
    <div class="game topic">
        <h2 class="big-name">최고 평점</h2>
           <div class="small-name">
               <img src="${item.item_image}">
               <a>${item.item_name}</a><br>
               <a>${item.minplayers}~${item.maxplayers}명</a><br>
               <a>순위:${item.item_rank}</a><br>
               <a>평점:${item.item_average}</a>
           </div>
    </div>
    <div class="game topic">
        <h2 class="big-name">신작 게임</h2>
           <div class="small-name">
               <img src="${item.item_image}">
               <a>${item.item_name}</a><br>
               <a>${item.minplayers}~${item.maxplayers}명</a><br>
               <a>순위:${item.item_rank}</a><br>
               <a>평점:${item.item_average}</a>
           </div>
    </div>
</div>