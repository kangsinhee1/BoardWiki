<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
<!-- 게시판 목록 시작 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<div class="page-main">
<div class="content-container" id="content">
    <!-- Content for 내가 신청한 모임 -->
    <h2> 내가 신청/가입한 모임 목록</h2>
    <table class="table">
        <thead>
            <tr>
                <th>신청 번호</th>
                <th>모임 이름</th>
                <th>신청 상태</th>
                <th>신청 일자</th>
                <th>취소/탈퇴하기</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="team" items="${list4}">
                <tr>
                	<td>${team.teaA_num}</td>
                    <td>${team.tea_name}</td>
                   <td>
                    <c:choose>
                   <c:when test="${team.teaA_status == 1}">수락 대기중</c:when>
                    <c:when test="${team.teaA_status == 0}">수락 거부</c:when>
                    <c:when test="${team.teaA_status == 2}">수락 완료</c:when>
                    </c:choose>
                   </td> 
                    <td>${fn:substring(team.teaA_time, 0, 10)}</td>
                    <c:if test="${team.teaA_status == 1}">
                    <td><input type="button" data-num="${team.teaA_num}" class="delete_btn" value="취소"></td>
                    </c:if>
                    <c:if test="${team.teaA_status == 2}">
                    <td><input type="button" data-num="${team.teaA_num}" class="delete_btn" value="탈퇴"></td>
                    </c:if>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
<script type="text/javascript">
	 			const delete_btn = document.getElementsByClassName('delete_btn');
	 			delete_btn.onclick=function(){
	 				let teaA_num = $(this).data('num');
	 				console.log(teaA_num);
	 				const choice = confirm('삭제하시겠습니까?');
	 				if(choice){
	 					location.replace('deleteTeamApply?teaA_num='+teaA_num);
	 				}
	 			}
	 		</script>

</div>



