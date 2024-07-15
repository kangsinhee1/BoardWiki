<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!-- 게시판 목록 시작 -->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/teamBoard.js"></script>
<div class="page-main">
	<h2 class="align-center">모임 신청 회원 리스트(관리)</h2>
	<c:if test="${count == 0}">
		<div class="result-display">회원이 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
		<table class="striped-table">
			<tr>
				<th>회원 닉네임</th>
				<th>신청일</th>
				<th>메시지</th>
				<th>회원상태</th>
			</tr>
			<c:forEach var="team" items="${list}">
				<tr>
					<td class="align-center">${team.mem_nickname}</td>
					<td class="align-center">${team.teaA_time}</td>
					 <td class="align-center">
                        <select class="changeStatus2" data-num="${team.teaA_num}">
                            <option class="status2" value="0" ${team.teaA_status == 0 ? 'selected' : ''}>거부</option>
                            <option class="status2" value="1" ${team.teaA_status == 1 ? 'selected' : ''}>대기중</option>
                            <option class="status2" value="2" ${team.teaA_status == 2 ? 'selected' : ''}>수락</option>
                        </select>
                    </td>
				</tr>
			</c:forEach>
		</table>
		<div class="align-center">${page}</div>
	</c:if>
</div>
<!-- 게시판 목록 끝 -->
<script>
$(function() {
    $('.changeStatus2').on('change', function() {
    	$.ajax({
    		url:'${pageContext.request.contextPath}/team/changeStatus',
    		type:'post',
    		data:{teaA_num:$(this).attr('data-num'), teaA_status: $(this).val()},
    		dataType:'json',
    		success: function(param) {
                 alert('회원 상태가 변경되었습니다.');
                 location.reload();
             },
            error: function() {
                 alert('회원 상태 변경에 실패했습니다.');
             }
    	})
    });

   
   
});
</script>
