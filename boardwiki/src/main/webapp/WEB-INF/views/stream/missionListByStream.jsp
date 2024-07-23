<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<h2>방송용 미션 목록</h2>
<c:if test="${count == 0}">
       <div class="result-display">표시할 게시물이 없습니다.</div>
</c:if>
<c:if test="${count > 0}">
    <div>
        <c:forEach var="mission" items="${list}">
            <div>
                <p>${mission.mis_content} / ${mission.mis_point} 포인트</p>
                <c:if test="${mission.mis_status == 1}">
                    <button onclick="updateMissionStatus(${mission.mis_num}, '2', 0)">수락</button>
                    <button onclick="deleteMission(${mission.mis_num}, ${mission.mis_point}, ${mission.mem_num})">취소</button>
                </c:if>
                <c:if test="${mission.mis_status == 2}">
                    <button onclick="updateMissionStatus(${mission.mis_num}, '3', ${mission.mis_point}, ${mission.mem_num})">성공</button>
                    <button onclick="updateMissionStatus(${mission.mis_num}, '4', ${mission.mis_point}, ${mission.mem_num})">실패</button>
                </c:if>
            </div>
        </c:forEach>
        <div class="align-center">${page}</div>
    </div>
    </c:if>
    <script>
    function deleteMission(mis_num, mis_point, mem_num) {
        $.ajax({
            url: '/mission/delete',
            data: {
                mis_num: mis_num,
                mis_point:mis_point,
                mem_num:mem_num
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
    
        function updateMissionStatus(mis_num, mis_status, min_point, mem_num) {
            $.ajax({
                url: '/mission/updateStatus',
                data: {
                    mis_num: mis_num,
                    mis_status: mis_status,
                    mis_point:mis_point,
                    mem_num:mem_num
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