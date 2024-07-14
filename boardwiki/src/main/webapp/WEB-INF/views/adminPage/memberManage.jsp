<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<h3>회원 관리</h3>
<c:if test="${count == 0}">
	<div class="result-display">표시할 회원이 없습니다.</div>
</c:if>
<c:if test="${count > 0}">
	<input type="button" value="등급 수정" class="align-right">
	<table class="striped-table">
		<tr>
			<th>회원번호</th>
			<th>회원명</th>
			<th>회원닉네임</th>
			<th>회원등급</th>
			<th>핸드폰번호</th>
			<th>연동계정</th>
			<th>가입일</th>
		</tr>
		<c:forEach var="member" items="${list}">
			<tr>
				<td class="align-center">${member.mem_num}</td>
				<td class="align-center">${member.mem_name}</td>
				<td class="align-center"><c:if
						test="${empty member.mem_nickName}">X</c:if> <c:if
						test="${!empty member.mem_nickName}">${member.mem_nickName}</c:if>
				</td>
				<td class="align-center"><c:if test="${member.mem_auth==0}">일반</c:if>
					<c:if test="${member.mem_auth==1}">탈퇴</c:if> <c:if
						test="${member.mem_auth==2}">정지</c:if> <c:if
						test="${member.mem_auth==9}">
						<b>관리자</b>
					</c:if></td>
				<td class="align-center">${member.mem_phone}</td>
				<td class="align-center"><c:if
						test="${member.mem_provider == 'Kakao'}">Kakao</c:if> <c:if
						test="${member.mem_provider == 'Google'}">Google</c:if> <c:if
						test="${member.mem_provider == 'Naver'}">Naver</c:if> <c:if
						test="${empty member.mem_provider}">일반 회원가입</c:if></td>
				<td class="align-center">${member.mem_rdate}</td>
			</tr>
		</c:forEach>
	</table>
	<div class="align-center">${page}</div>
</c:if>
