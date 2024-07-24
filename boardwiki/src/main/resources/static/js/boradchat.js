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
    
    // 미션 관련 추가 코드

    // 미션을 미션 목록에 추가하는 함수
    function appendMission(mission) {
        let missionStatusHTML = '';
        // 미션 상태에 따라 다른 HTML을 생성
        if (mission.mis_status == 1) {
            if (userType === 'streamer') {
                missionStatusHTML = `
                    <button onclick="updateMissionStatus(${mission.mis_num}, 2, ${mission.mis_point})">수락</button>
                `;
            } else {
                missionStatusHTML = `
                    <button onclick="deleteMission(${mission.mis_num}, ${mission.mis_point})">취소</button>
                `;
            }
        } else if (mission.mis_status == 2) {
            if (userType === 'streamer') {
                missionStatusHTML = `
                    <button onclick="updateMissionStatus(${mission.mis_num}, 3, ${mission.mis_point})">성공</button>
                    <button onclick="updateMissionStatus(${mission.mis_num}, 4, ${mission.mis_point})">실패</button>
                `;
            } else {
                missionStatusHTML = '<p>수락됨</p>';
            }
        } else if (mission.mis_status == 3) {
            missionStatusHTML = '<p>성공</p>';
        } else if (mission.mis_status == 4) {
            missionStatusHTML = '<p>실패</p>';
        }

        const missionElement = `
            <div id="mission-${mission.mis_num}">
                <p>${mission.mis_content} / ${mission.mis_point} 포인트</p>
                ${missionStatusHTML}
            </div>
        `;
        $('#mission-list').append(missionElement);
    }

    // 미션 상태 업데이트 함수
    function updateMissionStatus(mis_num, mis_status, mis_point) {
        const updateData = {
            mis_num: mis_num,
            mis_status: mis_status,
            mis_point: mis_point
        };

        $.ajax({
            url: '/mission/updateStatus',
            data: updateData,
            dataType: 'json',
            type: 'post',
            success: function(response) {
                if (response.result == 'success') {
                    alert('미션 상태가 업데이트되었습니다.');
                    socket.send(JSON.stringify(updateData)); // 실시간 업데이트 전송
                    updateMissionElement(mis_num, mis_status); // 클라이언트에서 즉시 업데이트
                } else {
                    alert('미션 상태 업데이트 실패');
                }
            },
            error: function() {
                alert('에러 발생');
            }
        });
    }

    // 미션 상태에 따라 미션 요소 업데이트
    function updateMissionElement(mis_num, mis_status) {
        let statusHTML = '';
        if (mis_status == 2) {
            statusHTML = `
                <button onclick="updateMissionStatus(${mis_num}, 3, 0)">성공</button>
                <button onclick="updateMissionStatus(${mis_num}, 4, 0)">실패</button>
            `;
        } else if (mis_status == 3) {
            statusHTML = '<p>성공</p>';
        } else if (mis_status == 4) {
            statusHTML = '<p>실패</p>';
        }

        const missionElement = document.getElementById(`mission-${mis_num}`);
        if (missionElement) {
            missionElement.innerHTML = `
                <p>${missionElement.children[0].innerText.split('/')[0].trim()} / ${missionElement.children[0].innerText.split('/')[1].trim()}</p>
                ${statusHTML}
            `;
        }
    }

    // 미션 삭제 함수
    function deleteMission(mis_num, mis_point) {
        const deleteData = {
            mis_num: mis_num,
            mis_point: mis_point,
            mem_num: 0 // mem_num을 필요에 따라 변경
        };

        $.ajax({
            url: '/mission/delete',
            data: deleteData,
            dataType: 'json',
            type: 'post',
            success: function(response) {
                if (response.result == 'success') {
                    alert('미션이 삭제되었습니다.');
                    document.getElementById(`mission-${mis_num}`).remove();
                    socket.send(JSON.stringify(deleteData)); // 실시간 업데이트 전송
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
            const strNum = $('#str_num').val();
            const memNum = $('#mem_num').val();
            const mem_nickName = $('#mem_nickName').val();

            if (!missionContent || !missionPoint) {
                alert('내용과 포인트를 입력해주세요!');
                return;
            }

            const missionData = {
                str_num: strNum,
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
                        socket.send(JSON.stringify(missionData)); // 실시간 전송
                        appendMission(missionData); // 목록에 추가
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