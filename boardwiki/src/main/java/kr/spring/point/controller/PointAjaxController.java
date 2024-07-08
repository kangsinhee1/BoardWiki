package kr.spring.point.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.member.vo.MemberVO;
import kr.spring.point.service.PointService;
import kr.spring.point.vo.PointVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class PointAjaxController {
	@Autowired
	private PointService pointService;
	
	/**포인트 변동 등록*/
	@PostMapping("/point/getpoint")
	@ResponseBody
	public Map<String, String> getpoint(PointVO pointVO,HttpSession session,HttpServletRequest request){
		Map<String,String> mapJson = new HashMap<String, String>();
		
		MemberVO user=(MemberVO)session.getAttribute("user");
		if(user == null) {
			mapJson.put("result", "logout");
		}else {
			pointVO.setMem_num(user.getMem_num());
			
			pointService.processPointTransaction(pointVO);
			mapJson.put("result", "success");
		}
		return mapJson;
	}
}
