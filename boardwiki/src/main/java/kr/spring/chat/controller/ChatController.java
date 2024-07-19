package kr.spring.chat.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.chat.service.ChatService;
import kr.spring.chat.vo.ChatMemberVO;
import kr.spring.chat.vo.ChatRoomVO;
import kr.spring.chat.vo.ChatTextVO;
import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import kr.spring.team.service.TeamService;
import kr.spring.team.vo.TeamVO;
import kr.spring.util.PagingUtil;
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

		/*=============================
		 * 
		 * 채팅방 목록
		 * =============================*/	
		
		
		/*=============================
		 * 
		 * 채팅방 생성
		 * =============================*/
		
		
		
		/*=============================
		 * 
		 * 채팅 메시지 처리
		 * =============================*/
	
	
		@GetMapping("/chat/chatDetail")
		public  String getChatDetail(long chaR_num, Model model,HttpSession session) {
			MemberVO user = (MemberVO)session.getAttribute("user");
			String room_name="";
			String chatMember="";
			
			ChatRoomVO roomvo = chatService.selectChatRoomBychaRnum(chaR_num);
			TeamVO team = teamService.detailTeam(roomvo.getTea_num());
			List<ChatMemberVO> list = chatService.selectChatMember(chaR_num);
			log.debug("채팅방 멤버 : ~~~"+list);
			for(int i=0;i<list.size();i++) {
				ChatMemberVO vo = list.get(i);
				if(user.getMem_num() == vo.getMem_num()) {
					room_name=vo.getBasic_name();
				}
				if(i>0)chatMember+=",";
				chatMember+= list.get(i).getMem_nickname();
				
			}
			//채팅 멤버 id
 			model.addAttribute("chatMember",chatMember);
 			//채팅 멤버수
 			model.addAttribute("chatCount",list.size());
 			//로그인한 회원의 채티방 이름
 			model.addAttribute("room_name",room_name);
 			model.addAttribute("team",team);
 			return "chatDetail"; 
		}
		
		
		@PostMapping("/chat/writeChat")
		@ResponseBody
		public Map<String,String> writeChat(ChatTextVO chatTextVO, HttpSession session){
			Map<String,String> mapJson = new HashMap<String,String>();
			MemberVO user = (MemberVO)session.getAttribute("user");
			if(user==null) {
				mapJson.put("result", "logout");
			}else {
				MemberVO member = memberService.selectMember(user.getMem_num());
				chatTextVO.setMem_num(user.getMem_num());
				chatTextVO.setMem_nickname(member.getMem_nickName());
				chatService.insertChat(chatTextVO);
				log.debug("채팅 메시지 전송"+chatTextVO);
				mapJson.put("result", "success");
			}
			return mapJson;
		}
		
 		
		
		@GetMapping("/chat/chatDetailAjax")
		@ResponseBody
		public Map<String,Object> chatDetailAjax(Long chaR_num,HttpSession session){
			Map<String,Object> mapJson = new HashMap<String,Object>();
			MemberVO user = (MemberVO)session.getAttribute("user");
			if(user==null) {
				mapJson.put("result", "logout");
			}else {
				Map<String,Long> map = new HashMap<String,Long>();
				map.put("chaR_num",chaR_num);
				map.put("mem_num", user.getMem_num());
				
				List<ChatTextVO>list = chatService.selectChatTextDetail(map);
				mapJson.put("result", "success");
				mapJson.put("list", list);
				mapJson.put("user_num", user.getMem_num());
				log.debug("채팅 가온나  : " + list);
			}
			return mapJson;
			
			
		}
		
		
		@GetMapping("/chat/chatList")
		public String getChatList(HttpSession session, Model model, String keyword, @RequestParam(defaultValue="1" )int pageNum) {
			MemberVO user = (MemberVO)session.getAttribute("user");
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("keyword",keyword);
			map.put("mem_num", user.getMem_num());
			int count = chatService.selectRowCount(map);
			
			//페이지 처리
			PagingUtil page = new PagingUtil(null,keyword,pageNum,count,20,10,"chatList");
			List<ChatRoomVO> list= null;
			if(count>0) {
				map.put("start", page.getStartRow());
				map.put("end", page.getEndRow());
				list = chatService.selectChatRoomList(map);
				model.addAttribute("count",count);
				model.addAttribute("list",list);
				model.addAttribute("page",page.getPage());
				log.debug("목록 가져와 ! " + list);
			}
			
			
			return "chatList";
		}
		
}
