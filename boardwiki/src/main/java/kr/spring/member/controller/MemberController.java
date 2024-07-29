package kr.spring.member.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.github.scribejava.core.model.OAuth2AccessToken;

import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import kr.spring.util.AuthCheckException;
import kr.spring.util.CaptchaUtil;
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
	private PasswordEncoder passwordEncoder;

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
		if(result.hasFieldErrors("mem_email") ||
				result.hasFieldErrors("mem_passwd")) {
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
				check = passwordEncoder.matches(memberVO.getMem_passwd(), member.getMem_passwd());

				log.debug("<<check:>>" + check);
			}
			if(check) {//인증 성공

				// 정지회원 여부 체크
				if (member.getMem_auth() == 1) {
					result.reject("noAuthority");
					log.debug("<<정지회원>>");
					return formLogin();
				}

				// 탈퇴회원 여부 체크
				if (member.getMem_auth() == 0) {
					result.reject("withdrawnMember");
					log.debug("<<탈퇴회원>>");
					return formLogin();
				}

				//==== 자동로그인 체크 시작====//
				boolean autoLogin = memberVO.getAuto() != null  && memberVO.getAuto().equals("on");

				if(autoLogin) {
					//자동로그인을 체크한 경우
					String au_id = memberVO.getAu_id();
					if(au_id == null) {
						au_id = UUID.randomUUID().toString();
						member.setAu_id(au_id);
						memberService.updateAu_id(member.getAu_id(), member.getMem_num());
					}
					Cookie auto_cookie = new Cookie("au-log", au_id);
					auto_cookie.setMaxAge(60*60*24*7);
					auto_cookie.setPath("/");
					response.addCookie(auto_cookie);
				}
				//==== 자동로그인 체크 끝=====//


				//인증 성공, 로그인 처리
				session.setAttribute("user", member);

				log.debug("<<인증 성공>>");
				log.debug("<<id>> : " + member.getMem_email());
				log.debug("<<auth>> : " + member.getMem_auth());
				log.debug("<<au_id>> : " + member.getMem_auth());


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
			return formRegister();
		}
		//회원 가입
		memberService.insertMember(memberVO);

		//UI 메시지 처리
		model.addAttribute("message", "회원가입완료");
		model.addAttribute("url",
				request.getContextPath()+"/main/main");

		return "common/resultAlert";
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

			return formMemberSocialRegister(); // 회원가입 폼으로 리다이렉트
		}
		if(!result.getMem_provider().equals("Naver")) {
			//UI 메시지 처리
			model.addAttribute("message", "회원님의 이메일로 가입된 다른 계정이 있습니다.");
			model.addAttribute("url",
					request.getContextPath()+"/member/login");

			return "common/resultAlert";
		}
		// 기존 회원 로그인 처리
		MemberVO member = memberService.selectCheckMember(naver_email);
		session.setAttribute("user", member);

		log.debug("<<인증 성공>>");
		log.debug("<<id>> : " + member.getMem_email());
		log.debug("<<auth>> : " + member.getMem_auth());

		/*
		 * //UI 메시지 처리 model.addAttribute("message", "Naver 로그인 완료");
		 * model.addAttribute("url", request.getContextPath()+"/main/main");
		 */

		return "redirect:/main/main";

	}

	@GetMapping("/member/memberSocialRegister")
	public String formMemberSocialRegister() {
		log.debug("<<소셜 회원가입 페이지 요청 메서드>>");
		return "memberSocialRegister";//Tiles 설정명
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
		
		
		model.addAttribute("message", "회원가입완료");
		model.addAttribute("url",
				request.getContextPath()+"/main/main");

		return "common/resultAlert";
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

		if(result == null) { // 카카오 메일로 조회해서 일치하는 정보가 없는 경우 회원가입
			memberVO.setMem_email(kakao_email);
			memberVO.setMem_passwd(kakao_passwd);
			memberVO.setMem_nickName(kakao_nickname);
			memberVO.setMem_provider("Kakao");

			model.addAttribute("memberVO", memberVO);

			log.debug("<<model>> : " + model);
			log.debug("<<memberVO>> : " + memberVO);

			return formMemberSocialRegister(); // 회원가입 폼으로 리다이렉트
		}

		if(!result.getMem_provider().equals("Kakao")) {
			//UI 메시지 처리
			//			model.addAttribute("accessTitle", "로그인 오류");
			model.addAttribute("message", "회원님의 이메일로 가입된 다른 계정이 있습니다.");
			//			model.addAttribute("accessBtn", "확인");
			model.addAttribute("url",
					request.getContextPath()+"/member/login");

			return "common/resultAlert";
		}
		// 기존 회원 로그인 처리
		MemberVO member = memberService.selectCheckMember(kakao_email);
		session.setAttribute("user", member);

		log.debug("<<인증 성공>>");
		log.debug("<<id>> : " + member.getMem_email());
		log.debug("<<auth>> : " + member.getMem_auth());

//		//UI 메시지 처리
//		model.addAttribute("message", "Kakao 로그인 완료");
//		model.addAttribute("url",
//				request.getContextPath()+"/main/main");

		return "redirect:/main/main";
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

			return formMemberSocialRegister(); // 회원가입 폼으로 리다이렉트
		}


		if (!result.getMem_provider().equals("Google")) {
			// UI 메시지 처리
			model.addAttribute("accessTitle", "로그인 오류");
			model.addAttribute("accessMsg", "회원님의 이메일로 가입된 다른 계정이 있습니다.");
			model.addAttribute("accessBtn", "확인");
			model.addAttribute("accessUrl",
					request.getContextPath() + "/member/login");

			return "common/resultAlert";
		}

		// 기존 회원 로그인 처리
		MemberVO member = memberService.selectCheckMember(google_email);
		session.setAttribute("user", member);

		log.debug("<<인증 성공>>");
		log.debug("<<id>> : " + member.getMem_email());
		log.debug("<<auth>> : " + member.getMem_auth());

