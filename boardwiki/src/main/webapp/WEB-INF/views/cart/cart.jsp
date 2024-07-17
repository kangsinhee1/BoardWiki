<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
            <input type="hidden" id="item_num" value="${cart.item_num}" />
            <input type="hidden" id="mem_num" value="${cart.mem_num}" />
            <p>${cart.item_name}</p>
            <p>${cart.item_price}원</p>
        </div>
        <div>
            <label for="quantity">수량:</label>
            <input type="number" id="quantity" name="item_quantity" value="${cart.item_quantity}" min="1" max="${cart.item_stock}"/>
        </div>
        <button id="deleteX">X</button>
         </c:forEach>
        <form id="addToCart" method="get" action="${pageContext.request.contextPath}/order/order">
             <input type="button" value="결제하기"
              onclick="location.href='${pageContext.request.contextPath}/order/order'">
        </form>
    </div>
</div>
