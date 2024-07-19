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

import kr.spring.member.email.Email;
import kr.spring.member.email.EmailSender;
import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import kr.spring.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MemberAjaxController {
	@Autowired
	private MemberService memberService;
	@Autowired
	private Email email;
	@Autowired
	private EmailSender emailSender;

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
	//패스워드 재설정 인증
	@PostMapping("/member/getSendResetCode")
	@ResponseBody
	public Map<String, String> sendResetCode (@RequestParam String mem_email, MemberVO memberVO, HttpSession session) {
		Map<String, String> mapJson = new HashMap<>();
		int ResetCode = (int)(Math.random() * (90000)) + 100000;

		session.setAttribute("ResetCode", ResetCode);
		session.setAttribute("mem_email", mem_email);

		//입력받은 이메일로 회원번호 조회
		MemberVO member = memberService.selectCheckMember(mem_email);

		// 회원 정보가 유효한지 확인하고 이메일 발송
		if (member != null && member.getMem_auth() > 1){
			String mem_provider = member.getMem_provider();

			if (mem_provider == null || mem_provider.isEmpty()) {
				email.setContent(mem_email + "님의 인증번호는 " + ResetCode + " 입니다");
				email.setReceiver(mem_email);
				email.setSubject("비밀번호 재설정 인증번호");

				try {
					emailSender.sendEmail(email);
					mapJson.put("result", "success");
				} catch (Exception e) {
					log.error("이메일 전송 오류: " + e.getMessage());
					mapJson.put("result", "failure");
				}
			} else {
				mapJson.put("result", "notMatchProvider");
			}
		} else if (member != null && member.getMem_auth() == 1) {
			mapJson.put("result", "noAuthority");
		} else {
			mapJson.put("result", "invalidInfo");
		}
		return mapJson;
	}
	@PostMapping("/member/checkSendResetCode")
	@ResponseBody
	public Map<String, String> checkSendResetCode(@RequestParam Integer ResetCode, HttpSession session) {
		Map<String, String> mapJson = new HashMap<>();

		Integer checkResetCode = (Integer) session.getAttribute("ResetCode");
		String mem_email = (String) session.getAttribute("mem_email");

		if (checkResetCode != null && checkResetCode.equals(ResetCode)) {
			// 인증번호 일치
			mapJson.put("result", "success");
			session.removeAttribute("ResetCode"); // 인증번호 세션 삭제
			session.setAttribute("resetPasswordEmail", mem_email); // 비밀번호 재설정할 이메일 세션에 저장
		} else {
			// 인증번호 불일치
			mapJson.put("result", "failure");
		}
		return mapJson;
	}
}








