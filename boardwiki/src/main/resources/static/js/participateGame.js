$(document).ready(function() {
    $('#participateGameForm').submit(function(e) {
        e.preventDefault();

        const formData = {
            poiO_num: $('input[name="choice"]:checked').val(),
            bet_point: $('#betPoints').val()
        };

        $.ajax({
            type: 'POST',
            url: '/pointgame/bet',
            contentType: 'application/json',
            data: JSON.stringify(formData),
            success: function(response) {
                alert('Bet placed successfully!');
                window.location.href = '/game/list';
            },
            error: function(error) {
                alert('Error placing bet!');
            }
        });
    });
});
