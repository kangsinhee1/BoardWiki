$(document).ready(function() {
    // Fetch and display games
    $.ajax({
        type: 'GET',
        url: '/pointgame/list',
        success: function(response) {
            const games = response.games;
            const userId = response.userId;
            const gameListContainer = $('#gameListContainer');

            if (games.length > 0) {
                games.forEach(game => {
                    const gameElement = $('<div></div>').text(game.name);
                    const participateButton = $('<button>Participate</button>').click(function() {
                        checkParticipation(game.id, userId);
                    });

                    gameElement.append(participateButton);
                    gameListContainer.append(gameElement);
                });
            } else {
                gameListContainer.text('No games available.');
            }
        }
    });

    // Redirect to create game page
    $('#createGameButton').click(function() {
        window.location.href = 'createGame.jsp';
    });
});

function checkParticipation(gameId, userId) {
    $.ajax({
        type: 'GET',
        url: '/pointgame/checkParticipation',
        data: { gameId: gameId, userId: userId },
        success: function(response) {
            if (response.isCreator) {
                alert('You cannot participate in your own game.');
            } else if (response.hasParticipated) {
                if (confirm('You have already participated in this game. Do you want to cancel your participation?')) {
                    cancelParticipation(gameId, userId);
                }
            } else {
                window.location.href = `participateGame.jsp?gameId=${gameId}`;
            }
        }
    });
}

function cancelParticipation(gameId, userId) {
    $.ajax({
        type: 'POST',
        url: '/pointgame/cancelParticipation',
        contentType: 'application/json',
        data: JSON.stringify({ gameId: gameId, userId: userId }),
        success: function(response) {
            alert('Participation cancelled.');
            location.reload();
        }
    });
}
