<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>

<!-- Page top section -->
<section class="page-top-section set-bg" data-setbg="/img/page-top-bg/4.jpg">
	<div class="page-info">
		<h2>게임상세</h2>
		<div class="site-breadcrumb">
			<a href="${pageContext.request.contextPath}/item/item_main">Home</a> /
			<span>Detail</span>
		</div>
	</div>
</section>
<!-- Page top end-->




	<!-- Games section -->
	<section class="games-single-page">
		<div class="container">
			
			<div class="row">
				<div class="col-xl-9 col-lg-8 col-md-7 game-single-content">
					<div class="gs-meta">boardgameGeek  /  in <a href="https://boardgamegeek.com/browse/boardgame">BGG</a></div>
						<h2 class="gs-title">${item.item_name}</h2>
					<div class="game-single-preview">
						<img src="${item.item_image}"class ="detail_img" alt="">
					</div>
					<div class="geme-social-share pt-5 d-flex">
						<p>
						 <a href="/item/item_detail?item_num=${item.item_num }">간단설명</a>
						 <a href="/rent/rent?item_num=${item.item_num}">대여</a>
						 <a href="/used/usedList?item_num=${item.item_num }">중고거래</a>
						 <a href="/tnrboard/tnrboardList?tnr_category=1&item_num=${item.item_num }">팁</a>
						 <a href="/tnrboard/tnrboardList?tnr_category=2&item_num=${item.item_num }">후기</a>
						 <a href="/rulebook/rulebookList?item_num=${item.item_num }">룰북</a>
						 <a href="/item/item_main">게임 목록</a>
						</p>
					</div>

					<h4>장르</h4>
					<p>${item.item_genre}</p>
					<h4>Description</h4>
					<p>${item.description}</p>
					
				</div>
				<div class="col-xl-3 col-lg-4 col-md-5 sidebar game-page-sideber">
					<div id="stickySidebar">
						<div class="widget-item">
							<div class="rating-widget">
								<h4 class="widget-title">Info</h4>
								<ul>
									<li>최소연령<span>${item.minage}세</span></li>
									<li>참여인원<span>${item.minplayers}~${item.maxplayers}명</span></li>
									<c:if test="${mintime == maxtime}">
									<li>플레이 타임<span>${maxtime}분</span></li>
									</c:if>
									<c:if test="${mintime != maxtime}">
									<li>플레이 타임<span>${mintime}분~${maxtime}분</span></li>
									</c:if>
									<li>출시연도<span>${item.item_year}년</span></li>
									<li>순위<span>${item.item_rank}위</span></li>
									
									
								</ul>
								<div class="rating">
									<h5><i>평점</i><span>${item.item_average}</span> / 10</h5>
								</div>
							</div>
						</div>
						<div class="widget-item">
							<div class="rating-widget">
								<h4 class="widget-title">Cart Info</h4>
								<ul>
									<li>재고<span>${item.item_stock}개</span></li>
									<li>가격<span>${item.item_price}원</span></li>
														<c:if test="${!empty member.mem_num}">
					
                <div class="text-box2" style="display: inline-block; vertical-align: top;">
                    <form id="addToCart" method="get" action="${pageContext.request.contextPath}/cart/cart">
                        <input type="hidden" name="item_num" value="${item.item_num}" />
                        <input type="hidden" name="user" value="${member.mem_num}" />
                        
                        <div class="cart_box">
                        <label class ="quantity_label" for="quantity">수량</label>
                        <input type="number" id="quantity" name="item_quantity" value="1" min="1" max="${item.item_stock}" />
                        <c:if test="${item.item_stock > 0}">
                        <button type="button" class="addToCartButton" id="addToCartButton" 
                         onclick="location.href='/cart/cart?mem_num=${member.mem_num}'">장바구니에 담기</button>
                         </c:if>
                        </div>
                    </form>
                </div>
                </c:if>
									
								</ul>
								
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Games end-->

<script type="text/javascript">
    $(document).ready(function() {
        $('#addToCartButton').click(function() {
            var item_num = $('input[name="item_num"]').val();
            var item_quantity = $('input[name="item_quantity"]').val();
            $.ajax({
                type: 'POST',
                url: '/item/addToCart',
                data: {
                    item_num: item_num,
                    item_quantity: item_quantity
                },
                dataType: 'json',
                success: function(response) {
                    alert(response.message);
                    if (response.status === 'success') {
                        window.location.href = '${pageContext.request.contextPath}/cart/cart';
                    }
                },
                error: function(xhr, status, error) {
                    alert('장바구니에 추가하는 중 오류가 발생했습니다.');
                }
            });
        });
    });
</script>
