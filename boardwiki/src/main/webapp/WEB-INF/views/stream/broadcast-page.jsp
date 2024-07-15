<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
.video-container {
    width: 70%;
    margin: auto;
    text-align: center;
}

video {
    width: 100%;
    height: auto;
    cursor: pointer; /* Change cursor to pointer to indicate clickable */
}

.chat-container {
    width: 30%;
    float: right;
    height: 500px;
    border: 1px solid #ccc;
    overflow-y: scroll;
}
</style>
<script src="https://cdn.jsdelivr.net/npm/hls.js@latest"></script>

<c:if test="${broadcast.isLive == 1}">
<div class="video-container">
    <h1>${broadcast.mem_num}님의 방송</h1>
    <video id="video" autoplay muted playsinline></video>
</div>
</c:if>
<c:if test="${broadcast.isLive == null}">
<div>
방송하는법<br>
<h2><a href="https://obsproject.com/ko">obs 다운로드</a><br></h2>
obs를 다운받습니다.
obs를 설치 후 obs화면을 열고 설정 방송를 누르고 <br>
사용자 지정<br>
서버:192.168.0.10:1935/live<br>
스트림키:${streamkey.str_key}<br>
위 내용을 입력하고 적용을 누르고 obs로 돌아와 방송시작을 누르세요
</div>
</c:if>
<script src="${pasgeContext.request.contextPath}/js/broadcast.js"></script>
