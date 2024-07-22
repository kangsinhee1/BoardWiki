<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Mission List By Member</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <h2>유저용 미션 목록</h2>
    <div>
        <c:forEach var="mission" items="${list}">
            <div>
                <p>${mission.mis_content} / ${mission.mis_point} 포인트</p>
                <c:if test="${mission.mis_status == 1}">
                    <button onclick="deleteMission(${mission.mis_num})">취소</button>
                </c:if>
                <c:if test="${mission.mis_status == 2}">
                    <p>수락됨</p>
                    <button onclick="updateMissionStatus(${mission.mis_num}, '3')">성공</button>
                    <button onclick="updateMissionStatus(${mission.mis_num}, '4')">실패</button>
                </c:if>
                <c:if test="${mission.mis_status == 3}">
                    <p>성공</p>
                </c:if>
                <c:if test="${mission.mis_status == 4}">
                    <p>실패</p>
                </c:if>
            </div>
        </c:forEach>
        <div class="align-center">${page}</div>
    </div>
    <script>
        function deleteMission(mis_num) {
            $.ajax({
                url: '/mission/delete',
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