//		//UI 메시지 처리
//		model.addAttribute("message", "Google 로그인 완료");
//		model.addAttribute("url",
//				request.getContextPath()+"/main/main");

		return "redirect:/main/main";
	}
	/*==============================
	 * 로그아웃
	 *==============================*/
	@GetMapping("/member/logout")
	public String processLogout(HttpSession session, HttpServletResponse response) {
		//로그아웃
		session.invalidate();

		//====자동로그인 시작====//
		//클라이언트 쿠키 처리
		Cookie auto_cookie = new Cookie("au-log","");
		auto_cookie.setMaxAge(0);//쿠키 삭제
		auto_cookie.setPath("/");

		response.addCookie(auto_cookie);
		//====자동로그인 끝=====//

		return "redirect:/main/main";
	}

	/*==============================
	 * 회원정보 수정
	 *==============================*/
	//수정 폼 호출
	@GetMapping("/member/memberUpdate")
	public String formUpdate(HttpSession session,Model model) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		MemberVO memberVO =
				memberService.selectMember(user.getMem_num());
		model.addAttribute("memberVO", memberVO);

		return "memberModify";
	}
	//수정폼에서 전송된 데이터 처리
	@PostMapping("/member/memberUpdate")
	public String submitUpdate(@Valid MemberVO memberVO,
			BindingResult result,
			HttpSession session) {
		log.debug("<<회원정보 수정>> : " + memberVO);

		//유효성 체크 결과 오류가 있으면 폼 호출
		if(result.hasErrors()) {
			return "memberModify";
		}

		MemberVO user = (MemberVO)session.getAttribute("user");
		memberVO.setMem_num(user.getMem_num());

		//회원정보 수정
		memberService.updateMember_detail(memberVO);

		/*
		 * //세션에 저장된 정보 변경 user.setMem_nickName(memberVO.getMem_nickName());
		 */

		return "redirect:/myPage/myPage";
	}
	/*==============================
	 * 비밀번호 변경
	 *==============================*/
	//비밀번호 변경 폼 호출
	@GetMapping("/member/changePassword")
	public String formChangePassword() {
		return "memberChangePassword";
	}
	//비밀번호 변경 폼에서 전송된 데이터 처리
	@PostMapping("/member/changePassword")
	public String submitChangePasword(
			@Valid MemberVO memberVO,
			BindingResult result,
			HttpSession session,
			Model model,
			HttpServletRequest request) {
		log.debug("<<비밀번호 변경 처리>> : " + memberVO);

		//유효성 체크 결과 오류가 있으면 폼 호출
		if(result.hasFieldErrors("now_passwd")
				|| result.hasFieldErrors("passwd")
				|| result.hasFieldErrors("captcha_chars")) {
			return formChangePassword();
		}

		//====== 캡챠 문자 체크 시작 ======//
		String code = "1";//키 발급 0, 캡챠 이미지 비교시 1로 세팅
		//캡챠 키 발급시 받은 키값
		String key = (String)session.getAttribute("captcha_key");
		//사용자가 입력한 캡챠 이미지 글자값
		String value = memberVO.getCaptcha_chars();
		String apiURL = "https://openapi.naver.com/v1/captcha/nkey?code=" + code + "&key=" + key + "&value=" + value;

		Map<String,String> requestHeaders =
				new HashMap<>();
		requestHeaders.put("X-Naver-Client-Id", "aGoUsn2QY4b5ZsjIvvn_");
		requestHeaders.put("X-Naver-Client-Secret", "mdnzHOAtxH");
		String responseBody = CaptchaUtil.get(
				apiURL, requestHeaders);
		log.debug("<<캡챠 결과>> : " + responseBody);

		JSONObject jObject = new JSONObject(responseBody);
		boolean captcha_result = jObject.getBoolean("result");
		if(!captcha_result) {
			result.rejectValue("captcha_chars", "invalidCaptcha");
			return formChangePassword();
		}
		//====== 캡챠 문자 체크 끝 ======//
		MemberVO user = (MemberVO)session.getAttribute("user");
		memberVO.setMem_num(user.getMem_num());

		MemberVO db_member = memberService.selectMember(
				memberVO.getMem_num());
		//폼에서 전송한 현재 비밀번호와 DB에서 읽어온 비밀번호 일치 여부 체크
		if (!passwordEncoder.matches(memberVO.getNow_passwd(), db_member.getMem_passwd())) {
			result.rejectValue("now_passwd", "invalidPassword");
			return formChangePassword();
		}

		//비밀번호 수정
		memberService.updatePassword(memberVO);

		//설정되어 있는 자동로그인 기능 해제(모든 브라우저에 설정된 자동로그인 해제)
		memberService.deleteAu_id(memberVO.getMem_num());

		//View에 표시할 메시지
		model.addAttribute("message",
				"비밀번호 변경 완료(*재접속시 설정되어 있는 자동로그인 기능 해제*)");
		model.addAttribute("url",
				request.getContextPath() + "/myPage/myPage");

		return "common/resultAlert";
	}
	/*==============================
	 * 네이버 캡챠 API 사용
	 *==============================*/
	//캡챠 이미지 호출
	@GetMapping("/member/getCaptcha")
	public String getCaptcha(Model model,HttpSession session) {

		String code = "0"; //키 발급시 0, 캡챠 이미지 비교시 1로 세팅
		String key_apiURL = "https://openapi.naver.com/v1/captcha/nkey?code=" + code;

		Map<String,String> requestHeaders =
				new HashMap<>();
		requestHeaders.put("X-Naver-Client-Id", "aGoUsn2QY4b5ZsjIvvn_");
		requestHeaders.put("X-Naver-Client-Secret", "mdnzHOAtxH");
		String responseBody = CaptchaUtil.get(
				key_apiURL, requestHeaders);
		log.debug("<<responseBody>> : " + responseBody);

		JSONObject jObject = new JSONObject(responseBody);
		try {
			//https://openapi.naver.com/v1/captcha/nkey 호출로 받은 키값
			String key = jObject.getString("key");
			session.setAttribute("captcha_key", key);

			String apiURL = "https://openapi.naver.com/v1/captcha/ncaptcha.bin?key=" + key;

			byte[] reponse_byte = CaptchaUtil.getCaptchaImage(
					apiURL, requestHeaders);
			model.addAttribute("imageFile", reponse_byte);
			model.addAttribute("filename", "captcha.jpg");
		}catch(Exception e) {
			log.error(e.toString());
		}
		return "imageView";
	}

	/*==============================
	 * 			이메일 찾기
	 *==============================*/
	@GetMapping("/member/memberFindEmail")
	public String FindEmailForm(Model model) {
		model.addAttribute("memberVO", new MemberVO());
		return "memberFindEmail"; //
	}

	@PostMapping("/member/memberFindEmail")
	public String processFindEmail(@Valid MemberVO memberVO,
			BindingResult result, Model model, HttpServletRequest request) {
		if (result.hasErrors()) {
			// 입력값 유효성 검사 실패 시 처리
			model.addAttribute("error", "입력값이 유효하지 않습니다.");
			return "findEmailForm"; // 다시 입력 폼으로 이동
		}

		// 이름과 전화번호로 이메일 조회
		String mem_name = memberVO.getMem_name();
		String mem_phone = memberVO.getMem_phone();
		MemberVO foundEmail = memberService.findEmail(mem_name, mem_phone);

		if (foundEmail != null) {
			model.addAttribute("foundEmail", foundEmail.getMem_email());
			model.addAttribute("foundProvider", foundEmail.getMem_provider());
			return "showEmail"; // 이메일을 보여주는 페이지로 이동
		}else {
			// 일치하는 정보가 없는 경우 에러 메시지를 모델에 추가하여 resultAlert 화면으로 이동
			model.addAttribute("message", "일치하는 정보가 없습니다.");
			model.addAttribute("url", request.getContextPath() + "/memberFindEmail");
			return "common/resultAlert";
		}
	}

	@GetMapping("/member/showEmail")
	public String showEmail() {
		// 이메일을 보여주는 페이지의 경로를 반환
		return "showEmail"; // showEmail.jsp 또는 .html 페이지
	}


	/*==============================
	 * 	   		비밀번호 초기화
	 *==============================*/
	@GetMapping("/member/sendResetCode")
	public String sendResetCodeForm() {
		return "checkResetCode";
	}
	//비밀번호 재설정 폼
	@GetMapping("/member/resetPassword")
	public String resetPasswdForm() {
		return "resetPassword";
	}

	@PostMapping("/member/resetPassword")
	public String submitResetPasswd(@Valid MemberVO memberVO,
			BindingResult result,
			HttpSession session,
			Model model,
			HttpServletRequest request) {

		log.debug("<<submitResetPasswd 진입>>");

		//유효성 체크 결과 오류가 있으면 폼 호출
		if(result.hasFieldErrors("now_passwd")
				|| result.hasFieldErrors("passwd")
				|| result.hasFieldErrors("captcha_chars")) {
			return formChangePassword();
		}

		//====== 캡챠 문자 체크 시작 ======//
		String code = "1";//키 발급 0, 캡챠 이미지 비교시 1로 세팅
		//캡챠 키 발급시 받은 키값
		String key = (String)session.getAttribute("captcha_key");
		//사용자가 입력한 캡챠 이미지 글자값
		String value = memberVO.getCaptcha_chars();
		String apiURL = "https://openapi.naver.com/v1/captcha/nkey?code=" + code + "&key=" + key + "&value=" + value;

		Map<String,String> requestHeaders =
				new HashMap<>();
		requestHeaders.put("X-Naver-Client-Id", "aGoUsn2QY4b5ZsjIvvn_");
		requestHeaders.put("X-Naver-Client-Secret", "mdnzHOAtxH");
		String responseBody = CaptchaUtil.get(
				apiURL, requestHeaders);
		log.debug("<<캡챠 결과>> : " + responseBody);

		JSONObject jObject = new JSONObject(responseBody);
		boolean captcha_result = jObject.getBoolean("result");
		if(!captcha_result) {
			result.rejectValue("captcha_chars", "invalidCaptcha");
			return resetPasswdForm();
		}
		//====== 캡챠 문자 체크 끝 ======//

		 // 세션에서 이메일 주소를 문자열로 가져옵니다
	    String mem_email = (String) session.getAttribute("resetPasswordEmail");

	    log.debug("<<mem_email : >>" + mem_email);
	    if (mem_email == null) {
	        model.addAttribute("message", "잘못된 접근입니다.");
	        model.addAttribute("url", request.getContextPath() + "/main/main");
	        return "common/resultAlert";
	    }
	    MemberVO db_member = memberService.selectCheckMember(mem_email);
	    memberVO.setMem_email(mem_email);

		memberVO.setMem_num(db_member.getMem_num());

		log.debug("<<memberVO : >>" + memberVO);

		//비밀번호 수정
		memberService.updatePassword(memberVO);

		//설정되어 있는 자동로그인 기능 해제(모든 브라우저에 설정된 자동로그인 해제)
		memberService.deleteAu_id(memberVO.getMem_num());


		//View에 표시할 메시지
		model.addAttribute("message",
				"비밀번호 재설정 완료(*재접속시 설정되어 있는 자동로그인 기능 해제*)");
		model.addAttribute("url",
				request.getContextPath() + "/main/main");

		return "common/resultAlert";
	}


	/*==============================
	 * 	   		회원 탈퇴
	 *==============================*/
	//비밀번호 변경 폼
	@GetMapping("/member/memberDelete")
	public String formMemberDelete() {
		return "memberDelete";
	}

	//회원탈퇴 폼에서 전송된 데이터 처리
		@PostMapping("/member/memberDelete")
		public String submitMemberDelete(
				@Valid MemberVO memberVO,
				BindingResult result,
				HttpSession session,
				Model model,
				HttpServletRequest request) {
			log.debug("<<회원 탈퇴 처리>> : " + memberVO);

			//유효성 체크 결과 오류가 있으면 폼 호출
			if(result.hasFieldErrors("now_passwd")
					|| result.hasFieldErrors("passwd")
					|| result.hasFieldErrors("captcha_chars")) {
				return formMemberDelete();
			}
			MemberVO user = (MemberVO)session.getAttribute("user");
			memberVO.setMem_num(user.getMem_num());

			MemberVO db_member = memberService.selectMember(
					memberVO.getMem_num());
			//폼에서 전송한 현재 비밀번호와 DB에서 읽어온 비밀번호 일치 여부 체크
			if (!passwordEncoder.matches(memberVO.getMem_passwd(), db_member.getMem_passwd())) {
				result.rejectValue("mem_passwd", "invalidPassword");
				return formMemberDelete();
			}

			//회원탈퇴
			memberService.deleteMember(memberVO.getMem_num());

			//View에 표시할 메시지
			model.addAttribute("message",
					"탈퇴 완료 감사합니다.");
			model.addAttribute("url",
					request.getContextPath() + "/main/main");

			session.invalidate();

			return "common/resultAlert";
		}
}
