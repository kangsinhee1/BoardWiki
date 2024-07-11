<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link href='https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.9.0/fullcalendar.min.css' rel='stylesheet' />
<script src='https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js'></script>
<script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js'></script>
<script src='https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.9.0/fullcalendar.min.js'></script>
<br>
<hr size="1" noshade="noshade" width="90%">
<c:if test="${empty member.mem_photo }">
<div id="my-photo">
	<img src="${pageContext.request.contextPath}/images/face.png" width="100" height="100" class="my-photo">
</div>
</c:if>
<c:if test="${!empty member.mem_photo }">
	<img src="${pageContext.request.contextPath}/images/" width="100" height="100" class="my-photo">
</c:if>
<ul class="mypage-main-content">
	<li>이름 : ${member.mem_name }</li>
	<li>이메일 : ${member.mem_email }</li>
	<li>계정생성일 : ${member.mem_rdate }</li>
	<li><input type="button" value="회원번호 수정" onclick="location.href='modifyMember'"></li>
</ul>
<br><br><br><br><br>
<h6 id="schedule"><a href="${pageContext.request.contextPath}/member/calendar">일정</a></h6>
<hr size="1" noshade="noshade" width="90%">
<div id='calendar' class="calendar"></div>


    <script>
        $(document).ready(function() {
            $('#calendar').fullCalendar({
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
                                $('#calendar').fullCalendar('refetchEvents');
                            }
                        });
                    }
                    $('#calendar').fullCalendar('unselect');
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
                            $('#calendar').fullCalendar('refetchEvents');
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
                            $('#calendar').fullCalendar('refetchEvents');
                        }
                    });
                },
                eventClick: function(event) {
                    if (confirm("Do you really want to delete?")) {
                        $.ajax({
                            url: '/events/' + event.id,
                            type: 'DELETE',
                            success: function() {
                                $('#calendar').fullCalendar('refetchEvents');
                            }
                        });
                    }
                }
            });
        });
    </script>