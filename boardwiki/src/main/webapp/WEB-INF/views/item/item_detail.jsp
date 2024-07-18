<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/cart.js"></script>
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
					<p>최소연령:${item.minage}세</p>
					<p>참여인원:${item.minplayers}~${item.maxplayers}명</p>
					<p>플레이 타임:${mintime}~${maxtime}시간</p>
					<p>출시연도:${item.item_year}년</p>	
				</div>
				<div class="text-box1" style="display: inline-block; vertical-align: top;">
				    <p>순위:${item.item_rank}위</p>
					<p>평점:${item.item_average}점</p>
					<p>재고:${item.item_stock}개</p>
					<p>가격:${item.item_price}원</p>
				</div>
                <c:if test="${!empty member.mem_num}">
                <div class="text-box2" style="display: inline-block; vertical-align: top;">
                    <form id="addToCart" method="get" action="${pageContext.request.contextPath}/cart/cart">
                        <input type="hidden" name="item_num" value="${item.item_num}" />
                        <input type="hidden" name="user" value="${member.mem_num}" />
                        <div>
                        <label for="quantity">수량:</label>
                        <input type="number" id="quantity" name="item_quantity" 
                         value="1" min="1" max="${item.item_stock}" />
                        <br>
                        <button type="button" id="addToCartButton">장바구니에 추가</button>
                        <button onclick="location.href='/cart/cart?mem_num=${member.mem_num}'">장바구니로</button>
                        </div>
                    </form>
                </div>
                </c:if>
			</div>
		</div>
	</div>
	<div class="big-box2">
	    <div class="midle-box2">
	        <button>간단설명</button>
	        <button onclick="location.href='/rent/rent?item_num=${item.item_num}'">대여</button>
		    <button>중고거래</button>
		</div>
		<div class="midle-box3">
		    <a>${item.description}</a>
		</div>
        <button>목록</button>
     </div>
</div>

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