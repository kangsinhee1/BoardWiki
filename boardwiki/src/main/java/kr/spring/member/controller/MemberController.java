package kr.spring.member.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;

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
import kr.spring.util.NaverLoginUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MemberController {
	@Autowired
	private MemberService memberService;

	@Autowired
	private NaverLoginUtil naverLoginUtil;
    

    // 자바빈(VO) 초기화
    @ModelAttribute
    public MemberVO initCommand() {
        return new MemberVO();
    }

    /*==============================
     * 회원 로그인
     *==============================*/
    
    // 로그인 폼 호출
    @GetMapping("/member/login")
    public String formLogin(Model model,HttpSession session) {
    	log.debug("<<로그인페이지 요청>>");
    	String naverAuthUrl = naverLoginUtil.getAuthorizationUrl(session);
		model.addAttribute("naverUrl", naverAuthUrl);
		
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
  			return formLogin(model, session);
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
  			
  			return formLogin(model, session);
  		}
  	}
  	//네이버 로그인 폼에서 받아온 데이터 처리
  	//네이버 - 네이버 로그인 성공시 callback 호출 후 사용자 정보 요청
  	@GetMapping("/oauth2/code/naver")
    public String callbackNaver(Model model,
                                @RequestParam Map<String, Object> paramMap,
                                @RequestParam String code,
                                @RequestParam String state,
                                HttpSession session) throws IOException {

        log.info("callbackNaver");

        log.debug("paramMap:" + paramMap);

        OAuth2AccessToken oauthToken = naverLoginUtil.getAccessToken(session, code, state);

        // 로그인 사용자 정보를 읽어온다.
        String apiResult = naverLoginUtil.getUserProfile(oauthToken);
        log.debug("apiResult : " + apiResult);

        // JSON 데이터를 Map으로 직접 처리
        Map<String, Object> mapJson = new HashMap<String, Object>();
        mapJson.put("response", apiResult); // 예시로 전체 API 응답을 넣었지만, 실제로는 필요한 부분을 추출하여 넣어야 함

        log.debug("apiJson : " + mapJson);

        // 사용자 정보 매핑
        MemberVO memberVO = new MemberVO();
        memberVO.setMem_email((String) mapJson.get("email"));
        memberVO.setMem_auth(0); // 예시로 회원 등급 설정
        memberVO.setMem_provider("naver");
        // 기타 필요한 사용자 정보들을 매핑해준다.
        memberVO.setMem_name((String) mapJson.get("name"));
        
        //회원 가입
        memberService.insertMember(memberVO);

        return "common/resultView"; // 예시로 회원 프로필 페이지로 이동
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
