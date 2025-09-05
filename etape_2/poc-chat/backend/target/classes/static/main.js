'use strict';

const messageForm = document.querySelector('#message-form');
const messageInput = document.querySelector('#message-input');
const senderInput = document.querySelector('#sender');
const chatMessages = document.querySelector('#chat-messages');

let stompClient = null;

function connect() {
    const socket = new SockJS('/ws');
    stompClient = Stomp.over(socket);

    stompClient.connect({}, onConnected, onError);
}

function onConnected() {
    // Subscribe to the Public Topic
    stompClient.subscribe('/topic/public', onMessageReceived);
}

function onError(error) {
    console.error('Could not connect to WebSocket server. Please refresh and try again!');
}

function sendMessage(event) {
    event.preventDefault();

    const messageContent = messageInput.value.trim();
    const sender = senderInput.value.trim();

    if (messageContent && stompClient) {
        const chatMessage = {
            sender: sender,
            content: messageInput.value,
        };
        stompClient.send('/app/chat.sendMessage', {}, JSON.stringify(chatMessage));
        messageInput.value = '';
    }
}

function onMessageReceived(payload) {
    const message = JSON.parse(payload.body);

    const messageElement = document.createElement('div');
    messageElement.classList.add('message');

    const senderElement = document.createElement('p');
    senderElement.classList.add('sender');
    senderElement.textContent = message.sender;

    const contentElement = document.createElement('p');
    contentElement.classList.add('content');
    contentElement.textContent = message.content;

    messageElement.appendChild(senderElement);
    messageElement.appendChild(contentElement);

    chatMessages.appendChild(messageElement);
    chatMessages.scrollTop = chatMessages.scrollHeight;
}

// Connect to WebSocket on page load
connect();

messageForm.addEventListener('submit', sendMessage, true);
