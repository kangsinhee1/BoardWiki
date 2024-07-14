$(function() {
    function returnRent(rentNum) {
        if (confirm("반납하시겠습니까?")) {
            $.ajax({
                url: 'rent/return',
                type: 'POST',
                data: { rent_num: rentNum },
                dataType: 'json',
                success: function(response) {
                    if (response.success) {
                        alert("반납되었습니다.");
                        location.reload(); // 페이지 새로고침
                    } else {
                        alert("반납 처리 중 오류가 발생하였습니다.");
                    }
                },
                error: function() {
                    alert("네트워크 오류");
                }
            });
        }
    }

    // 대여중 링크에 이벤트 리스너 추가
    $('a.rent-status').on('click', function(e) {
        e.preventDefault(); // 기본 동작 방지
        var rentNum = $(this).data('rent-num');
        returnRent(rentNum);
    });
});
