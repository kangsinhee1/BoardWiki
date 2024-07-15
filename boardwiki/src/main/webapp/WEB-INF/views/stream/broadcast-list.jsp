<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>
.broadcast {
	display: inline-block;
	margin: 20px;
	text-align: center;
}

.thumbnail {
	width: 200px;
	height: 150px;
	background-color: #000;
}

.username {
	margin-top: 10px;
	font-size: 18px;
}
</style>
<h1>Live Broadcasts</h1>
<div>
	<c:forEach var="broadcast" items="${broadcasts}">
		<div class="broadcast">
			<a
				href="${pageContext.request.contextPath}/streaming/broadcast?str_num=${broadcast.str_num}">
				<div class="thumbnail">
					<img
						src="${pageContext.request.contextPath}/hls/${broadcast.str_key}/thumbnail.jpg"
						alt="Thumbnail">
				</div>
				<div class="username">${broadcast.mem_num}님의 방송</div>
			</a>
		</div>
	</c:forEach>
</div>


