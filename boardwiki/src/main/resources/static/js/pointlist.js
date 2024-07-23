$(document).ready(function() {
        $('.dropdown-content a').on('click', function(event) {
            event.preventDefault();
            var url = $(this).attr('href');
            $.ajax({
                url: url,
                success: function(response) {
                    $('.page-main').html($(response).find('.page-main').html());
                },
                error: function() {
                    alert('Error loading content');
                }
            });
        });

        $('#myForm').on('submit', function(event) {
            event.preventDefault();
            var form = $(this);
            $.ajax({
                type: form.attr('method'),
                url: form.attr('action'),
                data: form.serialize(),
                success: function(response) {
                    alert('Form submitted successfully');
                    history.back(); // 이전 페이지로 돌아가기
                },
                error: function() {
                    alert('Form submission failed');
                }
            });
        });
    });