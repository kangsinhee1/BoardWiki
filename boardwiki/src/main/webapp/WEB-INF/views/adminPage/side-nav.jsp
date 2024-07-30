<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="widget-item">
	<div class="categories-widget">
		<div id="adminPage-side-bar-name" class="widget-title">
			<a href="${pageContext.request.contextPath}/admin/adminPage">관리자
				페이지</a>
		</div>
			<ul>
				<li><a
					href="${pageContext.request.contextPath}/adminPage/memberManage">회원관리</a></li>
				<li><a
					href="${pageContext.request.contextPath}/adminPage/gameManage">게임</a></li>
				<li><a
					href="${pageContext.request.contextPath}/adminPage/pointManage">포인트
						관리</a></li>
				<li><a
					href="${pageContext.request.contextPath}/adminPage/reportManage">신고관리</a></li>
				<li><a
					href="${pageContext.request.contextPath}/adminPage/QnaManage">Q&amp;A</a></li>
				<li><a
					href="${pageContext.request.contextPath}/rent/rentListAdmin">대여관리</a></li>
				<li><a
					href="${pageContext.request.contextPath}/adminPage/contestAdminList">대회목록관리</a></li>
			</ul>
	</div>
</div>