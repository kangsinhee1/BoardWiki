<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
<!-- 게시판 글상세 시작 -->
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/videoAdapter.js"></script>
<section class="page-top-section set-bg" data-setbg="/img/page-top-bg/4.jpg">
		<div class="page-info">
			<h2>${used.use_title}</h2>
			<div class="site-breadcrumb">
				<a href="">Home</a>  /
				<span>Contact</span>
			</div>
		</div>
	</section>
	<!-- Page top end-->

<section class="blog-page">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
<div class="page-main">
  <input type="hidden" name="useC_name" value="${used.use_title} 중고거래채팅">
	<h2>${used.use_title}</h2>
	<ul class="detail-info">
		<li>
		작성자:
			<c:if test="${empty used.mem_nickname}">${used.mem_email}</c:if>
			<c:if test="${!empty used.mem_nickname}">${used.mem_nickname}</c:if>
			<br>
			<c:if test="${empty used.use_mdate}">
			작성일 : ${used.use_rdate}
			</c:if>  
			<c:if test="${!empty used.use_mdate}">
			최근 수정일 : ${used.use_mdate}
			</c:if>
		</li>
		<li>
			제품 : ${used.item_name}
		</li>
		<li>
			가격 : ${used.use_price }
		</li>
	</ul>
	<c:if test="${!empty used.use_photo}">
		<!-- 사진 넣어야함 -->	
	</c:if>
	<div class="align-right">
	<c:if test="${used.use_check !=3 }">
		<input type="button" value=<c:if test="${user.mem_num == used.mem_num}">"채팅 목록"</c:if><c:if test="${user.mem_num != used.mem_num}">"1:1채팅하기"</c:if> onclick="location.href='useChat?mem_num=${used.mem_num}&use_num=${used.use_num }'">	
	</c:if>
	</div>
	<div class="detail-content">
		${used.use_content}
	</div>
	<hr size="1" width="100%">
	<div class="align-right">
		<c:if test="${!empty user && user.mem_num == used.mem_num}">
		<c:if test="${used.use_check!=3 }">
		<input type="button" value="수정"
		   onclick="location.href='usedUpdate?use_num=${used.use_num}'">
		</c:if>
		<input type="button" value="삭제" id="delete_btn">
		<input type="button" value="목록" class="default-btn" onclick="location.href='usedList'">
		<script>
			const delete_btn = document.getElementById('delete_btn');
			delete_btn.onclick=function(){
				const choice = confirm('삭제하시겠습니까?');
				if(choice){
					location.replace('usedDelete?use_num=${used.use_num}');
				}
			};
		</script>   
		</c:if>
	</div>
</div>
</div>
</div>
</div>
</section>
<!-- 게시판 글상세 끝 -->












