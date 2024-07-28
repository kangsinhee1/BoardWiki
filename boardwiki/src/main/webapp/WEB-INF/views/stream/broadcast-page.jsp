<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
    .container {
        display: flex;
        justify-content: center;
        align-items: flex-start;
        min-height: 1000px;
    }
    .video-container {
        width: 70%;
        text-align: center;
    }
    video {
        width: 100%;
        height: auto;
        cursor: pointer;
    }
    .chat-section {
        width: 30%;
        margin-left: 10px;
    }
    .chat-container {
        height: 500px;
        border: 1px solid #ccc;
        overflow-y: scroll;
        flex-direction:column_reverse;
    }
    .chat-input-container {
        margin-top: 10px;
    }
    .chat-input {
        width: calc(100% - 22px);
        padding: 10px;
        margin-right: 2px;
    }
    .chat-send-button {
        padding: 10px;
    }
    .donation-button, .donation-list-button {
        padding: 10px;
        margin: 5px;
        cursor: pointer;
    }
#chat-container::-webkit-scrollbar {
    display: none; /* 크롬, 사파리, 오페라, 엣지 */ 👈
}
</style>

<script src="https://cdn.jsdelivr.net/npm/hls.js@latest"></script>

<section class="page-top-section set-bg" data-setbg="/img/page-top-bg/4.jpg" style="background-image: url('/img/page-top-bg/4.jpg');"></section>

<section class="blog-page">
<div class="container">
<div class="row">
		<div class="col-lg-12">
<div class="game-main">
<input type="hidden" id="str_num" name="str_num" value="${param.str_num}">
<input type="hidden" value="${streamkey.str_key}" id="str_key" name="str_key">
    <c:if test="${broadcast.isLive == 1}">
        <div class="container">
            <div class="video-container">
                <h1>${nick}님의 방송</h1>
                <video id="video" controls autoplay playsinline></video>
                <div class="donation-mission-container">
                <c:if test="${strnum == param.str_num}">
                	<button class="mission-button" onclick="openMissionListByStream()">미션 목록 보기</button>
                	<button class="donation-list-button" onclick="openDonationListByStream()">도네이션 목록 보기</button>
                	<button onclick="stream()">방송 종료</button>
                </c:if>
                <c:if test="${strnum != param.str_num && user != null}">
                	<button class="donation-button" onclick="openDonationModal()">도네이션 보내기</button>
                	<button class="mission-button" onclick="openMissionRequest()">미션 신청</button>
                    <button class="donation-list-button" onclick="openDonationListByMember()">도네이션 목록 보기</button>
                    <button class="mission-button" onclick="openMissionListByMember()">미션 목록 보기</button>
                </c:if>
                    
                </div>
            </div>
            <div class="chat-section font-white" >
                <div class="chat-container" id="chat-container"></div>
                <div class="chat-input-container">
                    <input type="text" id="chat-input" class="chat-input" placeholder="메시지를 입력하세요" />
                    <button id="chat-send-button" class="chat-send-button">보내기</button>
                </div>
            </div>
        </div>
    </c:if>

    <c:if test="${broadcast.isLive == null}">
        <div>
            방송하는법<br>
            <h2><a href="https://obsproject.com/ko">obs 다운로드</a><br></h2>
            obs를 다운받습니다.
            obs를 설치 후 obs화면을 열고 설정 방송를 누르고 <br>
            사용자 지정<br>
            서버:rtmp://tkdrl.iptime.org:1935/live<br>
            스트림키:${streamkey.str_key}<br>
            위 내용을 입력하고 적용을 누르고 obs로 돌아와 방송시작을 누르세요.
        </div>
        <button onclick="stream()">방송시작</button>
    </c:if>
</div>
</div>
</div>
</div>
</section>

<script>
    function openDonationModal() {
        window.open("/donation/form?str_num="+${param.str_num}, "donationForm", "width=400,height=300");
    }

    function openDonationListByStream() {
        window.open('/donation/strlist?str_num='+${param.str_num}, "donationListByStream", "width=600,height=400");
    }

    function openDonationListByMember() {
        window.open("/donation/userlist?str_num="+${param.str_num}, "donationListByMember", "width=600,height=400");
    }
    
    function openMissionRequest() {
        window.open("/mission/form?str_num=" + ${param.str_num}, "missionRequest", "width=400,height=300");
    }

    function openMissionListByStream() {
        window.open("/mission/strlist?str_num=" + ${param.str_num}, "missionListByStream", "width=600,height=400");
    }

    function openMissionListByMember() {
        window.open("/mission/userlist?str_num=" + ${param.str_num}, "missionListByMember", "width=600,height=400");
    }
    let strNum = ${param.str_num};
    let streamKey = $('#str_key').val();
</script>

<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/broadcast.js"></script>
<script src="${pageContext.request.contextPath}/js/boradchat.js"></script>