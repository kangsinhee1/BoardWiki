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
		<h2>결제내역</h2>
		<div class="site-breadcrumb">
			<a href="">Home</a> /
			<span>pay</span>
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
                            <th>주문번호</th>
			                <th>상품명</th>
			                <th>주소</th>
			                <th>상세주소</th>
			                <th>결제금액</th>
			                <th>결제일</th>
			                
                        </tr>
                    </thead>
                    <tbody>
                            <tr>
                                <td >${order_num}</td>
                                <td>
                                <c:forEach var="pay" items="${list}">
			                    &nbsp;[${my_order.item_name}]&nbsp;
			                    </c:forEach>
			                    </td>
                                <td>${order_address1}</td>
                                <td>${order_address2}</td> 
                                <td>${order_pay}원</td>
                                <td>${order_date}</td>
                            </tr>
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
