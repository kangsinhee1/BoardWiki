<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
<!-- 게시판 글상세 시작 -->
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/videoAdapter.js"></script>
<script src="${pageContext.request.contextPath}/js/board.fav.js"></script>
<script src="${pageContext.request.contextPath}/js/board.reply.js"></script>
<section class="page-top-section set-bg" data-setbg="/img/page-top-bg/4.jpg">
		<div class="page-info">
			<h2>${board.boa_title}</h2>
			<div class="site-breadcrumb">
				<a href="">Home</a>  /
				<span>Contact</span>
			</div>
		</div>
	</section>
<div class="page-main">
	<h2>${board.boa_title}</h2>
	<ul class="detail-info">
		<li>
			<c:if test="${empty board.mem_nickname}">${board.mem_email}</c:if>
			<c:if test="${!empty board.mem_nickname}">${board.mem_nickname}</c:if>
			<br>
			<c:if test="${empty board.boa_mdate}">
			작성일 : ${board.boa_rdate}
			</c:if>
			<c:if test="${!empty board.boa_mdate}">
			최근 수정일 : ${board.boa_mdate}
			</c:if>
			조회 : ${board.boa_hit}
		</li>
	</ul>
	<c:if test="${!empty board.filename}">
	<ul>
		<li>첨부파일 : <a href="file?boa_num=${board.boa_num}">${board.filename}</a></li>
	</ul>
	</c:if>
	<div class="detail-content">
		${board.boa_content}
	</div>
	<div>
		<%-- 좋아요 --%>
		<img id="output_fav" data-num="${board.boa_num}"
		    src="${pageContext.request.contextPath}/images/fav01.gif">
		<span id="output_fcount"></span>    
		<%-- 댓글수 --%>
		<span id="output_rcount"></span>
	</div>
	<hr size="1" width="100%">
	<div class="align-right">
		<c:if test="${!empty user && user.mem_num == board.mem_num || user.mem_auth == 9}">
		<input type="button" value="수정"
		   onclick="location.href='update?boa_num=${board.boa_num}'">
		<input type="button" value="삭제" id="delete_btn">
		<script>
			const delete_btn = document.getElementById('delete_btn');
			delete_btn.onclick=function(){
				const choice = confirm('삭제하시겠습니까?');
				if(choice){
					location.replace('delete?boa_num=${board.boa_num}');
				}
			};
		</script>   
		</c:if>
		<c:choose>
			<c:when test="${board.boa_category == 1}">
				<input type="button" value="목록" onclick="location.href='list?boa_category=1'">
		    </c:when>
		    <c:when test="${board.boa_category == 2}">
				<input type="button" value="목록" onclick="location.href='list?boa_category=2'">
		    </c:when> 
		    <c:when test="${board.boa_category == 3}">
				<input type="button" value="목록" onclick="location.href='list?boa_category=3'">
		    </c:when>      
		</c:choose>
	</div>
	<hr size="1" width="100%">
	<!-- 댓글 UI 시작 -->
	<div id="reply_div">
		<span class="re-title">댓글 달기</span>
		<form id="re_form">
			<input type="hidden" name="boa_num"
			          value="${board.boa_num}" id="boa_num">
			<textarea rows="3" cols="50" name="boaR_content"
			      id="boaR_content" class="rep-content"
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












