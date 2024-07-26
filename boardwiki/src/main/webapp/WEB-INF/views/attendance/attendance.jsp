<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
    div #daub {
        background-color: #8330B3;
    }
    table.calendar {
        box-shadow: 0 19px 38px rgba(0, 0, 0, 0.30), 0 15px 12px rgba(0, 0, 0, 0.22);
        margin: auto;
        width: 60%;
        background-color: #F2F2F2;
        height: 350px;
        border: 2px solid #320D38;
    }
    table.calendar th, table.calendar td {
    	border: 0.5px solid #fff;
        padding: 8px;
        text-align: center;
    }
    table.calendar th {
        background-color: #A8A9AD;
    }
    .current-day {
        background-color: #FFEB3B;
        color: black;
    }
    .weekdays {
        background-color: #E0E0E0;
        color: black;
    }
    .saturdays {
        background-color: lightsteelblue;
        color: blue;
    }
    .weekends {
        background-color: pink;
        color: red;
    }
    .attended {
        background-color: orange;
        color: maroon !important;
    }
    .not-attended {
        background-color: #ffcdd2;
    }
    button.but {
        display: flex;
        justify-content: center;
        align-items: center;
        margin: 30px auto;
        width: 300px;
        height: 50px;
    }
    
    button.but1 {
        display: flex;
        justify-content: center;
        align-items: center;
        margin: 30px auto 0 auto;
        width: 300px;
        height: 50px;
        
    }
    div.add {
        margin: 0 auto;
        display: flex;
        justify-content: center;
        flex-direction: row;
        align-items: center;
    }
    img#diceImage {
        margin: 0 auto;
        display: flex;
        justify-content: center;
        flex-direction: row;
        align-items: center;
        padding-bottom: 20px;
    }
    div#calendar {
        padding-top: 20px;
    }
    div #daub {
        background-color: #320D38;
    }
</style>
<section class="page-top-section set-bg" data-setbg="/img/page-top-bg/4.jpg" style="background-image: url(&quot;/img/page-top-bg/4.jpg&quot;);">
    <div class="page-info">
        <h2>출석 체크</h2>
    </div>
</section>
<div id="daub">
    <div id="calendar"></div>
    <c:if test="${att_status != 1}">
        <form action="${pageContext.request.contextPath}/attendance/check" method="post" class="but">
            <button type="submit" <c:if test="${att_status == 1}">disabled</c:if> class="but">출석 체크</button>
        </form>
    </c:if>
    <c:if test="${att_status == 1}">
        <button class="but">오늘은 이미 출석했습니다.</button>
    </c:if>
    <c:if test="${dice != 0}">
        <div class="add">주사위 굴리기 남은 횟수 : <span id="diceCount"> ${dice}</span>회</div>
        <button id="rollDiceButton" onclick="rollDice()" <c:if test="${dice == 0}">disabled</c:if> class="but">주사위 굴리기</button>
        <p id="diceResult"></p>
    	<img id="diceImage" src="${pageContext.request.contextPath}/images/dice1.png" alt="Dice" width="400" height="420">
    </c:if>
    <c:if test="${dice == 0}">
        <button class="but1">횟수를 전부 소진했습니다.</button>
     </c:if>
</div>
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
                    const currentDate = new Date();
                    const currentYear = currentDate.getFullYear();
                    const currentMonth = currentDate.getMonth();
                    const currentDay = currentDate.getDate();

                    if (date === currentDay && month === currentMonth && year === currentYear) {
                        cell.className = 'current-day';
                    } else if (j === 0) {
                        cell.className = 'weekends';
                    } else if (j === 6) {
                        cell.className = 'saturdays';
                    } else {
                        cell.className = 'weekdays';
                    }

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
        let diceImage = document.getElementById('diceImage');
        let diceResult = document.getElementById('diceResult');
        let rollDiceButton = document.getElementById('rollDiceButton');
        let diceCountElement = document.getElementById('diceCount');
        let currentFace = 1;
        let rollCount = 0;
        const maxRolls = 18; // 5 times cycle through 1 to 6 (6 * 5)
        const interval = 100; // 0.2 seconds

        rollDiceButton.disabled = true;

        const rollInterval = setInterval(() => {
            diceImage.src = '${pageContext.request.contextPath}/images/dice' + currentFace + '.png';
            currentFace = currentFace < 6 ? currentFace + 1 : 1;
            rollCount++;

            if (rollCount >= maxRolls) {
                clearInterval(rollInterval);
                fetch('${pageContext.request.contextPath}/attendance/roll-dice')
                    .then(response => response.json())
                    .then(data => {
                        diceResult.innerText = 'Rolled: ' + data;
                        diceImage.src = '${pageContext.request.contextPath}/images/dice' + data + '.png';
                        diceCountElement.innerText = parseInt(diceCountElement.innerText) - 1;
                        if (parseInt(diceCountElement.innerText) > 0) {
                            rollDiceButton.disabled = false;
                        }
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        rollDiceButton.disabled = false;
                    });
            }
        }, interval);
    }
</script>