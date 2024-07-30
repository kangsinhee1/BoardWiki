<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
<!-- 룰북 상세 시작 -->
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/videoAdapter.js"></script>
<section class="page-top-section set-bg" data-setbg="/img/page-top-bg/4.jpg">
		<div class="page-info">
			<h2>룰북</h2>
			<div class="site-breadcrumb">
				<a href="rulebookList">Home</a>  /
				<span>Contact</span>
			</div>
		</div>
</section>
<section class="blog-page">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
<div class="page-main">
<h2 style="text-align:center;">${rulebook.item_name}</h2><br>
	<ul class="detail-info">
		<li>
			<c:if test="${empty rulebook.rulB_mdate}">
			작성일 : ${rulebook.rulB_rdate}
			</c:if>
			<c:if test="${!empty rulebook.rulB_mdate}">
			최근 수정일 : ${rulebook.rulB_mdate}
			</c:if>
		</li>
	</ul>
	<c:if test="${!empty rulebook.filename}">
	<ul>
		<li style="color:white;">첨부파일 : <a href="file?rulB_num=${rulebook.rulB_num}">${rulebook.filename}</a></li>
	</ul>
	</c:if>
	<br><div class="detail-content">
		${rulebook.rulB_content}
	</div>
	<hr size="1" width="100%">
	<div class="align-right">
		<c:if test="${!empty user && user.mem_num == rulebook.mem_num}">
		<input type="button" value="수정"
		   onclick="location.href='rulebookUpdate?rulB_num=${rulebook.rulB_num}'">
		<input type="button" value="삭제" id="delete_btn">
		<script>
			const delete_btn = document.getElementById('delete_btn');
			delete_btn.onclick=function(){
				const choice = confirm('삭제하시겠습니까?');
				if(choice){
					location.replace('rulebookDelete?rulB_num=${rulebook.rulB_num}');
				}
			};
		</script>   
		</c:if>
		<input type="button" value="목록" class="default-btn" onclick="location.href='rulebookList'">
	</div>
	<hr size="1" width="100%">
</div>
</div>
</div>
</div>
</section>
<!-- 룰북 상세 끝 -->












