<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Donation Form</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <h2>도네이션 입력</h2>
    <form id="donationForm">
        <label for="don_content">내용:</label>
        <input type="text" id="don_content" name="don_content"><br>
        <label for="don_point">포인트:</label>
        <input type="number" id="don_point" name="don_point"><br>
        <input type="hidden" id="str_num" name="str_num" value="${param.str_num}">
        <button type="submit" id="donation">도네이션 보내기</button>
    </form>
    <script>
        $(document).ready(function() {
            $('#donationForm').submit(function(event){
                event.preventDefault(); // Prevent default form submission
                
                const don_content = $('#don_content').val();
                const don_point = $('#don_point').val();
                const str_num = $('#str_num').val();

                $.ajax({
                    url: '/donation/add',
                    data: {
                        str_num: str_num,
                        don_content: don_content,
                        don_point: don_point
                    },
                    dataType: 'json',
                    type: 'get',
                    success: function(param){
                        if(param.result == 'success'){
                            alert('도네이션 성공');
                            window.close();
                        }
                    },
                    error: function(){
                        alert('에러발생');
                    }
                });
            });
        });
    </script>
</body>
</html>