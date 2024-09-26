import { backend } from 'declarations/backend';

const chatMessages = document.getElementById('chat-messages');
const userInput = document.getElementById('user-input');
const sendButton = document.getElementById('send-button');

async function loadMessages() {
    const messages = await backend.getMessages();
    chatMessages.innerHTML = messages.join('<br>');
    chatMessages.scrollTop = chatMessages.scrollHeight;
}

async function sendMessage() {
    const message = userInput.value.trim();
    if (message) {
        await backend.addMessage('User', message);
        userInput.value = '';
        await loadMessages();

        const response = await backend.generateResponse(message);
        await backend.addMessage('Claude', response);
        await loadMessages();
    }
}

sendButton.addEventListener('click', sendMessage);
userInput.addEventListener('keypress', (event) => {
    if (event.key === 'Enter') {
        sendMessage();
    }
});

// Initial load of messages
loadMessages();
