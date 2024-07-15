<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<div class="page-main">
    <h2>장바구니</h2>
    <div class="text-box">
        <img src="${item.item_image}" width="180" height="180">
        <form id="addToCart" method="post" action="${pageContext.request.contextPath}/cart/order">
        <button type="submit">결재하기</button>
        </form>
    </div>
</div>
