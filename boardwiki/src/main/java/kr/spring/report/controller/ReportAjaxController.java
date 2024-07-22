package kr.spring.report.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.member.vo.MemberVO;
import kr.spring.report.service.ReportService;
import kr.spring.report.vo.ReportVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ReportAjaxController {
	
	@Autowired
	ReportService reportService;
	
	//신고접수
	@PostMapping("/*/insertReport")
	@ResponseBody
	public Map<String, String> insertReport(ReportVO reportVO,
										   HttpSession session,
										   HttpServletRequest request){
		Map<String,String> mapJson = 
				new HashMap<String,String>();
		log.debug("<<<<<<<<<<<<<<reportVO : " + reportVO);

		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user == null) {
			//로그인 안 됨
			mapJson.put("result", "logout");
		}else {
			//회원번호 저장
			reportVO.setReporter_num(user.getMem_num());
			log.debug("<<<<<<<<<<<<<<reportVO : " + reportVO);
			//신고 접수
			reportService.insertReport(reportVO);
			//댓글 등록
			mapJson.put("result", "success");
		}		
		return mapJson;

	}	
	
	
}