<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<h2 class="big-name">${item.item_name}</h2>
<div>
	<div class="big-box1" style="display: inline-block; vertical-align: top;">
		<div class="image-box1"
			style="display: inline-block; vertical-align: top;">
			<img src="${item.item_image}" width="180" height="180">
		</div>
		<div class="middle-box1" style="display: inline-block; vertical-align: top;">
			<div class="text-box1"
				style="display: inline-block; vertical-align: top;">
				<a>장르:${item.item_genre}</a><br> <a>${item.minplayers}~${item.maxplayers}명</a><br>
				<a>순위:${item.item_rank}</a><br> <a>평점:${item.item_average}</a>
			</div>
			<div class="text-box2" style="display: inline-block; vertical-align: top;">
				<a>${item.item_name}</a><br> <a>${item.minplayers}~${item.maxplayers}명</a><br>
				<a>순위:${item.item_rank}</a><br> <a>평점:${item.item_average}</a>
				<button>바로구매</button>
				<button>장바구니</button>
			</div>
		</div>
	</div>
	<div class="big-box2">
	    <a>${item.description}</a>
	    <button>바로구매</button>
		<button>장바구니</button>
	</div>
</div>