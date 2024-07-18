<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/cart.js"></script>
<div class="page-main">
    <h2>장바구니</h2>
    <div class="text-box">
        <c:forEach var="cart" items="${list}">
        <div class="image-box">
            <img src="${cart.item_image}" width="150" height="150">
            <input type="hidden" id="item_num_${cart.item_num}" value="${cart.item_num}" />
            <input type="hidden" id="mem_num_${cart.item_num}" value="${cart.mem_num}" />
            <p>${cart.item_name}</p>
            <p id="item_price_${cart.item_num}" data-price="${cart.item_price}">${cart.item_price}원</p>
        </div>
        <div>
            <label for="quantity_${cart.item_num}">수량:</label>
            <select id="quantity_${cart.item_num}" name="item_quantity" class="quantity" data-item-num="${cart.item_num}">
                <c:forEach begin="1" end="${cart.item_stock}" var="i">
                    <option value="${i}" <c:if test="${i == cart.item_quantity}">selected</c:if>>${i}</option>
                </c:forEach>
            </select>
            <p id="total_price_${cart.item_num}" class="total-price">${cart.item_quantity * cart.item_price}원</p>
        </div>
        <button id="deleteX">제거</button>
        </c:forEach>
        <div>
            <p id="total_sum_price">총 가격: <span id="total_sum_value">0</span>원</p>
        </div>
            <button onclick="location.href='${pageContext.request.contextPath}/order/order?mem_num=${mem_num}'">
            주문하기
            </button>
    </div>
</div>
