<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<section class="blog-page">
		<div class="container">
			<div class="row">
				<div class="col-lg-12"> 
<div class="page-main">
<h3>포인트 관리</h3>
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
        </tr>
        <c:forEach var="member" items="${list}">
            <tr>
                <td class="align-center">${member.mem_num}</td>
                <td class="align-center"><a href="${pageContext.request.contextPath}/point/pointListAdmin?mem_num=${member.mem_num}">${member.mem_email}</a></td>
                <td class="align-center">${member.mem_name}</td>
                <td class="align-center"><c:if test="${empty member.mem_nickName}">X</c:if> <c:if test="${!empty member.mem_nickName}">${member.mem_nickName}</c:if></td>
            </tr>
        </c:forEach>
    </table>
    <div class="blog-pagination" style= "text-align : center">${page}</div>
</c:if>
</div>
</div>
</div>
</div>
</section>