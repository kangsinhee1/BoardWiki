<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<style>
.video-container {
	width: 70%;
	margin: auto;
	text-align: center;
}

video {
	width: 100%;
	height: auto;
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
<script src="https://cdn.socket.io/4.0.1/socket.io.min.js"></script>

<div class="video-container">
	<h1>${broadcast.mem_num}님의 방송</h1>
	<video id="video" controls></video>
</div>
<div class="chat-container" id="chat-container">
	<h2>Live Chat</h2>
	<div id="messages"></div>
	<input id="message-input" type="text"
		placeholder="Type your message..." />
	<button onclick="sendMessage()">Send</button>
</div>

<script>
    document.addEventListener('DOMContentLoaded', () => {
        const streamKey = '${broadcast.str_key}';

        if (Hls.isSupported()) {
            const video = document.getElementById('video');
            const hls = new Hls();
            hls.loadSource('http://192.168.0.10:8000/hls/' + streamKey + '.m3u8');
            hls.attachMedia(video);
            hls.on(Hls.Events.MANIFEST_PARSED, () => {
                video.play();
            });
        } else if (video.canPlayType('application/vnd.apple.mpegurl')) {
            video.src = 'http://192.168.0.10:8000/hls/' + streamKey + '.m3u8';
            video.addEventListener('canplay', () => {
                video.play();
            });
        }
    });
</script>
