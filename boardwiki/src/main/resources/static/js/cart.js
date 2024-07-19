$(document).ready(function() {
    $('.deleteX').click(function() {
        const mem_num = $(this).data('mem-num');
        const item_num = $(this).data('item-num');
        $.ajax({
            url: "/cart/delete",
            type: "GET",
            dataType: "json",
            data: {
                mem_num: mem_num,
                item_num: item_num
            },
            success: function(response) {
                if (response.status === 'success') {
                    alert('품목이 삭제되었습니다');
                    location.reload(); // 페이지를 새로고침하여 변경사항 반영
                } else {
                    alert('품목 삭제 실패');
                }
            },
            error: function() {
                alert('오류가 발생했습니다');
            }
        });
    });

    function updateTotalSum() {
        var totalSum = 0;
        $('.total-price').each(function() {
            var priceText = $(this).text().replace('원', '').trim();
            var price = parseInt(priceText);
            totalSum += price;
        });
        $('#total_sum_value').text(totalSum);
    }

    updateTotalSum(); // 페이지 로드 시 총합 초기화

    $('.quantity').on('change', function() {
        var itemNum = $(this).data('item-num');
        var quantity = $(this).val();
        
        $.ajax({
            type: 'POST',
            url: '/cart/cart',
            dataType: 'json',
            data: {
                item_num: itemNum,
                item_quantity: quantity
            },
            success: function(response) {
                if (response.result === 'success') {
                    var itemPrice = $('#item_price_' + itemNum).data('price');
                    var totalPrice = quantity * itemPrice;
                    $('#total_price_' + itemNum).text(totalPrice + '원');
                    updateTotalSum();
                } else if (response.result === 'overquantity') {
                    alert('재고 수량을 초과했습니다.');
                } else if (response.result === 'noitem') {
                    alert('상품이 존재하지 않습니다.');
                }
            },
            error: function() {
                alert('오류가 발생했습니다.');
            }
        });
    });
});