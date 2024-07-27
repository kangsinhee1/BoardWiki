<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href='https://fullcalendar.io/releases/core/4.0.2/main.min.css' rel='stylesheet' />
    <link href='https://fullcalendar.io/releases/daygrid/4.0.2/main.min.css' rel='stylesheet' />
    <script src='https://fullcalendar.io/releases/core/4.0.2/main.min.js'></script>
    <script src='https://fullcalendar.io/releases/daygrid/4.0.2/main.min.js'></script>
    <script src='https://fullcalendar.io/releases/interaction/4.0.2/main.min.js'></script>
    <script>

    document.addEventListener('DOMContentLoaded', function() {
        var calendarEl = document.getElementById('calendar');

        var calendar = new FullCalendar.Calendar(calendarEl, {
            plugins: [ 'dayGrid', 'interaction' ],
            editable: true,
            events: function(fetchInfo, successCallback, failureCallback) {
                fetch('/events/user/1')  // Change 1 to the actual user ID
                    .then(response => response.json())
                    .then(data => successCallback(data));
            },
            dateClick: function(info) {
                var title = prompt('Enter Event Title:');
                var event = {
                    title: title,
                    startDate: info.dateStr,
                    endDate: info.dateStr,
                    memNum: 1 // Change to actual user ID
                };

                fetch('/events/save', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify(event),
                })
                .then(response => response.json())
                .then(data => {
                    calendar.addEvent(data);
                });
            },
            eventClick: function(info) {
                if (confirm('Are you sure you want to delete this event?')) {
                    fetch('/events/delete/' + info.event.id, {
                        method: 'DELETE'
                    })
                    .then(response => {
                        if (response.ok) {
                            info.event.remove();
                        } else {
                            alert('Failed to delete event');
                        }
                    });
                }
            }
        });

        calendar.render();
    });

    </script>
    <div id='calendar'></div>