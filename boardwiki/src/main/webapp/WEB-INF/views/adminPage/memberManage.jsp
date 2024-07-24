<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<h3>회원 관리</h3>
<c:if test="${count == 0}">
    <div class="result-display">표시할 회원이 없습니다.</div>
</c:if>
<c:if test="${count > 0}">
    <table class="striped-table">
        <tr>
            <th>회원번호</th>
            <th>회원이메일</th>
            <th>회원명</th>
            <th>회원닉네임</th>
            <th>회원등급</th>
            <th>핸드폰번호</th>
            <th>연동계정</th>
            <th>가입일</th>
            <th>등급변경</th> <!-- 등급 수정 열 추가 -->
        </tr>
        <c:forEach var="member" items="${list}">
            <tr>
                <td class="align-center">${member.mem_num}</td>
                <td class="align-center">${member.mem_email}</td>
                <td class="align-center">${member.mem_name}</td>
                <td class="align-center"><c:if test="${empty member.mem_nickName}">X</c:if> <c:if test="${!empty member.mem_nickName}">${member.mem_nickName}</c:if></td>
                <td class="align-center">
                    <c:choose>
                        <c:when test="${member.mem_auth == 0}">탈퇴</c:when>
                        <c:when test="${member.mem_auth == 1}">정지</c:when>
                        <c:when test="${member.mem_auth == 2}">일반</c:when>
                    </c:choose>
                </td>
                <td class="align-center">${member.mem_phone}</td>
                <td class="align-center">
                    <c:choose>
                        <c:when test="${member.mem_provider == 'Kakao'}">Kakao</c:when>
                        <c:when test="${member.mem_provider == 'Google'}">Google</c:when>
                        <c:when test="${member.mem_provider == 'Naver'}">Naver</c:when>
                        <c:otherwise>일반 회원가입</c:otherwise>
                    </c:choose>
                </td>
                <td class="align-center">${member.mem_rdate}</td>
                <td class="align-center">
                    <select class="auth-select" data-num="${member.mem_num}">
					    <option value="0" <c:if test="${member.mem_auth == 0}">selected</c:if>>탈퇴</option>
					    <option value="1" <c:if test="${member.mem_auth == 1}">selected</c:if>>정지</option>
					    <option value="2" <c:if test="${member.mem_auth == 2}">selected</c:if>>일반</option>
					</select>
					                    
                </td>
            </tr>
        </c:forEach>
    </table>
    <div class="align-center">${page}</div>
</c:if>
<script>
$(document).ready(function() {
    $('.auth-select').change(function() {
        var mem_num = $(this).data('num'); // data-num을 사용하여 memNum을 설정
        var mem_auth = $(this).val(); // 선택된 등급

        $.ajax({
            url: '/adminPage/updateMemberAuth',
            type: 'POST',
            data: {
                mem_num: mem_num,
                mem_auth: mem_auth
            },
            dataType: 'json',
            success: function(response) {
                if (response.result === 'success') {
                    alert('등급 수정 완료');
                    location.reload(true);
                } else {
                    alert('등급 수정 오류 발생');
                }
            },
            error: function() {
                alert('네트워크 오류 발생');
            }
        });
    });
});
</script>
