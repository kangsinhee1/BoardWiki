package kr.spring.member.controller;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MemberController {
	
	
	@Autowired
	private MemberService memberService;

	@GetMapping("/member/login")
	public String formLogin() {
		return "member/memberLogin";
	}
	//로그인 폼에서 전송된 데이터 처리
	@PostMapping("/member/login")
	public String submitLogin(@Valid MemberVO memberVO,
			BindingResult result,
			HttpSession session,
			HttpServletResponse response){
		return "myPage";
	}
	/*==============================
	 * MY페이지
	 *==============================*/
	@GetMapping("/member/myPage")
	public String process(HttpSession session,Model model) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		//회원정보
		MemberVO member = memberService.selectMember(99999L);
		log.debug("<<MY페이지>> : " + member);
		
		model.addAttribute("member",member);
				
		return "myPage";
	}
}
