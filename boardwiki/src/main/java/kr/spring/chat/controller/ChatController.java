package kr.spring.chat.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import kr.spring.chat.service.ChatService;
import kr.spring.member.service.MemberService;
import kr.spring.team.service.TeamService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ChatController {
	@Autowired
	private ChatService chatService;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private TeamService teamService;
	
}
