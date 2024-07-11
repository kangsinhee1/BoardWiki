package kr.spring.rent.controller;

import java.io.IOException;
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
import kr.spring.rent.service.RentService;
import kr.spring.rent.vo.RentVO;
import kr.spring.util.PagingUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class RentController {
	@Autowired
	private RentService rentService;
	
	// 자바빈(VO) 초기화
		@ModelAttribute
		public RentVO initCommand() {
			return new RentVO();
		}
		
		
		/*=========================
		 * 보드게임 대여
		 *=========================*/
		// 대여 폼 호출
		@GetMapping("/rent/rent")
		public String form() {
			return "rentGame";
		}
		@PostMapping("/rent/rent")
		public String submit(@Valid RentVO rentVO,
							  BindingResult result,
							  HttpServletRequest request,
							  HttpSession session,
							  Model model) 
								throws IllegalStateException,
											IOException{
			log.debug("<<게시판 글 저장>> : " + rentVO);
			
			if(result.hasErrors()) {
				return form();
			}
			
			MemberVO vo = (MemberVO)session.getAttribute("user");
			rentVO.setMem_num(vo.getMem_num());
			
			rentService.insertRent(rentVO);
			
			model.addAttribute("message","성공적으로 대여가 완료되었습니다.");
			model.addAttribute("url",request.getContextPath()+"/rent/list");
			
			
			return "common/resultAlert";
		}
		
		
		/*=========================
		 * 대여 목록
		 *=========================*/
		@GetMapping("/rent/list")
		public String getRentList(
				@RequestParam(defaultValue="1") int pageNum,
				// @RequestParam(defaultValue="1") int order, 
				// @RequestParam(defaultValue="") String category,
				String keyfield,String keyword, Model model) {
			// log.debug("<<대여 목록 - category>> : " + category);
			// log.debug("<<주문 목록 - order>> : " + order);

			Map<String, Object> map = new HashMap<String, Object>();

			// map.put("category", category);
			map.put("keyfield", keyfield);
			map.put("keyword", keyword);
		
			// 전체, 검색 레코드 수
			int count = rentService.selectRowCount(map);
			
			// 페이지 처리
			PagingUtil page = new PagingUtil(keyfield, keyword, pageNum, count, 20, 10, "list");
			List<RentVO> list = null;
			
			if(count > 0) {
				// map.put("order", order);
				map.put("start", page.getStartRow());
				map.put("end", page.getEndRow());
				
				list = rentService.selectRentList(map);
				
				
			}
			model.addAttribute("count", count);
			model.addAttribute("list", list);
			model.addAttribute("page", page.getPage());
			
			return "rentList";
		}
		

}
