const socket = io('http://localhost:8000');
const messagesDiv = document.getElementById('messages');
const messageInput = document.getElementById('message-input');

socket.on('message', function(message) {
    const messageElement = document.createElement('div');
    messageElement.innerText = message;
    messagesDiv.appendChild(messageElement);
});

function sendMessage() {
    const message = messageInput.value;
    socket.emit('message', message);
    messageInput.value = '';
}