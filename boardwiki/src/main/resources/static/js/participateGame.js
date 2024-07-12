$(document).ready(function() {
    $('#participateGameForm').submit(function(e) {
        e.preventDefault();

        const gameId = $('#gameId').val();
        const betPoints = $('#betPoints').val();
        const choice = $('input[name="choice"]:checked').val();
        const poiG_num = $('#poiG_num').val();

        // Debugging logs
        console.log('Game ID:', gameId);
        console.log('Bet Points:', betPoints);
        console.log('Choice:', choice);

        if (!gameId || gameId.trim() === '') {
            alert('Game ID is required.');
            return;
        }

        if (!betPoints || betPoints.trim() === '') {
            alert('Bet Points are required.');
            return;
        }

        if (!choice) {
            alert('You must select a choice.');
            return;
        }
        
        if (!poiG_num || poiG_num.trim() === '') {
            alert('Game ID is required.');
            return;
        }

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
                    alert(response.message);
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
