<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<!-- include ckeditor js -->
<script src="${pageContext.request.contextPath}/js/ckeditor.js"></script>
<script src="${pageContext.request.contextPath}/js/uploadAdapter.js"></script>
<!-- Page top section -->
<section class="page-top-section set-bg" data-setbg="/img/page-top-bg/4.jpg">
	<div class="page-info">
		<h2>결제</h2>
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
            <div class="table-responsive">
                <table class="table table-bordered table-striped">
                    <thead class="thead-dark">
                        <tr>
                            <th>이미지</th>
                            <th>상품명</th>
                            <th>가격</th>
                            <th>수량</th>
                            <th>총 가격</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="cart" items="${list}">
                            <tr>
                                <td><img src="${cart.item_image}" width="100" height="100" class="img-thumbnail"></td>
                                <td>${cart.item_name}</td>
                                <td id="item_price_${cart.item_num}" data-price="${cart.item_price}">${cart.item_price}원</td>
                                <td>
                                    <select id="quantity_${cart.item_num}" name="item_quantity" class="form-control quantity" data-item-num="${cart.item_num}">
                                        <c:forEach begin="1" end="${cart.item_stock}" var="i">
                                            <option value="${i}" <c:if test="${i == cart.item_quantity}">selected</c:if>>${i}</option>
                                        </c:forEach>
                                    </select>
                                </td> 
                                <td id="total_price_${cart.item_num}" class="total-price">${cart.item_quantity * cart.item_price}원</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            <div class="align-right">
            <div class="mt-4">
                <p class="h5" id="total_sum_price">총 금액: <span id="total_sum_value">0</span>원</p>
            </div>
            </div>
        </div>
    </section>
<!-- Review section end -->
