package com.yourcar.yourway.service;

import com.yourcar.yourway.model.ChatMessage;
import com.yourcar.yourway.repository.ChatMessageRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
public class ChatService {

    private final ChatMessageRepository repository;

    @Autowired
    public ChatService(ChatMessageRepository repository) {
        this.repository = repository;
    }

    public ChatMessage saveMessage(ChatMessage chatMessage) {
        chatMessage.setTimestamp(LocalDateTime.now());
        return repository.save(chatMessage);
    }
}
