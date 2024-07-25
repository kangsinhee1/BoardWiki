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
        const messageElement = $('<div></div>').text(mem_nickName + ': ' + message);
        $('#chat-container').append(messageElement);
    }

    // 도네이션 메시지를 채팅 컨테이너에 강조하여 추가하는 함수
    function appendDonationMessage(donation) {
        const messageElement = $('<div></div>').text(donation.mem_nickName + ': ' + donation.don_content)
            .css({
                'border': '2px solid red',
                'padding': '10px',
                'margin': '10px 0',
                'background-color': '#ffe6e6'
            });
        $('#chat-container').append(messageElement);
        $('#chat-container').scrollTop($("#chat-container")[0].scrollHeight);
    }

    // 도네이션 메시지를 도네이션 목록에 추가하는 함수
    function appendDonation(donation, listId) {
        const newRow = `
            <tr>
                <td class="align-center">${donation.don_content}</td>
                <td class="align-center">${donation.don_point}</td>
                <td class="align-center">${donation.mem_nickName}</td>
                <td class="align-center">${donation.don_date}</td>
            </tr>
        `;
        const listElement = document.querySelector(`#${listId} tbody`);
        if (listElement) {
            listElement.insertAdjacentHTML('beforeend', newRow);
        } else {
            console.error(`Element with id ${listId} not found.`);
        }
    }

    // 초기 채팅 메시지 로드
    function loadChatMessages() {
        // 로딩 스피너 표시
        $('#chat-container').html('<div class="spinner">Loading...</div>');

        $.ajax({
            url: `/streaming/messages`,
            type: 'GET',
            data: { str_num: strNum },
            success: function(data) {
                $('#chat-container').empty();
                if (data && data.length > 0) {
                    data.forEach(message => {
                        appendChatMessage(message.mem_nickName, message.strt_chat);
                    });
                } else {
                    $('#chat-container').html('<p>No messages found.</p>');
                }

                // #chat-container가 존재하는지 확인하고 scrollHeight를 설정
                const chatContainer = $("#chat-container")[0];
                if (chatContainer) {
                    $('#chat-container').scrollTop(chatContainer.scrollHeight);
                }
            },
            error: function(error) {
                console.error('에러 발생 :', error);
                $('#chat-container').html('<p class="error">메시지를 로드하는 중 오류가 발생했습니다. 나중에 다시 시도하세요.</p>');
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
        } else if (data.mis_content) {
            if (document.getElementById('mission-list')) {
                appendMission(data, 'mission-list');
            }
            if (document.getElementById('mission-list2')) {
                appendMission(data, 'mission-list2');
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
			
			var today = new Date();

			var year = today.getFullYear();
			var month = ('0' + (today.getMonth() + 1)).slice(-2);
			var day = ('0' + today.getDate()).slice(-2);

			var dateString = year + '-' + month  + '-' + day;
			
            const donationData = {
                str_num: str_num,
                don_content: don_content,
                don_point: don_point,
                mem_nickName: mem_nickName,
                don_date: dateString
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
                        loadChatMessages();
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
    
    // 미션을 미션 목록에 추가하는 함수
    function appendMission(mission, listId) {
        let missionStatusHTML = '';
        // 미션 상태에 따라 다른 HTML을 생성
        if (listId === 'mission-list') {
            missionStatusHTML = `
                <td><button class="delete-mission" data-mis-num="${mission.mis_num}" data-mis-point="${mission.mis_point}">취소</button></td>
            `;
        } else if (listId === 'mission-list2') {
            missionStatusHTML = `
                <td><button class="accept-mission" data-mis-num="${mission.mis_num}" data-mis-point="${mission.mis_point}">수락</button></td>
                <td><button class="delete-mission" data-mis-num="${mission.mis_num}" data-mis-point="${mission.mis_point}">취소</button></td>
            `;
        }

        const newRow = `
            <tr id="mission-${mission.mis_num}">
                <td class="align-center">${mission.mis_content}</td>
                <td class="align-center">${mission.mis_point}</td>
                <td class="align-center">${mission.mem_nickName}</td>
                <td class="align-center">${mission.mis_date}</td>
                ${missionStatusHTML}
            </tr>
        `;
        const listElement = document.querySelector(`#${listId} tbody`);
        if (listElement) {
            listElement.insertAdjacentHTML('beforeend', newRow);
        } else {
            console.error(`Element with id ${listId} not found.`);
        }
    }

    // 이벤트 위임을 사용하여 동적 요소에 이벤트 핸들러 추가
    $(document).on('click', '.accept-mission', function() {
        const mis_num = $(this).data('mis-num');
        const mis_point = $(this).data('mis-point');
        updateMissionStatus(mis_num, 2, mis_point);
    });

    $(document).on('click', '.delete-mission', function() {
        const mis_num = $(this).data('mis-num');
        const mis_point = $(this).data('mis-point');
        console.log('Deleting mission:', mis_num, mis_point); // Debugging line
        deleteMission(mis_num, mis_point);
    });

    $(document).on('click', '.success-mission', function() {
        const mis_num = $(this).data('mis-num');
        const mis_point = $(this).data('mis-point');
        updateMissionStatus(mis_num, 3, mis_point);
    });

    $(document).on('click', '.fail-mission', function() {
        const mis_num = $(this).data('mis-num');
        const mis_point = $(this).data('mis-point');
        updateMissionStatus(mis_num, 4, mis_point);
    });

    // 미션 상태 업데이트 함수
    function updateMissionStatus(mis_num, mis_status, mis_point) {
        const updateData = {
            mis_num: mis_num,
            mis_status: mis_status,
            mis_point: mis_point,
            str_num: strNum
        };

        $.ajax({
            url: '/mission/updateStatus',
            data: updateData,
            dataType: 'json',
            type: 'post',
            success: function(response) {
                if (response.result == 'success') {
                    alert('미션 상태가 업데이트되었습니다.');
                    location.reload(); // 페이지 새로고침
                } else {
                    alert('미션 상태 업데이트 실패');
                }
            },
            error: function() {
                alert('에러 발생');
            }
        });
    }

    // 미션 삭제 함수
    function deleteMission(mis_num, mis_point) {
        const deleteData = {
            mis_num: mis_num,
            mis_point: mis_point,
            mem_num: 0 // mem_num을 필요에 따라 변경
        };

        console.log('Sending delete request:', deleteData); // Debugging line

        $.ajax({
            url: '/mission/delete',
            data: deleteData,
            dataType: 'json',
            type: 'post',
            success: function(response) {
                if (response.result == 'success') {
                    alert('미션이 삭제되었습니다.');
                    document.getElementById(`mission-${mis_num}`).remove();
                    // 소켓 전송 삭제 (실시간 업데이트 필요 없음)
                } else {
                    alert('미션 삭제 실패');
                }
            },
            error: function() {
                alert('에러 발생');
            }
        });
    }

    // 미션 폼 제출 처리 (유저용)
    if ($('#missionForm').length > 0) {
        $('#missionForm').submit(function(event) {
            event.preventDefault(); // 기본 폼 제출 방지
            
            const missionContent = $('#mission_content').val();
            const missionPoint = $('#mission_point').val();
            const str_num = strNum;
            const mem_nickName = $('#mem_nickName').val();

            if (!missionContent || !missionPoint) {
                alert('내용과 포인트를 입력해주세요!');
                return;
            }

            const missionData = {
                str_num: str_num,
                mis_content: missionContent,
                mis_point: missionPoint,
                mem_nickName: mem_nickName
            };

            $.ajax({
                url: '/mission/add',
                data: missionData,
                dataType: 'json',
                type: 'get',
                success: function(param){
                    if(param.result == 'logout'){
                        alert('로그인 필요');
                        window.close();
                    } else if(param.result == 'success'){
                        alert('미션을 전송했습니다.');
                        // 서버에서 반환된 mis_num을 사용하여 동적 요소 생성
                        missionData.mis_num = param.mis_num;
                        socket.send(JSON.stringify(missionData)); // 실시간 전송
                        appendMission(missionData, 'mission-list'); // 목록에 추가
                        appendMission(missionData, 'mission-list2'); // 목록에 추가
                        window.close();
                    } else if(param.result == 'rowpoint'){
                        alert('포인트가 부족합니다.');
                    } else {
                        alert('오류 발생');
                    }
                },
                error: function(){
                    alert('에러 발생');
                }
            });
        });
    }
});