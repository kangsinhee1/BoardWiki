package kr.spring.member.controller;

import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import kr.spring.util.AuthCheckException;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MemberController {
	//네이버 로그인 설정 시작//
	@Value("${spring.oauth2.client.registration.naver.client-id}")
	private String naverClientId;

	@Value("${spring.oauth2.client.registration.naver.client-secret}")
	private String naverClientSecret;
	//네이버 로그인 설정 끝//

	@Autowired
	private MemberService memberService;
	
	//자바빈(VO) 초기화
		@ModelAttribute
		public MemberVO initCommand() {
			return new MemberVO();
		}
		
	/*==============================
	 * 회원로그인
	 *==============================*/
	//로그인 폼 호출
	@GetMapping("/member/login")
	public String formLogin() {
		return "memberLogin";
	}
	//로그인 폼에서 전송된 데이터 처리
	@PostMapping("/member/login")
	public String submitLogin(@Valid MemberVO memberVO,BindingResult result,HttpSession session, HttpServletResponse response){
		log.debug("<<회원로그인>> : " + memberVO);

		//유효성 체크 결과 오류가 있으면 폼 호출
		//id와 passwd 필드만 체크
		if(result.hasFieldErrors("mem_email") ||
				result.hasFieldErrors("mem_passwd")){
			return formLogin();
		}

		//로그인 체크(id,비밀번호 일치 여부 체크)
		MemberVO member = null;
		try {
			member = memberService.selectCheckMember(
					memberVO.getMem_email());
			boolean check = false;
			if(member!=null) {
				//비밀번호 일치 여부 체크
				check = member.ischeckedPassword(memberVO.getMem_passwd());
			}
			if(check) {//인증 성공
				//==== 자동로그인 체크 시작====//
				//==== 자동로그인 체크 끝====//

				//인증 성공, 로그인 처리
				session.setAttribute("user", member);


				log.debug("<<인증성공>>");
				log.debug("<<id>> : " + member.getMem_email());
				log.debug("<<auth>> : " + member.getMem_auth());

				if(member.getMem_auth() == 9) {//관리자
					return "redirect:/main/admin";
				}else
					return "redirect:/main/main";
			}

			//인증 실패
			throw new AuthCheckException();	
		}catch(AuthCheckException e) {
			//인증 실패로 로그인 폼 호출
			if(member!=null && member.getMem_auth()==1) {//정지회원 메시지 표시
				result.reject("noAuthority");
			}else {
				result.reject("invalidIdOrPassword");
			}
			log.debug("<<인증 실패>>");

			return formLogin();
		}
	}
	
	
	
	/*==============================
	 * 로그아웃
	 *==============================*/	
	@GetMapping("/member/logout")
	public String processLogout(HttpSession session) {
		//로그아웃
		session.invalidate();
		
		//====자동로그인 시작====//
		//====자동로그인 끝====//
		
		return "redirect:/main/main";
	}
	/*==============================
	 * MY페이지
	 *==============================*/
	@GetMapping("/member/myPage")
	public String process(HttpSession session,Model model) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		//회원정보
		MemberVO member = memberService.selectMember(user.getMem_num());
		log.debug("<<MY페이지>> : " + member);
		
		model.addAttribute("member",member);
				
		return "myPage";
	}
	/*==============================
	 * 			네이버 로그인
	 *==============================*/
	@GetMapping("/login/oauth2/code/naver")
	public String naverLogin(@RequestParam String code, @RequestParam String state, HttpSession session) {

		RestTemplate restTemplate = new RestTemplate();

		// 액세스 토큰 요청
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

		MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
		body.add("grant_type", "authorization_code");
		body.add("client_id", naverClientId);
		body.add("client_secret", naverClientSecret);
		body.add("code", code);
		body.add("state", state);

		log.debug("Received code: " + code);
		log.debug("Received state: " + state);

		HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(body, headers);
		ResponseEntity<Map> response = restTemplate.postForEntity("https://nid.naver.com/oauth2.0/token", request, Map.class);

		Map<String, Object> responseBody = response.getBody();
		String accessToken = (String) responseBody.get("access_token");

		// 사용자 정보 요청
		HttpHeaders userInfoHeaders = new HttpHeaders();
		userInfoHeaders.setBearerAuth(accessToken);
		HttpEntity<String> userInfoRequest = new HttpEntity<>(userInfoHeaders);

		ResponseEntity<Map> userInfoResponse = restTemplate.exchange("https://openapi.naver.com/v1/nid/me", HttpMethod.GET, userInfoRequest, Map.class);
		Map<String, Object> userInfo = (Map<String, Object>) userInfoResponse.getBody().get("response");

		// 사용자 정보를 세션에 저장
		session.setAttribute("user", userInfo);

		// DB에 사용자 정보 저장
		registerOrLoginUser(userInfo, session);

		return "redirect:/main/main";
	}

	private void registerOrLoginUser(Map<String, Object> userInfo, HttpSession session) {
		String email = (String) userInfo.get("email");
		String name = (String) userInfo.get("name");

		// MemberVO 객체 생성 및 정보 설정
		MemberVO memberVO = new MemberVO();
		memberVO.setMem_email(email);
		memberVO.setMem_name(name);
		memberVO.setMem_provider("naver");

		// 이미 가입된 회원인지 확인
		MemberVO Member = memberService.selectCheckMember(email);
		if (Member == null) {
			// 신규 회원 가입 처리
			memberService.insertMember(memberVO);

			// 회원가입 완료 메시지 저장
			session.setAttribute("message", "회원 가입이 완료되었습니다.");
		} else {
			// 기존 회원 로그인 처리
			session.setAttribute("message", "로그인 성공");
		}

		// 사용자 정보를 세션에 저장
		session.setAttribute("loggedInUser", memberVO);
	}
}
