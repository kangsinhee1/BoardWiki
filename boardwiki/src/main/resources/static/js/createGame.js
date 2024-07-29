$(document).ready(function() {
    let choiceCount = 2;

    $('#addChoice').click(function() {
        if (choiceCount < 6) {
            $('#choicesContainer').append('<div class="choice"><input type="text" name="choices" required></div>');
            choiceCount++;
        }
    });
    
    $('#addChoice2').click(function() {
        if (choiceCount > 2) {
            $('#choicesContainer').append('<div class="choice"><input type="text" name="choices" required></div>');
            choiceCount--;
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
                if (response.result == "logout") {
                    alert('로그인 필요');
                } else {
                    alert('게임 생성');
                    window.location.href = '/pointgame/list';
                }
            },
            error: function(error) {
                alert('게임 생성 에러');
            }
        });
    });
});

