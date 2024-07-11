$(document).ready(function() {
    let choiceCount = 2;

    $('#addChoice').click(function() {
        if (choiceCount < 6) {
            $('#choicesContainer').append('<div class="choice"><input type="text" name="choices" required></div>');
            choiceCount++;
        }
    });

    $('#createGameForm').submit(function(e) {
        e.preventDefault();

        const formData = {
            poiG_content: $('#gameTitle').val(),
            choices: []
        };

        $('input[name="choices"]').each(function() {
            formData.choices.push($(this).val());
        });

        $.ajax({
            type: 'POST',
            url: '/pointgame/create',
            contentType: 'application/json',
            data: JSON.stringify(formData),
            success: function(response) {
                alert('Game created successfully!');
                window.location.href = '/game/list';
            },
            error: function(error) {
                alert('Error creating game!');
            }
        });
    });
});
