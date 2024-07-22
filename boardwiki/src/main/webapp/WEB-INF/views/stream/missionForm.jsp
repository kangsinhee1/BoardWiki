<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Mission Form</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <h2>미션 신청</h2>
    <form id="missionForm">
        <label for="mission_content">내용:</label>
        <input type="text" id="mission_content" name="mission_content" required><br>
        <label for="mission_point">포인트:</label>
        <input type="number" id="mission_point" name="mission_point" required><br>
        <input type="hidden" id="str_num" name="str_num" value="${param.str_num}">
        <button type="submit">미션 보내기</button>
    </form>
    <script>
        $(document).ready(function() {
            $('#missionForm').submit(function(event){
                event.preventDefault(); // Prevent default form submission
                
                const missionContent = $('#mission_content').val();
                const missionPoint = $('#mission_point').val();
                const strNum = $('#str_num').val();
                const memNum = $('#mem_num').val();

                if (!missionContent || !missionPoint || !strNum) {
                    alert('All fields are required.');
                    return;
                }

                $.ajax({
                    url: '/mission/add',
                    data: {
                        str_num: strNum,
                        mis_content: missionContent,
                        mis_point: missionPoint
                    },
                    dataType: 'json',
                    type: 'get',
                    success: function(param){
                    	if(param.result =='logout'){
                    		alert('로그인 필요');
                    		window.close();
                    		
                    	}else if(param.result =='success'){
                    		alert('미션 성공');
                            window.close();
                    	}else{
                    		alert('오류발생');
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