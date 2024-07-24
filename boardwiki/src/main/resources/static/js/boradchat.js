document.addEventListener("DOMContentLoaded", function() {
    const socket = new WebSocket('ws://localhost:8000/message-ws');

    socket.onopen = function() {
        console.log('시작');
    };

    socket.onclose = function() {
        console.log('종료');
    };

    socket.onerror = function(error) {
        console.error('에러:', error);
    };

    // 채팅 메시지를 채팅 컨테이너에 추가하는 함수
    function appendChatMessage(mem_nickName, message) {
        console.log('Appending chat message:', mem_nickName, message);
        const messageElement = $('<div></div>').text(mem_nickName + ': ' + message);
        $('#chat-container').append(messageElement);
    }

    // 도네이션 메시지를 채팅 컨테이너에 강조하여 추가하는 함수
    function appendDonationMessage(donation) {
        console.log('Appending donation message:', donation.mem_nickName, donation.don_content);
        const messageElement = $('<div></div>').text(donation.mem_nickName + ': ' + donation.don_content)
            .css({
                'border': '2px solid red',
                'padding': '10px',
                'margin': '10px 0',
                'background-color': '#ffe6e6'
            });
        $('#chat-container').append(messageElement);
    }

    // 도네이션 메시지를 도네이션 목록에 추가하는 함수
    function appendDonation(donation, listId) {
        console.log('Appending donation:', donation);
        const newRow = `
            <tr>
                <td class="align-center">${donation.don_content}</td>
                <td class="align-center">${donation.don_point}</td>
                <td class="align-center">${donation.mem_nickName}</td>
                <td class="align-center">${donation.don_date}</td>
            </tr>
        `;
        document.querySelector(`#${listId} tbody`).insertAdjacentHTML('beforeend', newRow);
    }

    // 초기 채팅 메시지 로드
    function loadChatMessages() {
        $.ajax({
            url: `/streaming/messages`,
            type: 'GET',
            data: { str_num: strNum },
            success: function(data) {
                $('#chat-container').empty();
                data.forEach(message => {
                    appendChatMessage(message.mem_nickName, message.strt_chat);
                });
            },
            error: function() {
                console.error('에러 발생 :', error);
            }
        });
    }

    socket.onmessage = function(event) {
        const data = JSON.parse(event.data);
        console.log('Received data:', data);
        if (data.strt_chat) {
            appendChatMessage(data.mem_nickName, data.strt_chat);
        } else if (data.don_content) {
            appendDonationMessage(data); // 채팅 창에 도네이션 메시지 추가
            if (document.getElementById('donation-list')) {
                appendDonation(data, 'donation-list');
            }
            if (document.getElementById('donation-list2')) {
                appendDonation(data, 'donation-list2');
            }
        }
    };

    if (document.getElementById('donationForm')) {
        const donationForm = document.getElementById('donationForm');
        donationForm.addEventListener('submit', function(event) {
            event.preventDefault();
            const don_point = document.getElementById('don_point').value;
            const don_content = document.getElementById('don_content').value;
            const str_num = strNum;
            const mem_nickName = memNickname;

            if (!don_point || !don_content) {
                alert('내용과 포인트를 입력해주세요!');
                return;
            }

            const donationData = {
                str_num: str_num,
                don_content: don_content,
                don_point: don_point,
                mem_nickName: mem_nickName,
                don_date: new Date().toISOString()
            };

            $.ajax({
                url: '/donation/add',
                data: donationData,
                dataType: 'json',
                type: 'get',
                success: function(param) {
                    if (param.result == 'success') {
                        alert('도네이션을 전송하였습니다.');
                        socket.send(JSON.stringify(donationData));
                        appendDonationMessage(donationData); // 채팅 창에 도네이션 메시지 추가
                        window.close();
                    } else if (param.result == 'logout') {
                        alert('로그인 해야합니다.');
                        window.close();
                    } else if (param.result == 'rowpoint') {
                        alert('포인트가 부족합니다.');
                    }
                },
                error: function() {
                    alert('에러발생');
                }
            });
        });
    }

    // 새로운 채팅 메시지를 AJAX와 WebSocket을 통해 전송하는 함수
    function sendChatMessage() {
        const message = $('#chat-input').val();
        if (message.trim() !== "") {
            const messageData = { str_num: strNum, strt_chat: message };

            $.ajax({
                url: '/streaming/send',
                type: 'POST',
                dataType: 'json',
                data: messageData,
                success: function(param) {
                    if (param.result == 'success') {
                        const nickname = param.mem_nickName;
                        socket.send(JSON.stringify({ mem_nickName: nickname, strt_chat: message }));
                    }
                    $('#chat-input').val('');
                },
                error: function() {
                    alert('메시지 전송 실패');
                }
            });
        } else {
            alert('메시지를 입력해주세요');
        }
    }

    $('#chat-send-button').on('click', sendChatMessage);
    $('#chat-input').on('keypress', function(event) {
        if (event.key === 'Enter') {
            sendChatMessage();
        }
    });

    loadChatMessages(); // 초기 채팅 메시지 로드
});