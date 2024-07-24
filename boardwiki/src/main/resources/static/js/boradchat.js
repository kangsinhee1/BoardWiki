$(document).ready(function() {
    const chatInput = $('#chat-input');
    const chatSendButton = $('#chat-send-button');
    const chatContainer = $('#chat-container');
    const urlParams = new URLSearchParams(window.location.search);
    const strNum = urlParams.get('str_num');

    const socket = new WebSocket(`ws://localhost:8000/message-ws`);

    // Function to append chat messages to the chat container
    function appendChatMessage(mem_nickName, message) {
        const messageElement = $('<div></div>').text(`${mem_nickName}: ${message}`);
        chatContainer.append(messageElement);
    }
	
	// Load initial chat messages
    function loadChatMessages() {
        $.ajax({
            url: `/streaming/messages`,
            type: 'GET',
            data: { str_num: strNum },
            success: function(data) {
                chatContainer.empty();
                data.forEach(message => {
                    appendChatMessage(message.mem_nickName, message.strt_chat);
                });
            },
            error: function() {
                console.error('Failed to load messages:', error);
            }
        });
    }
    

    // WebSocket event listeners
    socket.onopen = function() {
        console.log('WebSocket connection established');
        loadChatMessages(); 
    };

    socket.onmessage = function(event) {
        const data = JSON.parse(event.data);
        appendChatMessage(data.mem_num, data.strt_chat);
    };

    socket.onclose = function() {
        console.log('WebSocket connection closed');
    };

    socket.onerror = function(error) {
        console.error('WebSocket error:', error);
    };

    // Function to send a new chat message via AJAX and WebSocket
    function sendChatMessage() {
        const message = chatInput.val();
        if (message.trim() !== "") {
            const messageData = { str_num: strNum, strt_chat: message };

            $.ajax({
                url: '/streaming/send',
                type: 'POST',
                dataType: 'json',
                data: messageData,
                success:function(param) {
					if(param.result=='seusse'){
						const nickname = param.mem_nickName;
						alert(nickname);
                    	socket.send(JSON.stringify({mem_nickName: nickname, strt_chat: message}));
                    }
                    chatInput.val('');
                },
                error: function() {
                    alert('Failed to send message');
                }
            });
        } else {
            alert('Message cannot be empty');
        }
    }

    chatSendButton.on('click', sendChatMessage);
    chatInput.on('keypress', function(event) {
        if (event.key === 'Enter') {
            sendChatMessage();
        }
    });
});