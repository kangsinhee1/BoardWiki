package kr.spring.admin.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import kr.spring.member.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class AdminController {
	
	@GetMapping("/admin/adminPage")
	public String adminPage(HttpSession session,
							HttpServletRequest request,
							Model model) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user.getMem_auth()!= 9) {
			model.addAttribute("message","관리자 등급만 접속할 수 있습니다.");
			model.addAttribute("url",request.getContextPath()+"/main/main");
			return "common/resultAlert";
		}
		
		return "adminPage";
	}
}
