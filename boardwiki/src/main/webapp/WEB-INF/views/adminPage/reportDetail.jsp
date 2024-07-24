<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="${pageContext.request.contextPath}/js/reportChangeAuth.js"></script>

<hr size="1" noshade="noshade" width="100%">
신고자 : ${report.mem_nickName}<br>
신고내용 : ${report.report_content}<br>
신고유형 : 
<c:if test="${report.report_category == 1 }"><input type="radio" value="1" checked />욕설/혐오/차별표현<br></c:if>
<c:if test="${report.report_category == 2 }"><input type="radio" value="2" checked/>부적절한 게시물<br></c:if>
<c:if test="${report.report_category == 3 }"><input type="radio" value="3" checked/>불법정보를 포함<br></c:if>
<c:if test="${report.report_category == 4 }"><input type="radio" value="4" checked/>도배/스팸<br></c:if>
신고날짜 : ${report.report_date }<br><br><br>

<hr size="1" noshade="noshade" width="100%">

신고 게시글 : 
<c:if test="${report.report_type == 1 }">
<a href="${pageContext.request.contextPath}/board/detail?boa_num=${report.boa_num}">
${report.boa_title }
</a><br>
</c:if>
<c:if test="${report.report_type == 5 }">
<a href="${pageContext.request.contextPath}/used/usedDetail?use_num=${report.use_num}">
${report.use_title }
</a><br>
</c:if>
<c:if test="${report.report_type == 6 }">
<a href="${pageContext.request.contextPath}/team/teamDetail?tea_num=${report.tea_num}">
${report.tea_name}
</a><br>
</c:if>
<c:if test="${report.report_type == 7 }">
<a href="${pageContext.request.contextPath}/tnrboard/tnrboardDetail?tnr_num=${report.tnr_num}">
${report.tnr_title }
</a><br>
</c:if>

<hr size="1" noshade="noshade" width="100%">

<c:if test="${report.report_type == 1 }">
<form class="change_auth">
	<input type="hidden" name="report_typeDetail" value="${report.report_typeDetail }">
	<input type="hidden" name="report_type" value="${report.report_type }">
	<input type="hidden" name="boa_num" value="${report.report_typeDetail }">
	<input type="radio" name="boa_auth" value=0 
	<c:if test="${report.boa_auth== 0 }">checked</c:if>/>활성화 
	<input type="radio" name="boa_auth" value=1 
	<c:if test="${report.boa_auth== 1 }">checked</c:if>/>비활성화
	<button type="submit">완료</button>
</form>
</c:if>

<c:if test="${report.report_type == 5 }">
<form class="change_auth">
	<input type="hidden" name="report_type" value="${report.report_type }">
	<input type="hidden" name="use_num" value="${report.report_typeDetail }">
	<input type="radio" name="use_auth" value=0 
	<c:if test="${report.use_auth== 0 }">checked</c:if>/>활성화 
	<input type="radio" name="use_auth" value=1 
	<c:if test="${report.use_auth== 1 }">checked</c:if>/>비활성화
	<button type="submit">완료</button>
</form>
</c:if>

<c:if test="${report.report_type == 6 }">
<form class="change_auth">
	<input type="hidden" name="report_type" value="${report.report_type }">
	<input type="hidden" name="tea_num" value="${report.report_typeDetail }">
	<input type="radio" name="tea_status" value=1
	<c:if test="${report.tea_status== 1 }">checked</c:if>/>활성화 
	<input type="radio" name="tea_status" value=2 
	<c:if test="${report.tea_status== 2 }">checked</c:if>/>비활성화
	<button type="submit">완료</button>
</form>
</c:if>

<c:if test="${report.report_type == 7 }">
<form class="change_auth">
	<input type="hidden" name="report_type" value="${report.report_type }">
	<input type="hidden" name="tnr_num" value="${report.report_typeDetail }">
	<input type="radio" name="tnr_auth" value=0 
	<c:if test="${report.tnr_auth== 0 }">checked</c:if>/>활성화 
	<input type="radio" name="tnr_auth" value=1 
	<c:if test="${report.tnr_auth== 1 }">checked</c:if>/>비활성화
	<button type="submit">완료</button>
</form>
</c:if>


