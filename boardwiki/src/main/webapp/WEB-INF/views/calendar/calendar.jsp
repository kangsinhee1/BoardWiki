<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href='https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.9.0/fullcalendar.min.css' rel='stylesheet' />
    <script src='https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js'></script>
    <script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js'></script>
    <script src='https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.9.0/fullcalendar.min.js'></script>
    <div id='calendar'></div>

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