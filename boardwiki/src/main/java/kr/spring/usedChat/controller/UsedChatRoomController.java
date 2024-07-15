package kr.spring.usedChat.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import kr.spring.usedChat.service.UsedChatRoomService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class UsedChatRoomController {
	
	@Autowired
	private UsedChatRoomService usedChatRoomService;
}
