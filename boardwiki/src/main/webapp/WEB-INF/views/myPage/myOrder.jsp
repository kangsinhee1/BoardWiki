<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<section class="blog-page">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
<div class="page-main">
<h2>주문내역</h2>
	<c:if test="${count==0}">
	<div class="result-display">주문내역이 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
	<div class="chart-table">
	<table>
		<thead>
		<tr>
			<th>번호</th>
			<th>상품명</th>
			<th>결제금액</th>
			<th>결제일</th>
			<th>배송상태</th>
		</tr>
		</thead>
		<c:forEach var="my_order" items="${list}">
		<tr>
			<td class="align-center">${order.order_num}</td>
			<td class="align-center">
			   <c:forEach var="my_order" items="${list2}">
			      ${order.item_name}
			   </c:forEach>
			</td>
			<td class="align-center">${order.order_price}</td>
			<td class="align-center">${order.order_date}</td>
			
			<c:if test="${order_check==1}">
			<td class="align-center">배송 준비</td>
			</c:if>
			<c:if test="${order_check==2}">
			<td class="align-center">배송 중</td>
			</c:if>
			<c:if test="${order_check==3}">
			<td class="align-center">배송 완료</td>
			</c:if>
			<c:if test="${order_check==4}">
			<td class="align-center">배송 불가</td>
			</c:if>
		</tr>
		</c:forEach>
		
	</table>
	</div>
	<div class="align-center">
	<div class="blog-pagination">${page}</div>
	</div>
	</c:if>
</div>
</div>
</div>
</div>
</section>