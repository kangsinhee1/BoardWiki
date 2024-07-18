package kr.spring.usedChat.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.board.vo.BoardVO;
import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import kr.spring.used.service.UsedService;
import kr.spring.used.vo.UsedItemVO;
import kr.spring.usedChat.service.UsedChatService;
import kr.spring.usedChat.vo.UsedChatRoomVO;
import kr.spring.usedChat.vo.UsedChat_textVO;
import kr.spring.util.PagingUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class UsedChatController {
	
	@Autowired
	private UsedChatService usedChatService;
	
	@Autowired
	private UsedService usedService;
	
	@Autowired
	private MemberService memberService;
	
	@GetMapping("/used/useChatSeller")
	public String accessUseChatSeller(Long use_num, String useC_name, UsedChatRoomVO usedChatRoomVO, HttpSession session, Model model, HttpServletRequest request) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		log.debug("<<<<<<<<<<use_num : "+use_num);
		log.debug("<<<<<<<<<<useC_name : "+useC_name);
		
		UsedChatRoomVO alreayUChat = usedChatService.selectUsedChatRoomSeller(useC_name,use_num);
		log.debug("<<<<<<<<<<<<<vovovoovov"+alreayUChat);
		Long useC_num = alreayUChat.getUseC_num();
		
		model.addAttribute("useC_name",useC_name);
		model.addAttribute("useC_num",useC_num);
		model.addAttribute("use_num",use_num);
		
		return "useChatSeller";
	}
	
	
	@GetMapping("/used/useChat")
	public String accessUseChat(Long use_num, UsedChatRoomVO usedChatRoomVO, HttpSession session, Model model, HttpServletRequest request,
			@RequestParam(defaultValue="1") int pageNum,
			@RequestParam(defaultValue="1") int order,
			String keyfield,String keyword	) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user==null) {
			model.addAttribute("message", "로그인후 작성 가능합니다.");
			model.addAttribute("url", 
			request.getContextPath()+"/member/login");
			return "common/resultAlert";
		}
		UsedItemVO usedMember = usedService.selectUsed(use_num);
		//작성자일 경우
		if(user.getMem_num()== usedMember.getMem_num()) {
			
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("keyfield", keyfield);
			map.put("keyword", keyword);
			map.put("use_num", use_num);
			int count = usedChatService.selectRowCount(map);
			
			PagingUtil page = new PagingUtil(keyfield,keyword,pageNum,count,
								10,10,"useChatList");
			List<UsedChatRoomVO> list = null;
			if(count > 0) {
				map.put("order", order);
				map.put("start", page.getStartRow());
				map.put("end", page.getEndRow());
				
				list = usedChatService.selectUsedChatRoomList(map);
			}
			
			log.debug("<<<<<<<<<<<<<list"+list);
			model.addAttribute("count", count);
			model.addAttribute("list", list);
			model.addAttribute("page", page.getPage());
			
			return "useChatList";
		}else {
			if(usedChatService.selectUsedChatRoom(user.getMem_num(),use_num)!=null) {
				UsedChatRoomVO alreayUChat = usedChatService.selectUsedChatRoom(user.getMem_num(),use_num);
				log.debug("<<<<<<<<<<<<<vovovoovov"+alreayUChat);
				String useC_name = alreayUChat.getUseC_name();
				Long useC_num = alreayUChat.getUseC_num();
				
				model.addAttribute("useC_name",useC_name);
				model.addAttribute("useC_num",useC_num);
				model.addAttribute("use_num",use_num);
				
				return "useChat";
			}else {
				log.debug("<<<<<<<<<<<<<<<<use_num" + use_num);
				log.debug("<<<<<<<<<<<<<<<<user" + user.getMem_num());
				
				MemberVO s = memberService.selectMember(usedMember.getMem_num());
				MemberVO b = memberService.selectMember(user.getMem_num());
				log.debug("<<<<<<<<<<<<<<<<s" + s);
				log.debug("<<<<<<<<<<<<<<<<b" + b);
				
				usedChatRoomVO.setUseC_name(s.getMem_nickName()+","+b.getMem_nickName());
				usedChatRoomVO.setUse_num(use_num);
				usedChatRoomVO.setMem_num(user.getMem_num());
				
				usedChatService.insertUsedChatRoom(usedChatRoomVO);
				
				UsedChatRoomVO newUChat = usedChatService.selectUsedChatRoom(user.getMem_num(),use_num);
				log.debug("<<<<<<<<<<<<<vovovoovov"+newUChat);
				String useC_name = newUChat.getUseC_name();
				Long useC_num = newUChat.getUseC_num();
				
				model.addAttribute("useC_name",useC_name);
				model.addAttribute("useC_num",useC_num);
				model.addAttribute("use_num",use_num);
				
				return "useChat";
			}
		}
	}
	//채팅 메세지 전송
	@PostMapping("/used/usedChatWrite")
	@ResponseBody
	public Map<String,String> writeChatAjax(UsedChat_textVO vo, HttpSession session){
		log.debug("<<채팅 메시지 전송>> : " + vo);
		
		Map<String,String> mapAjax = new HashMap<String,String>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user==null) {
			//로그인이 되지 않은 경우
			mapAjax.put("result", "logout");
		}else {
			//로그인 된 경우
			vo.setMem_num(user.getMem_num());
			//메시지 등록
			usedChatService.insertChat(vo);
			mapAjax.put("result", "success");
		}
		
		return mapAjax;
	}
	//채팅 메시지 읽기
	@GetMapping("/used/usedChatDetailAjax")
	@ResponseBody
	public Map<String,Object> chatDetailAjax(
			                   long useC_num,
			                   HttpSession session){
		Map<String,Object> mapJson = 
				         new HashMap<String,Object>();
		MemberVO user = 
				(MemberVO)session.getAttribute("user");
		if(user==null) {
			mapJson.put("result", "logout");
		}else{
			Map<String,Long> map = new HashMap<String,Long>();
			map.put("useC_num",useC_num);
			map.put("mem_num",user.getMem_num());
			List<UsedChat_textVO> list = usedChatService.selectChatDetail(map);
			log.debug("<<채팅 메시지 목록>> : " + list);
			mapJson.put("result", "success");
			mapJson.put("list", list);
			mapJson.put("user_num", user.getMem_num());
		}		
		return mapJson;
	}
	
}


















