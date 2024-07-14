package kr.spring.mypage.controller;



import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MyPageController {
	@Autowired
	private MemberService memberService;
	
	
	
	
	
	/*==============================
	 * MY페이지
	 *==============================*/	
	@GetMapping("/myPage/myPage")
	public String process(HttpSession session,Model model) {
		MemberVO user = 
				(MemberVO)session.getAttribute("user");
		//회원정보
		MemberVO member = 
				memberService.selectMember(user.getMem_num());
		log.debug("<<MY페이지>> : " + member);

		model.addAttribute("member", member);

		return "myPage";
	}
	/*==============================
	 * MY페이지 (내 알람)
	 *==============================*/	
	@GetMapping("/myPage/myAlert")
	public String myAlertPage(HttpSession session,Model model) {
		MemberVO user = 
				(MemberVO)session.getAttribute("user");
		//회원정보
		MemberVO member = 
				memberService.selectMember(user.getMem_num());
		log.debug("<<MY페이지>> : " + member);
		
		model.addAttribute("member", member);
		
		return "myAlert";
	}
	/*==============================
	 * MY페이지 (내 채팅방)
	 *==============================*/	
	@GetMapping("/myPage/myChat")
	public String myChatPage(HttpSession session,Model model) {
		MemberVO user = 
				(MemberVO)session.getAttribute("user");
		//회원정보
		MemberVO member = 
				memberService.selectMember(user.getMem_num());
		log.debug("<<MY페이지>> : " + member);
		
		model.addAttribute("member", member);
		
		return "myChat";
	}
	/*==============================
	 * MY페이지 (내 주문)
	 *==============================*/	
	@GetMapping("/myPage/myOrder")
	public String myOrderPage(HttpSession session,Model model) {
		MemberVO user = 
				(MemberVO)session.getAttribute("user");
		//회원정보
		MemberVO member = 
				memberService.selectMember(user.getMem_num());
		log.debug("<<MY페이지>> : " + member);
		
		model.addAttribute("member", member);
		
		return "myOrder";
	}
	/*==============================
	 * MY페이지 (내 전적)
	 *==============================*/	
	@GetMapping("/myPage/myLog")
	public String myLogPage(HttpSession session,Model model) {
		MemberVO user = 
				(MemberVO)session.getAttribute("user");
		//회원정보
		MemberVO member = 
				memberService.selectMember(user.getMem_num());
		log.debug("<<MY페이지>> : " + member);
		
		model.addAttribute("member", member);
		
		return "myLog";
	}
	/*==============================
	 * MY페이지 (내가 쓴글 )
	 *==============================*/	
	@GetMapping("/myPage/myWrite")
	public String myWritePage(HttpSession session,Model model) {
		MemberVO user = 
				(MemberVO)session.getAttribute("user");
		//회원정보
		MemberVO member = 
				memberService.selectMember(user.getMem_num());
		log.debug("<<MY페이지>> : " + member);
		
		model.addAttribute("member", member);
		
		return "myWrite";
	}
	/*==============================
	 * MY페이지 (내 주문)
	 *==============================*/	
	@GetMapping("/myPage/myPoint")
	public String myPointPage(HttpSession session,Model model) {
		MemberVO user = 
				(MemberVO)session.getAttribute("user");
		//회원정보
		MemberVO member = 
				memberService.selectMember(user.getMem_num());
		log.debug("<<MY페이지>> : " + member);
		
		model.addAttribute("member", member);
		
		return "myPoint";
	}
	/*==============================
	 * MY페이지 (내 주문)
	 *==============================*/	
	@GetMapping("/myPage/myQna")
	public String myQnaPage(HttpSession session,Model model) {
		MemberVO user = 
				(MemberVO)session.getAttribute("user");
		//회원정보
		MemberVO member = 
				memberService.selectMember(user.getMem_num());
		log.debug("<<MY페이지>> : " + member);
		
		model.addAttribute("member", member);
		
		return "myQna";
	}
}
