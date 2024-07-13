package kr.spring.rulebook.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.member.vo.MemberVO;
import kr.spring.rulebook.service.RulebookService;
import kr.spring.rulebook.vo.RulebookVO;
import kr.spring.util.FileUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class RulebookAjaxController {
	@Autowired
	private RulebookService rulebookService;
	
	/*================
	 * 부모글 데이터 처리
	 *================*/
	//업로드 파일 삭제
	@PostMapping("/rulebook/deleteRulebookFile")
	@ResponseBody
	public Map<String,String> processFile(
			              long rulB_num,
			              HttpSession session,
			              HttpServletRequest request){
		Map<String,String> mapJson = 
				      new HashMap<String,String>();
		MemberVO user = 
				(MemberVO)session.getAttribute("user");
		if(user==null) {
			mapJson.put("result", "logout");
		}else {
			RulebookVO db_rulebook = 
					rulebookService.selectRulebook(rulB_num); 
			//로그인한 회원번호와 작성자 회원번호 일치 여부 체크
			if(user.getMem_num() != db_rulebook.getMem_num()) {
				//불일치
				mapJson.put("result", "wrongAccess");
			}else {
				//일치
				rulebookService.deleteRulebookFile(rulB_num);
				FileUtil.removeFile(request, db_rulebook.getFilename());
				
				mapJson.put("result", "success");
			}
		}
		
		return mapJson;
	}
}
