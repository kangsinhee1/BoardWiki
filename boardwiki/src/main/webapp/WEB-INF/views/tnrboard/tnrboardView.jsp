<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
<!-- 게시판 글상세 시작 -->
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/videoAdapter.js"></script>
<script src="${pageContext.request.contextPath}/js/tnrboard.fav.js"></script>
<script src="${pageContext.request.contextPath}/js/tnrboard.reply.js"></script>
<section class="page-top-section set-bg" data-setbg="/img/page-top-bg/4.jpg">
		<div class="page-info">
			<h2>${tnrboard.tnr_title}</h2>
			<div class="site-breadcrumb">
				<a href="">Home</a>  /
				<span>Contact</span>
			</div>
		</div>
	</section>
<div class="page-main">
	<h2>${tnrboard.tnr_title}</h2>
	<ul class="detail-info">
		<li>
			<c:if test="${empty tnrboard.mem_nickname}">${tnrboard.mem_email}</c:if>
			<c:if test="${!empty tnrboard.mem_nickname}">${tnrboard.mem_nickname}</c:if>
			<br>
			<c:if test="${empty tnrboard.tnr_mdate}">
			작성일 : ${tnrboard.tnr_rdate}
			</c:if>
			<c:if test="${!empty tnrboard.tnr_mdate}">
			최근 수정일 : ${tnrboard.tnr_mdate}
			</c:if>
			조회 : ${tnrboard.tnr_hit}
		</li>
	</ul>
	<c:if test="${!empty tnrboard.filename}">
	<ul>
		<li>첨부파일 : <a href="file?tnr_num=${tnrboard.tnr_num}">${tnrboard.filename}</a></li>
	</ul>
	</c:if>
	<div class="detail-content">
		${tnrboard.tnr_content}
	</div>
	<div>
		<%-- 좋아요 --%>
		<img id="output_fav" data-num="${tnrboard.tnr_num}"
		    src="${pageContext.request.contextPath}/images/fav01.gif">
		<span id="output_fcount"></span>    
		<%-- 댓글수 --%>
		<span id="output_rcount"></span>
	</div>
	<hr size="1" width="100%">
	<div class="align-right">
		<c:if test="${!empty user && user.mem_num == tnrboard.mem_num || user.mem_auth == 9}">
		<input type="button" value="수정"
		   onclick="location.href='tnrboardUpdate?tnr_num=${tnrboard.tnr_num}'">
		<input type="button" value="삭제" id="delete_btn">
		<script>
			const delete_btn = document.getElementById('delete_btn');
			delete_btn.onclick=function(){
				const choice = confirm('삭제하시겠습니까?');
				if(choice){
					location.replace('tnrboardDelete?tnr_num=${tnrboard.tnr_num}');
				}
			};
		</script>   
		</c:if>
		<c:choose>
			<c:when test="${tnrboard.tnr_category == 1}">
				<input type="button" value="목록" onclick="location.href='tnrboardList?tnr_category=1'">
		    </c:when>
		    <c:when test="${tnrboard.tnr_category == 2}">
				<input type="button" value="목록" onclick="location.href='tnrboardList?tnr_category=2'">
		    </c:when> 
		</c:choose>
	</div>
	<hr size="1" width="100%">
	<!-- 댓글 UI 시작 -->
	<div id="reply_div">
		<span class="re-title">댓글 달기</span>
		<form id="re_form">
			<input type="hidden" name="tnr_num"
			          value="${tnrboard.tnr_num}" id="tnr_num">
			<textarea rows="3" cols="50" name="tnrR_content"
			      id="tnrR_content" class="rep-content"
			      <c:if test="${empty user}">disabled="disabled"</c:if>
			><c:if test="${empty user}">로그인해야 작성할 수 있습니다.</c:if></textarea>          
			<c:if test="${!empty user}">
			<div id="re_first">
				<span class="letter-count">300/300</span>
			</div>
			<div id="re_second" class="align-right">
				<input type="submit" value="전송">
			</div>
			</c:if>
		</form>
	</div>
	<!-- 댓글 목록 출력 -->
	<div id="output"></div>
	<div id="loading" style="display:none;">
		<img src="${pageContext.request.contextPath}/images/loading.gif" width="30" height="30">
	</div>
	<div class="paging-button" style="display:none;">
		<input type="button" value="더보기">
	</div>
	<!-- 댓글 UI 끝 -->
</div>
<!-- 게시판 글상세 끝 -->












