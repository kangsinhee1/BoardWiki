package kr.spring.member.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Pattern;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MemberAjaxController {
	@Autowired
	private MemberService memberService;
	
	//아이디 중복 체크
	@GetMapping("/member/confirmId")
	@ResponseBody
	public Map<String,String> process(@RequestParam String mem_email){
		
		log.debug("<<이메일 중복 체크>> : " + mem_email);
		
		Map<String,String> mapAjax = new HashMap<String,String>();
		
		MemberVO member = memberService.selectCheckMember(mem_email);
		if(member!=null) {
			//아이디 중복
			mapAjax.put("result", "idDuplicated");
		}else {
			if(!Pattern.matches("^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,6}$", mem_email)) {
				//패턴 불일치
				mapAjax.put("result", "notMatchPattern");
			}else {
				//패턴이 일치하면서 아이디 미중복
				mapAjax.put("result", "idNotFound");
			}
		}		
		return mapAjax;
	}
	//닉네임 중복 체크
		@GetMapping("/member/confirmNickname")
		@ResponseBody
		public Map<String,String> nicknameprocess(@RequestParam String mem_nickName){
			
			log.debug("<<닉네임 중복 체크>> : " + mem_nickName);
			
			Map<String,String> mapAjax = new HashMap<String,String>();
			
			MemberVO member = memberService.selectCheckMemberNickName(mem_nickName);
			if(member!=null) {
				//닉네임 중복
				mapAjax.put("result", "idDuplicated");
			}else {
				mapAjax.put("result", "idNotFound");
			}		
			return mapAjax;
		}
}








