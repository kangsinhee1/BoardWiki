function stream(){
	$.ajax({
		url:'/streaming/start',
		data:{str_num:strNum},
		type:'post',
		dataType:'json',
		success: function(param) {
			if(param.result=='logout'){
				alert('로그인 필요');
			}else if(param.result=='start'){
				location.reload();
			}else if(param.result=='stop'){
				alert('방송 종료');
				location.reload();
			}else if(param.result=='newkey'){
				alert('스트림키가 생성되었습니다.');
			}else{
				alert('오류발생');
			}
		},
		error:function(){
			alert('네트워크오류발생');
		}
	})
}

    document.addEventListener('DOMContentLoaded', () => {
        const video = document.getElementById('video');

        function loadStream() {
            if (Hls.isSupported()) {
                const hls = new Hls({
                    liveSyncDurationCount: 3, // Reduce buffer to 3 fragments
                    maxBufferLength: 5, // Keep buffer length low
                });
                hls.loadSource('http://tkdrl.iptime.org:8000/hls/' + streamKey + '.m3u8');
                hls.attachMedia(video);
                hls.on(Hls.Events.MANIFEST_PARSED, () => {
                    video.play();
                });
                hls.on(Hls.Events.ERROR, (event, data) => {
                    if (data.fatal) {
                        switch(data.type) {
                            case Hls.ErrorTypes.NETWORK_ERROR:
                                console.error('Network error encountered, trying to recover.');
                                hls.startLoad();
                                break;
                            case Hls.ErrorTypes.MEDIA_ERROR:
                                console.error('Media error encountered, trying to recover.');
                                hls.recoverMediaError();
                                break;
                            default:
                                hls.destroy();
                                loadStream(); // Reload the stream
                                break;
                        }
                    }
                });
            } else if (video.canPlayType('application/vnd.apple.mpegurl')) {
                video.src = 'http://tkdrl.iptime.org/hls/' + streamKey + '.m3u8';
                video.addEventListener('canplay', () => {
                    video.play();
                });
            }
        }

        loadStream(); // Initial load

        video.addEventListener('click', () => {
            loadStream(); // Reload the stream on click
        });
    });
