package kr.spring.used.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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

import kr.spring.member.vo.MemberVO;
import kr.spring.used.service.UsedService;
import kr.spring.used.vo.UsedItemVO;
import kr.spring.util.PagingUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class UsedController {
	@Autowired
	UsedService usedService;
	
	//자바빈(VO) 초기화
	@ModelAttribute
	public UsedItemVO initCommand() {
		return new UsedItemVO();
	}
	/*=====================
	 * 모임게시판 목록
	 *=====================*/
	@GetMapping("/used/usedList")
	public String selectList(
			 @RequestParam(defaultValue="1") int pageNum,
			 @RequestParam(defaultValue="1") int order,
			 String keyfield,String keyword,Model model) {
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		int count = usedService.getUsedRowCount(map);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(keyfield, keyword, pageNum,count,20,10,"usedList","&order="+order);
		List<UsedItemVO> list = null;
		if(count >0) {
			map.put("order", order);
			map.put("start",page.getStartRow());
			map.put("end",page.getEndRow());
			list = usedService.selectUsedList(map);
			
		}
		model.addAttribute("count",count);
		model.addAttribute("list",list);
		model.addAttribute("page",page.getPage());
		return "usedList";
	};
	/*=====================
	 * 모임 게시판 작성
	 *=====================*/
	@GetMapping("/used/usedWrite")
	public String insertUsed() {
		return "usedWrite";
	}
	@PostMapping("/used/usedWrite")
	public String submitUsed(@Valid UsedItemVO usedVO,
								BindingResult result,
								HttpServletRequest request,
								HttpSession session,
								Model model) {
		log.debug("<<모임게시판 글 작성>> : " + usedVO);
		//유효성 체크 결과 오류가 있으면 폼 호출
		if(result.hasErrors()) {
			return insertUsed();
		}
		//회원번호 세팅
		MemberVO member = (MemberVO)session.getAttribute("user");
		usedVO.setMem_num(member.getMem_num());
		//모임글쓰기
		usedService.insertUsed(usedVO);
		//View 메시지 처리
				model.addAttribute("message", "성공적으로 글이 등록되었습니다.");
				model.addAttribute("url", 
						 request.getContextPath()+"/used/usedList");
		return "common/resultAlert";
	}
}
