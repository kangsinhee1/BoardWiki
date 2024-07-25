<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Page</title>
    
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.9.0/fullcalendar.min.css" rel="stylesheet" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.9.0/fullcalendar.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css" type="text/css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css" type="text/css">
    <style>
        .fc-unthemed td.fc-today {
            background: #C213B6;
        }
        .profile-img {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            object-fit: cover;
        }
        .mypage-main-content li {
            list-style: none;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <div class="row">
        <div class="col-md-4">
            <div class="card">
                <div class="card-body text-center">
                    <c:if test="${empty member.mem_photo }">
                        <img src="${pageContext.request.contextPath}/images/face.png" class="profile-img mb-3" alt="Profile Image">
                    </c:if>
                    <c:if test="${!empty member.mem_photo }">
                        <img src="${pageContext.request.contextPath}/images/${member.mem_photo}" class="profile-img mb-3" alt="Profile Image">
                    </c:if>
                    <h5 style="color:white">${member.mem_name}</h5>
                    <p class="card-text">이메일: ${member.mem_email}</p>
                    <p class="card-text">닉네임: ${member.mem_nickName}</p>
                    <c:if test="${member.mem_mdate == null}">
                        <p class="card-text">계정생성일: ${member.mem_rdate}</p>
                    </c:if>
                    <c:if test="${member.mem_mdate != null}">
                        <p class="card-text">계정수정일: ${member.mem_mdate}</p>
                    </c:if>
                    <c:if test="${member.mem_provider != null }">
                        <p class="card-text">가입 플랫폼: ${member.mem_provider}</p>
                    </c:if>
                    <input type="button" value="회원번호 수정" class="mypage-btn"
                    onclick="location.href='${pageContext.request.contextPath}/member/memberUpdate'">
                    <c:if test="${member.mem_provider == null }">
	                    <input type="button" value="비밀번호 변경" class="mypage-btn" 
	                    onclick="location.href='${pageContext.request.contextPath}/member/changePassword'">
                    </c:if>
                    <input type="button" value="회원탈퇴" class="mypage-btn"
	                    onclick="location.href='${pageContext.request.contextPath}/member/memberDelete'">
                </div>
            </div>
        </div>
        <div class="col-md-8">
	<!--                     <hr size="1" noshade="noshade" width="90%">
	 -->                    <div id='calendar' class="calendar"></div>
              
        </div>
    </div>
</div>

<script>
    var jb = jQuery.noConflict();
    jb(document).ready(function() {
        jb('#calendar').fullCalendar({
            editable: true,
            events: '/events',
            selectable: true,
            selectHelper: true,
            select: function(start, end) {
                var title = prompt('Event Title:');
                var eventData;
                if (title) {
                    eventData = {
                        title: title,
                        start: start.format(),
                        end: end.format()
                    };
                    $.ajax({
                        url: '/events',
                        type: 'POST',
                        contentType: 'application/json',
                        data: JSON.stringify(eventData),
                        success: function() {
                            jb('#calendar').fullCalendar('refetchEvents');
                        }
                    });
                }
                jb('#calendar').fullCalendar('unselect');
            },
            eventDrop: function(event) {
                var eventData = {
                    title: event.title,
                    start: event.start.format(),
                    end: event.end ? event.end.format() : null
                };
                $.ajax({
                    url: '/events/' + event.id,
                    type: 'PUT',
                    contentType: 'application/json',
                    data: JSON.stringify(eventData),
                    success: function() {
                        jb('#calendar').fullCalendar('refetchEvents');
                    }
                });
            },
            eventResize: function(event) {
                var eventData = {
                    title: event.title,
                    start: event.start.format(),
                    end: event.end ? event.end.format() : null
                };
                $.ajax({
                    url: '/events/' + event.id,
                    type: 'PUT',
                    contentType: 'application/json',
                    data: JSON.stringify(eventData),
                    success: function() {
                        jb('#calendar').fullCalendar('refetchEvents');
                    }
                });
            },
            eventClick: function(event) {
                if (confirm("Do you really want to delete?")) {
                    $.ajax({
                        url: '/events/' + event.id,
                        type: 'DELETE',
                        success: function() {
                            jb('#calendar').fullCalendar('refetchEvents');
                        }
                    });
                }
            }
        });
    });
</script>
</body>
</html>
