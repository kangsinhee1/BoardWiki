<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Monthly Attendance</title>
    <style>
        table.calendar {
            width: 100%;
            border-collapse: collapse;
        }
        table.calendar th, table.calendar td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }
        table.calendar th {
            background-color: #f2f2f2;
        }
        .attended {
            background-color: purple;
            color: white;
        }
        .not-attended {
            background-color: #ffcdd2;
        }
    </style>
</head>
<body>
    <h1>Monthly Attendance</h1>
    <div id="calendar"></div>

    <form action="${pageContext.request.contextPath}/attendance/check" method="post">
        <button type="submit" <c:if test="${att_status == 1 }">disabled</c:if>>출석 체크</button>
    </form>
    <button onclick="rollDice()">주사위 굴리기</button>
    <p id="diceResult"></p>

    <script>
    	const attendances = JSON.parse('${attendancesJson}');

        function generateCalendar(month, year) {
            const calendar = document.getElementById('calendar');
            calendar.innerHTML = '';

            const daysOfWeek = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
            const table = document.createElement('table');
            table.className = 'calendar';

            const headerRow = document.createElement('tr');
            daysOfWeek.forEach(day => {
                const th = document.createElement('th');
                th.innerText = day;
                headerRow.appendChild(th);
            });
            table.appendChild(headerRow);

            const firstDay = new Date(year, month, 1).getDay();
            const daysInMonth = new Date(year, month + 1, 0).getDate();
            let date = 1;

            for (let i = 0; i < 6; i++) {
                const row = document.createElement('tr');

                for (let j = 0; j < 7; j++) {
                    const cell = document.createElement('td');

                    if (i === 0 && j < firstDay) {
                        cell.innerText = '';
                    } else if (date > daysInMonth) {
                        break;
                    } else {
                        const attendance = attendances.find(a => new Date(a.att_date).getDate() === date);
                        cell.innerText = date;
                        if (attendance) {
                            cell.className = attendance.att_status === 1 ? 'attended' : 'not-attended';
                        }
                        date++;
                    }
                    row.appendChild(cell);
                }
                table.appendChild(row);
            }
            calendar.appendChild(table);
        }

        const now = new Date();
        generateCalendar(now.getMonth(), now.getFullYear());

        function rollDice() {
            fetch('${pageContext.request.contextPath}/roll-dice')
                .then(response => response.json())
                .then(data => {
                    document.getElementById('diceResult').innerText = 'Rolled: ' + data;
                });
        }
    </script>
</body>
</html>