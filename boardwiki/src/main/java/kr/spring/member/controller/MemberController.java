package kr.spring.member.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.scribejava.core.model.OAuth2AccessToken;

import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import kr.spring.util.AuthCheckException;
import kr.spring.util.GoogleLoginUtil;
import kr.spring.util.KakaoLoginUtil;
import kr.spring.util.NaverLoginUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MemberController {
	@Autowired
	private MemberService memberService;

	@Autowired
	private NaverLoginUtil naverLoginUtil;

	@Autowired
	private KakaoLoginUtil kakaoLoginUtil;

	@Autowired
	private GoogleLoginUtil googleLoginUtil;



	// 자바빈(VO) 초기화
	@ModelAttribute
	public MemberVO initCommand() {
		return new MemberVO();
	}

	/*==============================
	 * 회원 로그인
	 *==============================*/
	// 네이버 로그인 폼 호출 및 리다이렉트
	@GetMapping("/member/login/naver")
	public String formNaverLogin(HttpSession session) {
		log.debug("<<네이버 로그인 페이지 요청>>");
		String naverAuthUrl = naverLoginUtil.getAuthorizationUrl(session);
		return "redirect:" + naverAuthUrl;
	}

	// 카카오 로그인 폼 호출 및 리다이렉트
	@GetMapping("/member/login/kakao")
	public String formKakaoLogin(HttpSession session) {
		log.debug("<<카카오 로그인 페이지 요청>>");
		String kakaoAuthUrl = kakaoLoginUtil.getAuthorizationUrl(session);
		return "redirect:" + kakaoAuthUrl;
	}

	// 구글 로그인 폼 호출 및 리다이렉트
	@GetMapping("/member/login/google")
	public String formGoogleLogin(HttpSession session) {
		log.debug("<<구글 로그인 페이지 요청>>");
		String googleAuthUrl = googleLoginUtil.getAuthorizationUrl(session);
		return "redirect:" + googleAuthUrl;
	}

	// 로그인 폼 호출
	@GetMapping("/member/login")
	public String formLogin() {
		log.debug("<<로그인페이지 요청>>");		
		return "memberLogin";
	}

	//로그인 폼에서 전송된 데이터 처리
	@PostMapping("/member/login")
	public String submitLogin(@Valid MemberVO memberVO,
			BindingResult result,
			HttpSession session,
			HttpServletResponse response,
			Model model) {
		log.debug("<<회원로그인>> : " + memberVO);

		//유효성 체크 결과 오류가 있으면 폼 호출
		//id와 passwd 필드만 체크
		if(result.hasFieldErrors("id") || 
				result.hasFieldErrors("passwd")) {
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
				check = member.ischeckedPassword(
						memberVO.getMem_passwd());
			}
			if(check) {//인증 성공
				//==== 자동로그인 체크 시작====//
				//==== 자동로그인 체크 끝=====//

				//인증 성공, 로그인 처리
				session.setAttribute("user", member);

				log.debug("<<인증 성공>>");
				log.debug("<<id>> : " + member.getMem_email());
				log.debug("<<auth>> : " + member.getMem_auth());
				log.debug("<<au_id>> : " + member.getMem_auth());	

				if(member.getMem_auth() == 9) {//관리자
					return "redirect:/main/admin";
				}else {
					return "redirect:/main/main";
				}
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
	//회원가입 선택 폼 호출
	@GetMapping("/member/memberRegisterChoice")
	public String choiceRegister() {
		log.debug("<<회원가입 플랫폼 선택 창 요청>>");

		return "memberRegisterChoice";
	}
	//일반 회원가입
	@GetMapping("/member/memberRegister")
	public String formRegister() {
		log.debug("<<일반 회원가입 페이지 요청 메서드>>");
		return "memberRegister";//Tiles 설정명
	}
	//전송된 데이터 처리
	@PostMapping("/member/memberRegister")
	public String submit(@Valid MemberVO memberVO, BindingResult result, Model model, HttpServletRequest request) {
		log.debug("<<회원가입>> : " + memberVO);

		//유효성 체크 결과 오류가 있으면 폼 호출
		if(result.hasErrors()) {
			return formMemberNaverRegister();
		}
		//회원 가입
		memberService.insertMember(memberVO);

		//UI 메시지 처리
		model.addAttribute("accessTitle", "회원 가입");
		model.addAttribute("accessMsg", "회원 가입이 완료되었습니다.");
		model.addAttribute("accessBtn", "홈으로");
		model.addAttribute("accessUrl", 
				request.getContextPath()+"/main/main");

		return "common/resultView";
	}


	//네이버 로그인 폼에서 받아온 데이터 처리
	//네이버 - 네이버 로그인 성공시 callback 호출 후 사용자 정보 요청
	@GetMapping("/member/login/oauth2/code/naver")
	public String callbackNaver(Model model,
			MemberVO memberVO,
			@RequestParam Map<String,Object> paramMap,
			@RequestParam String code,
			@RequestParam String state,
			HttpSession session, HttpServletRequest request) throws IOException {

		log.info("callbackNaver");

		log.debug("paramMap:" + paramMap);

		// 네이버 OAuth Access Token 획득
		OAuth2AccessToken oauthToken = naverLoginUtil.getAccessToken(session, code, state);

		// 네이버 API를 통해 사용자 프로필 정보 읽어오기
		String apiResult = naverLoginUtil.getUserProfile(oauthToken);
		log.debug("apiResult : " + apiResult);

		// JSON 형식의 응답을 파싱하여 필요한 정보 추출
		JSONObject responseJson = new JSONObject(apiResult);
		JSONObject jsonResponse = responseJson.getJSONObject("response");

		String naver_name = jsonResponse.getString("name");
		String naver_email = jsonResponse.getString("email");
		String naver_passwd = jsonResponse.getString("id");


		log.debug("<<name>> : " + naver_name);
		log.debug("<<email>> : " + naver_email);
		log.debug("<<pwd>> : " + naver_passwd);

		// 이메일 중복 체크
		MemberVO result = memberService.selectCheckMember(naver_email);

		if(result == null) { // 네이버 메일로 조회해서 일치하는 정보가 없는 경우 회원가입
			memberVO.setMem_name(naver_name);
			memberVO.setMem_email(naver_email);
			memberVO.setMem_passwd(naver_passwd);
			memberVO.setMem_provider("Naver");

			model.addAttribute("memberVO", memberVO);

			log.debug("<<model>> : " + model);
			log.debug("<<memberVO>> : " + memberVO);

			return formMemberNaverRegister(); // 회원가입 폼으로 리다이렉트
		}
		if(!result.getMem_provider().equals("Naver")) {
			//UI 메시지 처리
			model.addAttribute("accessTitle", "로그인 오류");
			model.addAttribute("accessMsg", "회원님의 이메일로 가입된 다른 계정이 있습니다.");
			model.addAttribute("accessBtn", "확인");
			model.addAttribute("accessUrl", 
					request.getContextPath()+"/member/login");

			return "common/resultView";
		}
		//
		MemberVO member = memberService.selectCheckMember(naver_email);
		session.setAttribute("user", member);

		log.debug("<<인증 성공>>");
		log.debug("<<id>> : " + member.getMem_email());
		log.debug("<<auth>> : " + member.getMem_auth());

		return "redirect:/main/main"; // 성공적으로 처리되면 메인 페이지로 리다이렉트
	}

	@GetMapping("/member/memberNaverRegister")
	public String formMemberNaverRegister() {
		log.debug("<<네이버 회원가입 페이지 요청 메서드>>");
		return "memberNaverRegister";//Tiles 설정명
	}
	//전송된 데이터 처리
	@PostMapping("/member/login/oauth2/code/memberNaverRegister")
	public String submitNaver(@Valid MemberVO memberVO, BindingResult result, Model model, HttpServletRequest request) {
		log.debug("<<회원가입>> : " + memberVO);



		/*
		 * //유효성 체크 결과 오류가 있으면 폼 호출 if(result.hasErrors()) { return
		 * formMemberNaverRegister(); }
		 */
		//회원 가입
		memberService.insertMember(memberVO);

		//UI 메시지 처리
		model.addAttribute("accessTitle", "회원 가입");
		model.addAttribute("accessMsg", "회원 가입이 완료되었습니다.");
		model.addAttribute("accessBtn", "홈으로");
		model.addAttribute("accessUrl", 
				request.getContextPath()+"/main/main");

		return "common/resultView";
	}
	//카카오 로그인 폼에서 받아온 데이터 처리
	//카카오 - 카카오 로그인 성공시 callback 호출 후 사용자 정보 요청
	@GetMapping("/member/login/oauth2/code/kakao")
	public String callbackKakao(Model model,
			MemberVO memberVO,
			@RequestParam Map<String,Object> paramMap,
			@RequestParam String code,
			@RequestParam String state,
			HttpSession session, HttpServletRequest request) throws IOException {

		log.info("callbackKakao");

		log.debug("paramMap:" + paramMap);

		// 카카오 OAuth Access Token 획득
		OAuth2AccessToken oauthToken = kakaoLoginUtil.getAccessToken(session, code, state);

		// 카카오 API를 통해 사용자 프로필 정보 읽어오기
		String apiResult = kakaoLoginUtil.getUserProfile(oauthToken);
		log.debug("apiResult : " + apiResult);

		// JSON 응답 파싱
		JSONObject jsonObject = new JSONObject(apiResult);

		// 필요한 정보 추출
		String kakao_email = jsonObject.optJSONObject("kakao_account").optString("email", null);
		String kakao_nickname = jsonObject.optJSONObject("kakao_account").optJSONObject("profile").optString("nickname", null);
		String kakao_passwd = jsonObject.optString("id", null);


		log.debug("<<kakao_email>> : " +  kakao_email);
		log.debug("<<kakao_nickname>> : " +  kakao_nickname);
		log.debug("<<pwd>> : " +  kakao_passwd);


		// 이메일 중복 체크
		MemberVO result = memberService.selectCheckMember(kakao_email);

		if(result == null) { // 네이버 메일로 조회해서 일치하는 정보가 없는 경우 회원가입

			memberVO.setMem_email(kakao_email);
			memberVO.setMem_passwd(kakao_passwd);
			memberVO.setMem_nickName(kakao_nickname);
			memberVO.setMem_provider("Kakao");

			model.addAttribute("memberVO", memberVO);

			log.debug("<<model>> : " + model);
			log.debug("<<memberVO>> : " + memberVO);

			return formMemberNaverRegister(); // 회원가입 폼으로 리다이렉트
		}

		if(!result.getMem_provider().equals("Kakao")) {
			//UI 메시지 처리
			model.addAttribute("accessTitle", "로그인 오류");
			model.addAttribute("accessMsg", "회원님의 이메일로 가입된 다른 계정이 있습니다.");
			model.addAttribute("accessBtn", "확인");
			model.addAttribute("accessUrl", 
					request.getContextPath()+"/member/login");

			return "common/resultView";
		}
		//
		MemberVO member = memberService.selectCheckMember(kakao_email);
		session.setAttribute("user", member);

		log.debug("<<인증 성공>>");
		log.debug("<<id>> : " + member.getMem_email());
		log.debug("<<auth>> : " + member.getMem_auth());

		return "redirect:/main/main"; // 성공적으로 처리되면 메인 페이지로 리다이렉트
	}
	// 구글 로그인 폼에서 받아온 데이터 처리
	// 구글 - 구글 로그인 성공시 callback 호출 후 사용자 정보 요청
	@GetMapping("/member/login/oauth2/code/google")
	public String callbackGoogle(Model model,
	        MemberVO memberVO,
	        @RequestParam Map<String,Object> paramMap,
	        @RequestParam String code,
	        @RequestParam String state,
	        HttpSession session, HttpServletRequest request) throws IOException {

	    log.info("callbackGoogle");

	    log.debug("paramMap:" + paramMap);

	    // 구글 OAuth Access Token 획득
	    OAuth2AccessToken oauthToken = googleLoginUtil.getAccessToken(session, code, state);

	    // 구글 API를 통해 사용자 프로필 정보 읽어오기
	    String apiResult = googleLoginUtil.getUserProfile(oauthToken);
	    log.debug("apiResult : " + apiResult);

	    // JSON 응답 파싱
	    JSONObject jsonObject = new JSONObject(apiResult);

	    // 필요한 정보 추출
	    String google_email = jsonObject.optString("email", null);
	    String google_name = jsonObject.optString("name", null);
	    String google_id = jsonObject.optString("id", null);

	    log.debug("<<google_email>> : " + google_email);
	    log.debug("<<google_name>> : " + google_name);
	    log.debug("<<google_id>> : " + google_id);

	    // 이메일 중복 체크
	    MemberVO result = memberService.selectCheckMember(google_email);

	    if (result == null) { // 구글 메일로 조회해서 일치하는 정보가 없는 경우 회원가입
	        memberVO.setMem_email(google_email);
	        memberVO.setMem_passwd(google_id); // Google ID를 비밀번호로 사용 (필요에 따라 해싱하여 저장)
	        memberVO.setMem_name(google_name);
	        memberVO.setMem_provider("Google");

	        model.addAttribute("memberVO", memberVO);

	        log.debug("<<model>> : " + model);
	        log.debug("<<memberVO>> : " + memberVO);

	        return formMemberNaverRegister(); // 회원가입 폼으로 리다이렉트
	    }
	    

	    if (!result.getMem_provider().equals("Google")) {
	        // UI 메시지 처리
	        model.addAttribute("accessTitle", "로그인 오류");
	        model.addAttribute("accessMsg", "회원님의 이메일로 가입된 다른 계정이 있습니다.");
	        model.addAttribute("accessBtn", "확인");
	        model.addAttribute("accessUrl", 
	                request.getContextPath() + "/member/login");

	        return "common/resultView";
	    }

	    // 기존 회원 로그인 처리
	    MemberVO member = memberService.selectCheckMember(google_email);
	    session.setAttribute("user", member);

	    log.debug("<<인증 성공>>");
	    log.debug("<<id>> : " + member.getMem_email());
	    log.debug("<<auth>> : " + member.getMem_auth());

	    return "redirect:/main/main"; // 성공적으로 처리되면 메인 페이지로 리다이렉트
	}
	/*==============================
	 * 로그아웃
	 *==============================*/
	@GetMapping("/member/logout")
	public String processLogout(HttpSession session) {
		//로그아웃
		session.invalidate();

		//====자동로그인 시작====//
		//====자동로그인 끝=====//

		return "redirect:/main/main";	
	}
	/*==============================
	 * MY페이지
	 *==============================*/	
	@GetMapping("/member/myPage")
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
}
