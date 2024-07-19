<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>  
<h3>질문글 관리</h3>
<c:if test="${count==0}">
	<div class="result-display">표시할 게시물이 없습니다.</div>
</c:if>
<c:if test="${count > 0}">
	<table class="striped-table">
		<tr>
			<th>번호</th>
			<th width="300">제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
			<th>좋아요수</th>
			<th>답변여부</th>
		</tr>
		<c:forEach var="board" items="${list}">
		<tr>
			<td class="align-center">${board.boa_num}</td>
			<td class="align-left"><a href="${pageContext.request.contextPath}/board/detail2?boa_num=${board.boa_num}">${board.boa_title}(${board.re_cnt})</a></td>
			<td class="align-center">
				<c:if test="${empty board.mem_nickname}">${board.mem_email}</c:if>
				<c:if test="${!empty board.mem_nickname}">${board.mem_nickname}</c:if>
			</td>
			<td class="align-center">${board.boa_rdate}</td>
			<td class="align-center">${board.boa_hit}</td>
			<td class="align-center">${board.fav_cnt}</td>
				<td class="align-center" id="answer-${board.boa_num}">
				</td>
			</tr>
			<script>
			$(document).ready(function() {
					$.ajax({
						url : '/adminPage/QnaManage2',
						dataType : 'json',
						data : {
							boa_num : '${board.boa_num}'
						},
						type : 'get',
						success : function(param) {
							if (param.result == 'true') {
								$('#answer-${board.boa_num}').text('답변 완료').addClass('answered');
							} else if (param.result == 'false') {
								$('#answer-${board.boa_num}').text('미답변').addClass('unanswered');
							} else {
								alert('오류발생');
							}
						},
						error : function() {
							
						}
				
				});
					
			});
		</script>
		</c:forEach>
	</table>
	
	
	
	
		
	<div class="align-center">${page}</div>
</c:if>