<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="big-blog-item">
<div class="page-main">
	<h2>모임 채팅리스트 </h2>
	<form action="myChat2" id="search_form" method="get">
		<ul class="search">
			<li>
				<input type="search" name="keyword" id="keyword" value="${param.keyword}">
			</li>
			<li>
				<input type="submit" value="찾기">
				<input type="button" value="목록" onclick="location.href='myChat2'">
			</li>
		</ul>
	</form>
		
	<c:if test="${count == -1 }">
	<div class="result-display">표시할 채팅방이 없습니다.</div>
	</c:if>
	<c:if test="${count>0}">
	<div class="chart-table">
	<table>
	<thead>
		<tr>
			<th>모임명 </th>
			<th>메시지시간</th>
		</tr>
	</thead>
		<c:forEach var="chat" items="${list}">
		<tbody>
		<tr>
			<td style="text-align:left;">
				<a href="${pageContext.request.contextPath}/chat/chatDetail?chaR_num=${chat.chaR_num}">
					<b>${chat.chatMemberVO.chaR_name}(${chat.room_cnt})</b>
					<br>	
					<span>${fn:substring(chat.chatTextVO.chaT_txt,0,45)}</span>
				</a>
				</td>
			<td>
				<c:if test="${!empty chat.chatTextVO.chaT_time}">${chat.chatTextVO.chaT_time}</c:if>
				<c:if test="${empty chat.chatTextVO.chaT_time}">${chat.chaR_date}</c:if>
			</td>
		</tr>
		</tbody>
		</c:forEach>
	</table>
	<div class="align-center">
	<div class="blog-pagination">${page}</div>
	</div>
	</div>
	</c:if>
</div>

</div>





