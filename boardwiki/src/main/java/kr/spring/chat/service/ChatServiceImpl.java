package kr.spring.chat.service;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.spring.chat.dao.ChatMapper;

@Service
@Transactional
public class ChatServiceImpl implements ChatService{
	@Autowired 
	ChatMapper chatMapper;
}
