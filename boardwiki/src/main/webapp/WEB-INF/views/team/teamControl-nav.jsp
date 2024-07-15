<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- MyPage 메뉴 시작 -->
<div class="side-bar">
	<ul>
	&nbsp;
	&nbsp;
		
		<li >
			<input type="button" class="menu-btn" value="(${tea_name})회원 목록"
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
		<input type="button" value="모임 비활성화" id="delete_btn">
		</li>
		
	</ul>
	
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<!-- MyPage 메뉴 끝 -->
	<script type="text/javascript">
	 			const delete_btn = document.getElementById('delete_btn');
	 			delete_btn.onclick=function(){
	 				const choice = confirm('비활성화 하시겠습니까');
	 				if(choice){
	 					location.href='${pageContext.request.contextPath}/team/teamDelete?tea_num=${tea_num}'
	 				}
	 			}
	 		</script>










