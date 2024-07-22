<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<!-- Page top section -->
<!-- MyPage 메뉴 시작 -->
	<nav class="side-nav">
	<ul>
	&nbsp;
	&nbsp;
		
		<li>
		<input type="hidden" id="tea_status" value="${Team.tea_status}">
			<input type="button" class="menu-btn" value="(${Team.tea_name})회원 목록"
			onclick="location.href='${pageContext.request.contextPath}/team/teamControl?tea_num=${tea_num}'">
		</li>
		<p>
		<li>
			<input type="button" class="menu-btn" value="모임 일정 설정/변경" 
			onclick="location.href='${pageContext.request.contextPath}/team/teamCalendar?tea_num=${tea_num}'">
		</li>
		<p>
		<li>
			<input type="button" class="menu-btn" value="돌아가기"
			onclick="location.href='${pageContext.request.contextPath}/team/teamBoardAdmin?tea_num=${tea_num}'">
		</li>
		
		<p>
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
	</nav>
	
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










