<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<c:if test="${user == null}">
<div class="result-display">
${logout}<br>
<button onclick="window.close()">닫기</button>
</div>
</c:if>
<c:if test="${user != null}">
    <h2>미션 신청</h2>
    <form id="missionForm">
    <div>(${user.mem_nickName})님의 현제 포인트 : ${point}</div>
        <label for="mission_content">내용:</label>
        <input type="text" id="mission_content" name="mission_content" required><br>
        <label for="mission_point">포인트:</label>
        <input type="number" id="mission_point" name="mission_point" required><br>
        <input type="hidden" id="str_num" name="str_num" value="${param.str_num}">
        <button type="submit">미션 보내기</button>
    </form>
    <button onclick="window.close()">닫기</button>
    </c:if>
    <script>
        $(document).ready(function() {
            $('#missionForm').submit(function(event){
                event.preventDefault(); // Prevent default form submission
                
                const missionContent = $('#mission_content').val();
                const missionPoint = $('#mission_point').val();
                const strNum = $('#str_num').val();
                const memNum = $('#mem_num').val();

                if (!missionContent || !missionPoint || !strNum) {
                    alert('내용과 포인트를 입력해주세요!');
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
                    	}else if(param.result == 'rowpoint'){
                        	alert('포인트가 부족합니다.');
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