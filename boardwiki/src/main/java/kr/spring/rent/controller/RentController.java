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
		public String form(RentVO rentVO) {
			return "rentGame";
		}
		// 등록 폼에서 전송된 데이터 처리
		@PostMapping("/rent/rent")
		public String submit(@Valid RentVO rentVO,
		                      BindingResult result,
		                      @RequestParam(value = "item_num", required = true) int item_num,
		                      HttpServletRequest request,
		                      HttpSession session,
		                      Model model)
		                      throws IllegalStateException, IOException {
		    log.debug("<<대여 저장>> : " + rentVO);
		    log.debug("Received item_num: " + item_num);

		    if(result.hasErrors()) {
		        return "rentGame";
		    }

		    MemberVO vo = (MemberVO)session.getAttribute("user");
		    rentVO.setMem_num(vo.getMem_num());
		    rentVO.setItem_num(item_num);
		    rentVO.setRent_status(1);

		    rentService.insertRent(rentVO);

		    model.addAttribute("message", "성공적으로 대여가 완료되었습니다.");
		    model.addAttribute("url", request.getContextPath() + "/rent/list");

		    return "common/resultAlert";
		}


		/*=========================
		 * 대여 목록
		 *=========================*/
		@GetMapping("/myPage/rent")
		public String getRentList(
		        @RequestParam(defaultValue = "1") int pageNum,
		        @RequestParam(defaultValue="1") int order,
		        HttpServletRequest request,
		        HttpSession session,
		        @RequestParam(defaultValue = "") String keyfield,
		        @RequestParam(defaultValue = "") String keyword,
		        @RequestParam(required = false) String startDate,
		        @RequestParam(required = false) String endDate,
		        Model model) {

		    log.debug("<<대여 목록 - order>> : " + order);
		    
		    // 서비스 메서드에 전달할 파라미터를 담는 맵 생성
		    Map<String, Object> map = new HashMap<>();
		    map.put("keyfield", keyfield);
		    map.put("keyword", keyword);

		    // 세션에서 회원 정보 가져오기 ("user"로 저장된 회원 정보 전제)
		    MemberVO vo = (MemberVO) session.getAttribute("user");
		    int mem_num = (int) vo.getMem_num();

		    // mem_num을 맵에 추가
		    map.put("mem_num", mem_num);

		    // startDate와 endDate가 존재하는 경우, 맵에 추가
		    if (startDate != null && !startDate.isEmpty() && endDate != null && !endDate.isEmpty()) {
		        map.put("startDate", startDate);
		        map.put("endDate", endDate);
		    }

		    // 검색 조건에 따른 전체 레코드 수 가져오기
		    int count = rentService.selectRowCount(map);

		    // 페이지 처리를 위한 페이징 유틸리티 생성
		    PagingUtil page = new PagingUtil(keyfield, keyword, pageNum, count, 20, 10, "list"+"&order="+order);
		    List<RentVO> list = null;

		    // 검색 결과가 있는 경우, 해당 결과 리스트 가져오기
		    if (count > 0) {
		        map.put("order", order);
		        map.put("start", page.getStartRow());
		        map.put("end", page.getEndRow());
		        list = rentService.selectRentList(map);
		    }

		    // 뷰에서 사용할 모델에 속성 추가
		    model.addAttribute("count", count);
		    model.addAttribute("list", list);
		    model.addAttribute("page", page.getPage());
		    log.debug("<<카운트  : >>" + count);

		    return "rentList"; // rentList 뷰 이름 반환
		}
		/*=========================
		 * 보드게임 반납
		 *=========================*/
		@GetMapping("/rent/return")
	    public String returnRent(@RequestParam("rent_num") Long rent_num) {
	        rentService.updateRentStatus(rent_num);

	        return "redirect:/rent/list"; // 리턴 후 이동할 페이지를 설정하세요.
	    }



}
