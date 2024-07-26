<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>

<!-- Include CKEditor JS -->
<script src="${pageContext.request.contextPath}/js/ckeditor.js"></script>
<script src="${pageContext.request.contextPath}/js/uploadAdapter.js"></script>

<!-- Page top section -->
<section class="page-top-section set-bg" data-setbg="/img/page-top-bg/4.jpg">
	<div class="page-info">
		<h2>주문</h2>
		<div class="site-breadcrumb">
			<a href="">Home</a> /
			<span>Cart</span>
		</div>
	</div>
</section>
<!-- Page top end-->

<!-- Review section -->
<section class="review-section py-5">
    <div class="container">
        <div class="page-main">
            <div class="great-box">
                <form id="GetToOrder" method="post" action="${pageContext.request.contextPath}/order/order1">
                    <c:forEach var="order" items="${list}">
                        <input type="hidden" name="mem_num" value="${mem_num}">
                        <input type="hidden" name="item_quantity" value="${order.item_quantity}">
                        <div class="big-box">
                            <input type="hidden" value="${order.item_num}" name="item_num">
                            <p class="order-item" style="display: inline-block; vertical-align: top;">
                                ${order.item_name}|${order.item_quantity}개|
                            </p>
                            <p id="order_all_price" class="order-price"
                               style="display: inline-block; vertical-align: top;" 
                               data-sum="${order.item_price * order.item_quantity}">
                               <b>₩${order.item_price * order.item_quantity}</b>
                            </p>
                            
                        </div>
                    </c:forEach>
                    <div class="form-group">
                        <label for="order_name">수령인</label>
                        <input type="text" id="order_name" name="order_name" class="form-control">
                    </div>
                    <div class="form-group">
                        <label for="order_phone">전화번호</label>
                        <input type="text" id="order_phone" name="order_phone" class="form-control">
                    </div>
                    <div class="form-group">
                        <label for="order_zipcode">우편번호</label>
                        <div class="d-flex">
                            <input type="text" name="order_zipcode" id="order_zipcode" class="form-control" maxlength="5">
                            <input type="button" onclick="execDaumPostcode()" value="우편번호 찾기" class="btn btn-secondary post_btn">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="order_address1">주소</label>
                        <input type="text" name="order_address1" id="order_address1" class="form-control" maxlength="30">
                    </div>
                    <div class="form-group">
                        <label for="order_address2">상세주소</label>
                        <input type="text" name="order_address2" id="order_address2" class="form-control" maxlength="30">
                    </div>
                    <div>
			        <label for="pay_payment">결제수단</label>
			        <input type="radio" name="order_pay" id="order_pay1" value="1">계좌입금
			        <input type="radio" name="order_pay" id="order_pay2" value="2">카드결제
	                </div>
                    <button type="submit" class="btn btn-primary mt-3">주문하기</button>
                </form>
            </div>
        </div>
    </div>
</section>
<!-- Review section end -->

<!-- Daum 우편번호 API 시작 -->
<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
    <img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" 
         style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
</div>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    var element_layer = document.getElementById('layer');

    function closeDaumPostcode() {
        element_layer.style.display = 'none';
    }

    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                var addr = ''; 
                var extraAddr = ''; 

                if (data.userSelectedType === 'R') { 
                    addr = data.roadAddress;
                } else { 
                    addr = data.jibunAddress;
                }

                if(data.userSelectedType === 'R'){
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                } 

                document.getElementById('order_zipcode').value = data.zonecode;
                document.getElementById("order_address1").value = addr + extraAddr;
                document.getElementById("order_address2").focus();

                element_layer.style.display = 'none';
            },
            width : '100%',
            height : '100%',
            maxSuggestItems : 5
        }).embed(element_layer);

        element_layer.style.display = 'block';

        initLayerPosition();
    }

    function initLayerPosition(){
        var width = 300;
        var height = 400;
        var borderWidth = 5;

        element_layer.style.width = width + 'px';
        element_layer.style.height = height + 'px';
        element_layer.style.border = borderWidth + 'px solid';
        element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
        element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
    }
</script>
<!-- Daum 우편번호 API 끝 -->

