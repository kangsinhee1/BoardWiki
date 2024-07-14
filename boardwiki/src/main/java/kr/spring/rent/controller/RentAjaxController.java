package kr.spring.rent.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.member.vo.MemberVO;
import kr.spring.rent.service.RentService;
import kr.spring.rent.vo.RentVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class RentAjaxController {

	@Autowired
	private RentService rentService;

	// 대여 반납 Ajax 처리
	@PostMapping("/rent/returnRent")
	@ResponseBody
	public Map<String, String> returnRent(RentVO rentVO, HttpSession session, HttpServletRequest request) {
		log.debug("<<게임 반납 - RentVO>> : " + rentVO);

		Map<String, String> mapJson = new HashMap<String, String>();
		MemberVO user = (MemberVO) session.getAttribute("user");

		if (user == null) {
			// 로그인 안 됨
			mapJson.put("result", "logout");
		} else {
			rentService.updateRentStatus(rentVO.getRent_num());
			mapJson.put("result", "success");

		}
		return mapJson;
	}
}
