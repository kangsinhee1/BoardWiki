$(document).ready(function() {
            const chatInput = $('#chat-input');
            const chatSendButton = $('#chat-send-button');
            const chatContainer = $('#chat-container');
            const urlParams = new URLSearchParams(window.location.search);
            const strNum = urlParams.get('str_num');

            // Function to fetch and display chat messages
            function loadChatMessages() {
                $.ajax({
                    url: `/streaming/messages`,
                    type: 'GET',
                    data: { strc_num: strcNum, str_num: strNum },
                    success: function(data) {
                        chatContainer.empty(); // Clear existing messages
                        data.forEach(message => {
                            const messageElement = $('<div></div>').text(`${message.mem_num}: ${message.strt_chat}`);
                            chatContainer.append(messageElement);
                        });
                    }
                });
            }

            // Function to send a new chat message
            function sendChatMessage() {
                const message = chatInput.val();
                if (message.trim() !== "") {
                    $.ajax({
                        url: '/streaming/send',
                        type: 'POST',
                        contentType: 'application/json',
                        data: JSON.stringify({ strc_num: strcNum, strt_chat: message, str_num: strNum }),
                        success: function() {
                            chatInput.val(''); // Clear the input
                            loadChatMessages(); // Reload chat messages
                        },
                        error: function() {
                            alert('Failed to send message');
                        }
                    });
                }
            }

            chatSendButton.on('click', sendChatMessage);
            chatInput.on('keypress', function(event) {
                if (event.key === 'Enter') {
                    sendChatMessage();
                }
            });

            // Initial load of chat messages
            loadChatMessages();
        });