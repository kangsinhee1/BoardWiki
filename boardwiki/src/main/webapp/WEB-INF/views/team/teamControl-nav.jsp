<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- MyPage 메뉴 시작 -->
<div class="side-bar">
	<ul>
	&nbsp;
	&nbsp;
		<li >
			<input type="button" class="menu-btn" value="모임관리">
		</li>
		<li>
			<input type="button" class="menu-btn" value="회원 목록(관리)">
		</li>
		
		<li>
			<input type="button" class="menu-btn" value="회원 신청 정보" 
			onclick="location.href='changePassword'">
		</li>
		<li>
			<input type="button" class="menu-btn" value="모임 일정 설정/변경" 
			onclick="location.href='${pageContext.request.contextPath}/talk/talkList'">
		</li>
		<li>
			<input type="button" class="menu-btn" value="모임 참석 회원" 
			onclick="location.href='delete'">
		</li>
		<li >
		<p>&nbsp;
		&nbsp;
		&nbsp;
		&nbsp;
		</li>
		<li >
			<input type="button" class="menu-btn" value="모임 비활성화" 
			onclick="location.href='delete'">
		</li>
	</ul>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<!-- MyPage 메뉴 끝 -->











