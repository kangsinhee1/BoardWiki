<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 게시판 목록 시작 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<section class="page-top-section set-bg" data-setbg="/img/page-top-bg/4.jpg">
		<div class="page-info">
			<h2>중고 목록</h2>
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
	
	<form action="usedList" id="search_form" method="get">
		<ul class="search">
			<li>
				<select name="keyfield" id="keyfield">
					<option value="1" <c:if test="${param.keyfield == 1}">selected</c:if>>제목</option>
					<option value="2" <c:if test="${param.keyfield == 2}">selected</c:if>>내용</option>
					<option value="3" <c:if test="${param.keyfield == 3}">selected</c:if>>제품명</option>
				</select>
			</li>
			<li>
				<input type="search" name="keyword"
				  id="keyword" value="${param.keyword}">
			</li>
			<li>
				<input type="submit" value="찾기">
			</li>
		</ul> 
		<div class="align-right">
			<select id="order" name="order">  
				<option value="1" <c:if test="${param.order == 1}">selected</c:if>>최신순</option>
				<option value="2" <c:if test="${param.order == 2}">selected</c:if>>가격순</option>
			</select>
			<script type="text/javascript">
				$('#order').change(function(){
					location.href='usedList?keyfield='
							         +$('#keyfield').val()+'&keyword='
							         +$('#keyword').val()+'&order='
							         +$('#order').val();
				});
			</script>
			<input type="button" value="글쓰기" onclick="location.href='usedWrite'">
		</div>                     
	</form>
	<c:if test="${count == 0}">
	<div class="result-display">표시할 게시물이 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
	<table class="striped-table">
		<tr>
			<th>번호</th>
			<th width="300">제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>제품명</th>
			<th>가격</th>
		</tr>
		<c:forEach var="used" items="${list}">
		<tr>
			<td class="align-center">${used.use_num}</td>
			<td class="align-left">
			<a href="usedDetail?use_num=${used.use_num}">
			<c:if test="${used.use_check==1 }"><b>[판매중] </b></c:if>
			<c:if test="${used.use_check==2 }"><b>[예약중] </b></c:if>
			<c:if test="${used.use_check==3 }"><b>[판매완료] </b></c:if>
			${used.use_title}
			</a></td>
			<td class="align-center">
				<c:if test="${empty used.mem_nickname}">			
					${used.mem_email}
				</c:if>
				<c:if test="${!empty used.mem_nickname}">			
					${used.mem_nickname}
				</c:if>
			</td>
			<td class="align-center">${used.use_rdate}</td>
			<td class="align-center">${used.item_name}</td>
			<td class="align-center">${used.use_price}</td>
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

<!-- 게시판 목록 끝 -->