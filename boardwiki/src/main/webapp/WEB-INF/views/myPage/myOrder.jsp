<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<section >
<form>
		<div >
			<div >
				<div >
<div >
<h2>주문내역</h2>
<%-- 	<c:if test="${count==0}"> --%>
<!-- 	<div class="result-display">주문내역이 없습니다.</div> -->
<%-- 	</c:if> --%>
<%-- 	<c:if test="${count > 0}"> --%>
	<div >
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
		   
			<td >${order.order_num}</td>
			<td >
			   <c:forEach var="my_order" items="${list2}">
			      ${order.item_name}
			   </c:forEach>
			</td>
			<td >${order.order_price}</td>
			<td >${order.order_date}</td>
			
			<c:if test="${order_check==1}">
			<td >배송 준비</td>
			</c:if>
			<c:if test="${order_check==2}">
			<td >배송 중</td>
			</c:if>
			<c:if test="${order_check==3}">
			<td >배송 완료</td>
			</c:if>
			<c:if test="${order_check==4}">
			<td >배송 불가</td>
			</c:if>
		</tr>
		</c:forEach>
		
	</table>
	</div>
	<div >
	<div >${page}</div>
	</div>
<%-- 	</c:if> --%>
</div>
</div>
</div>
</div>
</form>
</section>
