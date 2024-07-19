<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!-- 게시판 목록 시작 -->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
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

<div class="page-main">
	<div class="content-container" id="content">
		<!-- Content for 내가 신청한 모임 -->
		<h2>내가 신청한 모임 목록</h2>
		<table class="table">
			<thead>
				<tr>
					<th>모임 이름</th>
					<th>신청 상태</th>
					<th>신청 일자</th>
					<th>취소 하기</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="team" items="${list4}">
				 <c:if test="${team.teaA_status != 2}">
					<tr>
						<td>${team.tea_name}</td>
						<td><c:choose>
								<c:when test="${team.teaA_status == 1}">수락 대기중</c:when>
								<c:when test="${team.teaA_status == 0}">수락 거부</c:when>
							</c:choose></td>
						<td>${fn:substring(team.teaA_time, 0, 10)}</td>
						<c:if test="${team.teaA_status == 1}">
							<td><input type="button" data-num="${team.teaA_num}"
								class="delete_btn" value="취소"></td>
						</c:if>
						<c:if test="${team.teaA_status == 2}">
							<td><input type="button" data-num="${team.teaA_num}"
								class="delete_btn" value="탈퇴"></td>
						</c:if>
					</tr>
					</c:if>
				</c:forEach>
			</tbody>
		</table>
		<h2>내가 가입한 모임 목록</h2>
		<table class="table">
			<thead>
				<tr>
					<th>모임 이름</th>
					<th>신청 상태</th>
					<th>신청 일자</th>
					<th>탈퇴 하기</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="team" items="${list4}">
				<c:if test="${team.teaA_status == 2}">
					<tr>
						<td>${team.tea_name}</td>
						<td><c:choose>
								<c:when test="${team.teaA_status == 1}">수락 대기중</c:when>
								<c:when test="${team.teaA_status == 0}">수락 거부</c:when>
								<c:when test="${team.teaA_status == 2}">수락 완료</c:when>
							</c:choose></td>
						<td>${fn:substring(team.teaA_time, 0, 10)}</td>
						<c:if test="${team.teaA_status == 1}">
							<td><input type="button" data-num="${team.teaA_num}"
								class="delete_btn" value="취소"></td>
						</c:if>
						<c:if test="${team.teaA_status == 2}">
							<td><input type="button" data-num="${team.teaA_num}"
								class="delete_btn" value="탈퇴"></td>
						</c:if>
					</tr>
					</c:if>
				</c:forEach>
			</tbody>
		</table>
	</div>


</div>
</div>
</section>
<script type="text/javascript">
$(document).on('click','.delete_btn',function(){
	 let teaA_num = $(this).attr('data-num');
	 console.log(teaA_num);
	 const choice = confirm('취소/탈퇴하시겠습니까?');
	 	if(choice){
	 location.replace('deleteTeamApply?teaA_num='+teaA_num);
	 alert('취소/삭제 처리되었습니다.');
	 }
});
</script>

