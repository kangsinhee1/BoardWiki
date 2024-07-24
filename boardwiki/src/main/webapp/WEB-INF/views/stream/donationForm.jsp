<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/js/boradchat.js"></script>

<c:if test="${user == null}">
    <div class="result-display">
        ${logout}
        <button onclick="window.close()">닫기</button>
    </div>
</c:if>

<c:if test="${user != null}">
    <h2>도네이션 입력</h2>
    <form id="donationForm">
        <div>(${user.mem_nickName})님의 현재 포인트 : ${point}</div>
        <label for="don_content">내용:</label>
        <input type="text" id="don_content" name="don_content"><br>
        <label for="don_point">포인트:</label>
        <input type="number" id="don_point" name="don_point"><br>
        <input type="hidden" id="str_num" name="str_num" value="${param.str_num}">
        <button type="submit" id="donation">도네이션 보내기</button>
    </form>
    <button onclick="window.close()">닫기</button>
</c:if>

<script>
let strNum = ${param.str_num};
let memNickname = "${user.mem_nickName}";
</script>