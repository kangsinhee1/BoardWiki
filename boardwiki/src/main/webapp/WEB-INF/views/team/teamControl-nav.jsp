<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<!-- Page top section -->
<section class="page-top-section set-bg" data-setbg="/img/page-top-bg/4.jpg">
	<div class="page-info">
		<h2>모임 신청</h2>
		<div class="site-breadcrumb">
			<a href="">Home</a>  /
			<span>모임신청</span> /
			<span><a href="myTeam2"> 내 모임 보기</a></span>
		</div>
	</div>
</section>
<section class="blog-page">
<div class="container">
<!-- MyPage 메뉴 시작 -->
<div class="side-bar">
	<ul>
	&nbsp;
	&nbsp;
		
		<li >
		<input type="hidden" id="tea_status" value="${team.tea_status}">
			<input type="button" class="menu-btn" value="(${team.tea_name})회원 목록"
			onclick="location.href='${pageContext.request.contextPath}/team/teamControl?tea_num=${tea_num}'">
		</li>
		
		<li>
			<input type="button" class="menu-btn" value="모임 일정 설정/변경" 
			onclick="location.href='${pageContext.request.contextPath}/team/teamCalendar?tea_num=${tea_num}'">
		</li>
		<li>
			<input type="button" class="menu-btn" value="돌아가기"
			onclick="location.href='${pageContext.request.contextPath}/team/teamBoardAdmin?tea_num=${tea_num}'">
		</li>
		<li >
		<p>
		&nbsp;
		&nbsp;
		&nbsp;
		&nbsp;
		</li>
		<li >
		<input type="button" style= "display:none"  class="menu-btn" value="모임 비활성화" id="delete_btn">
		</li>
		<li>
		<input type="button" style="display:none" class="menu-btn" value="모임 활성화" id="open_btn">
		</li>
	</ul>
	
</div>
</div>
</section>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<!-- MyPage 메뉴 끝 -->
	<script type="text/javascript">
	 			const delete_btn = document.getElementById('delete_btn');
	 			const open_btn = document.getElementById('open_btn');
	 			const tea_status = document.getElementById('tea_status');
	 			if(tea_status.value==0){
	 				open_btn.style.display = 'block';
	 			}
	 			if(tea_status.value!=0){
	 				delete_btn.style.display = 'block';
	 			}
	 			delete_btn.onclick=function(){
	 				const choice = confirm('비활성화 하시겠습니까');
	 				if(choice){
	 					location.href='${pageContext.request.contextPath}/team/teamDelete?tea_num=${tea_num}'
	 				}
	 			}
	 			
	 			open_btn.onclick=function(){
	 				const choice = confirm('활성화 하시겠습니까');
	 				if(choice){
	 					location.href='${pageContext.request.contextPath}/team/teamOpen?tea_num=${tea_num}'
	 				}
	 			}
	 		</script>










