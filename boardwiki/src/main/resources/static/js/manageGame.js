$(document).ready(function() {
    $('.cancelGameButton').click(function() {
        const gameId = $(this).data('game-id');

        $.ajax({
            type: 'POST',
            url: '/pointgame/cancelGame',
            contentType: 'application/json',
            data: JSON.stringify({ gameId: gameId }),
            success: function(response) {
                if (response.result === "success") {
                    alert('Game cancelled successfully.');
                    location.reload();
                } else {
                    alert('Error cancelling game: ' + response.message);
                }
            },
            error: function(error) {
                alert('Error cancelling game.');
            }
        });
    });

    $('.selectWinnerButton').click(function() {
        const gameId = $(this).data('game-id');
        const winningOption = $('#winningOption_' + gameId).val();

        $.ajax({
            type: 'POST',
            url: '/pointgame/selectWinner',
            contentType: 'application/json',
            data: JSON.stringify({ gameId: gameId, winningOption: winningOption }),
            success: function(response) {
                if (response.result === "success") {
                    alert('Winner selected successfully.');
                    location.reload();
                } else {
                    alert('Error selecting winner: ' + response.message);
                }
            },
            error: function(error) {
                alert('Error selecting winner.');
            }
        });
    });
});