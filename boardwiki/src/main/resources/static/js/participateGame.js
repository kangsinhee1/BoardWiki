$(document).ready(function() {
    $('#participateGameForm').submit(function(e) {
        e.preventDefault();

        const gameId = $('#gameId').val();
        const betPoints = $('#betPoints').val();
        const choice = $('input[name="choice"]:checked').val();
        const poiG_num = $('#poiG_num').val();

        const formData = {
            poiO_num: choice,
            bet_point: betPoints,
            gameId: gameId,
            poiG_num: poiG_num
        };

        $.ajax({
            type: 'POST',
            url: '/pointgame/bet',
            contentType: 'application/json',
            data: JSON.stringify(formData),
            success: function(response) {
                if (response.result == "logout") {
                    alert('로그인 필요');
                } else if (response.result == "error") {
                    alert('당신이 걸었던 포인트는 당신이 가지고 있는 포인트보다 높습니다.');
                }else if (response.result == "autolet") {
                    alert('게임 생성자는 참여불가');
                }else if(response.result == "regame"){
					alert('당신은 이미 게임에 참여했습니다.');
                } else {
                    alert('배팅 완료');
                    window.location.href = '/pointgame/list';
                }
            },
            error: function(error) {
                alert('배팅 에러발생');
            }
        });
    });
});
