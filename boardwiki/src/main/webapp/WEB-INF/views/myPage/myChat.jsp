<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<div class="page-main">
	<h2>채팅리스트 (구매)</h2>
	<c:if test="${count==0}">
	<div class="result-display">표시할 채팅방이 없습니다.</div>
	</c:if>
	<c:if test="${count>0}">
	<table class="striped-table">
		<tr>
			<th>채팅방 번호</th>
			<th>채팅방 이름</th>
			<th>채팅 개설일</th>
		</tr>
		<c:forEach var="used" items="${list}">
		<tr>
			<td>${used.useC_num}</td>
			<td style="text-align:left;">
				<a href="${pageContext.request.contextPath}useChat?use_num=${used.use_num}&useC_name=${used.useC_name}">
					<b>${used.useC_name}</b>
				</a>
			</td>
			<td>${used.useC_date }</td>
		</tr>
		</c:forEach>
	</table>
	<div class="align-center">${page}</div>
	</c:if>
	<hr size="1" width="80%" noshade="noshade">
	<h2>중고글 목록	 (판매)</h2>
	<c:if test="${count2==0}">
	<div class="result-display">표시할 채팅방이 없습니다.</div>
	</c:if>
	<c:if test="${count2>0}">
	<table class="striped-table">
		<tr>
			<th>중고글 번호</th>
			<th>중고글 제목</th>
			<th>중고글 작성일</th>
		</tr>
		<c:forEach var="used" items="${list2}">
		<tr>
			<td>${used.use_num}</td>
			<td style="text-align:left;">
				<a href="${pageContext.request.contextPath}useChat?use_num=${used.use_num}">
					<b>${used.use_title}</b>
				</a>
			</td>
			<td>${used.use_rdate }</td>
		</tr>
		</c:forEach>
	</table>
	<div class="align-center">${page2}</div>
	</c:if>
</div>
<h2> 구매 완료 목록</h2>
	<c:if test="${count3==0}">
	<div class="result-display">표시할 채팅방이 없습니다.</div>
	</c:if>
	<c:if test="${count3>0}">
	<table class="striped-table">
		<tr>
			<th>중고글 번호</th>
			<th>중고글 제목</th>
			<th>평점 주기</th>
		</tr>
		<c:forEach var="used" items="${list3}">
		<tr>
			<td>${used.use_num}</td>
			<td style="text-align:left;">
				<a href="${pageContext.request.contextPath}useChat?use_num=${used.use_num}">
					<b>${used.useC_name}</b>
				</a>
			</td>
			<td><a href="usedGrade?useC_num=${used.useC_num}">평점주러가기</a></td>
		</tr>
		</c:forEach>
	</table>
	<div class="align-center">${page2}</div>
	</c:if>
</div>