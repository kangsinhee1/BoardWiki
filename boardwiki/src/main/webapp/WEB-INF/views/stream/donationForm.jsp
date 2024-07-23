<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<c:if test="${user == null}">
<div class="result-display">
${logout}
<button onclick="window.close()">닫기</button>
</div>
</c:if>
<c:if test="${user != null}">
    <h2>도네이션 입력</h2>
    <form id="donationForm">
    <div>(${user.mem_nickName})님의 현제 포인트 : ${point}</div>
        <label for="don_content">내용:</label>
        <input type="text" id="don_content" name="don_content"><br>
        <label for="don_point">포인트:</label>
        <input type="number" id="don_point" name="don_point"><br>
        <input type="hidden" id="str_num" name="str_num" value="${param.str_num}">
        <button type="submit" id="donation">도네이션 보내기</button>
    </form>
    <button onclick="window.close()">닫기</button>
</c:if>
    <script>
        $(document).ready(function() {
            $('#donationForm').submit(function(event){
                event.preventDefault(); // Prevent default form submission
                const don_point = $('#don_point').val();
                const don_content = $('#don_content').val();
                const str_num = $('#str_num').val();
				
                if (!don_point || !don_content) {
                    alert('내용과 포인트를 입력해주세요!');
                    return;
                }
                
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
                        }else if(param.result == 'logout'){
                        	alert('로그인 해야합니다.');
                        	window.close();
                        }else if(param.result == 'rowpoint'){
                        	alert('포인트가 부족합니다.');
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