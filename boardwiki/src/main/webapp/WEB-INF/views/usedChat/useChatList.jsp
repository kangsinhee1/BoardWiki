<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<section class="page-top-section set-bg" data-setbg="/img/page-top-bg/4.jpg">
		<div class="page-info">
			<h2>1:1 채팅 목록</h2>
			<div class="site-breadcrumb">
				<a href="">Home</a>  /
				<span>Contact</span>
			</div>
		</div>
	</section>
	<!-- Page top end-->

<script src="${pageContext.request.contextPath}/js/usedChat.js"></script>
<section class="blog-page">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
<div class="page-main">
	<c:if test="${count==0}">
	<div class="result-display">표시할 게시물이 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
	<table class="striped-table">
		<tr>
			<th>번호</th>
			<th>채팅방</th>
			<th>개설일</th>
		</tr>
		<c:forEach var="chat" items="${list}">
		<tr>
			<td class="align-center">${chat.useC_num}</td>
			<td class="align-left"><a href="${pageContext.request.contextPath}useChatSeller?use_num=${chat.use_num}&useC_name=${chat.useC_name}">${chat.useC_name}</a></td>
			<td class="align-center">${chat.useC_date}</td>
		</tr>
		</c:forEach>
	</table>
	<div class="align-center">${page}</div>
	</c:if>
</div>
</div>
</div>
</div>
</div>
</section>