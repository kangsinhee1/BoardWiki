package kr.spring.admin.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.board.service.BoardService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class AdminAjaxController {
	
	@Autowired
	BoardService boardService;
	
	//등급 처리
	@PostMapping("/adminPage/changeAuth")
	@ResponseBody
	public Map<String,String> changeAuth(
			Long report_type, Long use_num,Long use_auth,
			Long tea_num,Long tea_status,Long boa_num,
			Long boa_auth,Long tnr_num, Long tnr_auth){
		log.debug("report_type" + report_type);
		log.debug("boa_num" + boa_num);
		log.debug("boa_auth" + boa_auth);
		
		Map<String,String> mapJson = new HashMap<>();
		
		if(report_type == 1 ) {
			boardService.updateBoardAuth(boa_num, boa_auth);
			mapJson.put("result", "success");
		}else if(report_type == 5) {
			mapJson.put("result", "success");
			
		}else if(report_type == 6) {
			mapJson.put("result", "success");
			
		}else if(report_type == 7) {
			mapJson.put("result", "success");
		
		}else {
			mapJson.put("result", "error");
			
		}
		
		return mapJson;
	}
}
