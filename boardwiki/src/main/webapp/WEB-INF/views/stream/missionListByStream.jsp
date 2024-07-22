<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Mission List By Stream</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <h2>방송용 미션 목록</h2>
    <div>
        <c:forEach var="mission" items="${list}">
            <div>
                <p>${mission.mis_content} / ${mission.mis_point} 포인트</p>
                <c:if test="${mission.mis_status == 1}">
                    <button onclick="updateMissionStatus(${mission.mis_num}, '2')">수락</button>
                    <button onclick="updateMissionStatus(${mission.mis_num}, '5')">취소</button>
                </c:if>
                <c:if test="${mission.mis_status == 2}">
                    <button onclick="updateMissionStatus(${mission.mis_num}, '3')">성공</button>
                    <button onclick="updateMissionStatus(${mission.mis_num}, '4')">실패</button>
                </c:if>
            </div>
        </c:forEach>
    </div>
    <script>
        function updateMissionStatus(mis_num, mis_status) {
            $.ajax({
                url: '/mission/updateStatus',
                data: {
                    mis_num: mis_num,
                    mis_status: mis_status
                },
                dataType: 'json',
                type: 'post',
                success: function(response){
                    alert(response);
                    location.reload();
                },
                error: function(){
                    alert('에러발생');
                }
            });
        }
    </script>
</body>
</html>