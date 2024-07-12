<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<h2 class="big-name">${item.item_name}</h2>
<div>
	<div class="big-box1">
		<div class="midle-box1" style="display: inline-block; vertical-align: top;">
			<div class="image-box1"
				style="display: inline-block; vertical-align: top;">
				<img src="${item.item_image}" width="180" height="180">
			</div>
			<div class="small-box1" style="display: inline-block; vertical-align: top;">
				<div class="text-box1" style="display: inline-block; vertical-align: top;">
					<p>장르:${item.item_genre}</p>
					<p>가격:${item.item_price}원</p>
					<p>출시연도:${item.item_year}년</p>
				</div>
				<div class="text-box2" style="display: inline-block; vertical-align: top;">
				    <p>최소연령:${item.minage}세</p>
					<p>참여인원:${item.minplayers}~${item.maxplayers}명</p>
					<p>플레이 타임:${mintime}~${maxtime}시간</p>
				</div>
				<div class="text-box3" style="display: inline-block; vertical-align: top;">
					<p>순위:${item.item_rank}위</p>
					<p>평점:${item.item_average}점</p>
					<p>재고:${item.item_stock}개</p>
					<button>바로구매</button>
					<button id="cart_button" data-num="${cart.mem_num}">장바구니</button>
				</div>
			</div>
		</div>
	</div>
	<div class="big-box2">
	    <div class="midle-box2">
	        <button>간단설명</button>
	        <button>대여</button>
		    <button>중고거래</button>
		</div>
		<div class="midle-box3">
		    <a>${item.description}</a>
		</div>
        <button>목록</button>
     </div>
</div>