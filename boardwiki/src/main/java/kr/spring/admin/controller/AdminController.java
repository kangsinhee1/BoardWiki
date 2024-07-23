package kr.spring.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.board.service.BoardService;
import kr.spring.board.vo.BoardVO;
import kr.spring.contest.service.ContestService;
import kr.spring.contest.vo.ContestVO;
import kr.spring.item.service.ItemService;
import kr.spring.item.vo.ItemVO;
import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import kr.spring.rent.service.RentService;
import kr.spring.rent.vo.RentVO;
import kr.spring.report.service.ReportService;
import kr.spring.report.vo.ReportVO;
import kr.spring.util.PagingUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class AdminController {
	@Autowired
	private MemberService memberService;

	@Autowired
	private ItemService itemService;

	@Autowired
	private RentService rentService;

	@Autowired
	private BoardService boardService;

	@Autowired
	private ReportService reportService;
	
	@Autowired
	private ContestService contestService;
	/*==============================
	 * 관리자 페이지 메인
	 *==============================*/
	@GetMapping("/admin/adminPage")
	public String adminPage(HttpSession session,
							HttpServletRequest request,
							Model model) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user.getMem_auth()!= 9) {
			model.addAttribute("message","관리자 등급만 접속할 수 있습니다.");
			model.addAttribute("url",request.getContextPath()+"/main/main");
			return "common/resultAlert";
		}

		return "adminPage";
	}

	/*==============================
	 * 관리자 페이지 (회원관리)
	 *==============================*/
	@GetMapping("/adminPage/memberManage")
	public String memberManagePage(@RequestParam(defaultValue="1") int pageNum,
            						@RequestParam(defaultValue="") String category,
            						String keyfield,
            						String keyword,Model model,
            						HttpSession session,
            						HttpServletRequest request
            						) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user.getMem_auth()!= 9) {
			model.addAttribute("message","관리자 등급만 접속할 수 있습니다.");
			model.addAttribute("url",request.getContextPath()+"/main/login");
			return "common/resultAlert";
		}
		Map<String,Object> map = new HashMap<>();

		map.put("category", category);
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);

		int count = memberService.countAllmember(map);

		PagingUtil page =
				new PagingUtil(keyfield,keyword,pageNum,count,5,10,"memberManage");

		List<MemberVO> list = null;
	    if(count > 0) {
	    	map.put("start", page.getStartRow());
	    	map.put("end", page.getEndRow());

	    	list = memberService.selectAllmember(map);
	    }

	    model.addAttribute("count", count);
		model.addAttribute("list", list);
		model.addAttribute("page", page.getPage());

		return "memberManage";
	}

	/*==============================
	 * 관리자 페이지 (제품관리)
	 *==============================*/
	@GetMapping("/adminPage/gameManage")
	public String gameManagePage(@RequestParam(defaultValue="1") int pageNum,
								 @RequestParam(defaultValue="") String category,
								 String keyfield,
								 String keyword,Model model,
								 HttpSession session,
								 HttpServletRequest request) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user.getMem_auth()!= 9) {
			model.addAttribute("message","관리자 등급만 접속할 수 있습니다.");
			model.addAttribute("url",request.getContextPath()+"/main/login");
			return "common/resultAlert";
		}
		Map<String,Object> map = new HashMap<>();

		map.put("category", category);
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);

		int count = itemService.selectRowCount(map);

		PagingUtil page =
				new PagingUtil(keyfield,keyword,pageNum,count,10,10,"gameManage");

		List<ItemVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());

			list = itemService.selectList(map);
		}

		model.addAttribute("count", count);
		model.addAttribute("list", list);
		model.addAttribute("page", page.getPage());

		return "gameManage";
	}

	/*==============================
	 * 관리자 페이지 (주문관리)
	 *==============================*/
	@GetMapping("/adminPage/orderManage")
	public String orderManagePage(@RequestParam(defaultValue="1") int pageNum,
			@RequestParam(defaultValue="") String category,
			String keyfield,
			String keyword,Model model,
			HttpSession session,
			HttpServletRequest request) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user.getMem_auth()!= 9) {
			model.addAttribute("message","관리자 등급만 접속할 수 있습니다.");
			model.addAttribute("url",request.getContextPath()+"/main/login");
			return "common/resultAlert";
		}
		Map<String,Object> map = new HashMap<>();

		map.put("category", category);
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);

		int count = itemService.selectRowCount2(map);

		PagingUtil page =
				new PagingUtil(keyfield,keyword,pageNum,count,20,10,"gameManage");

		List<ItemVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());


			list = itemService.selectList(map);
		}

		model.addAttribute("count", count);
		model.addAttribute("list", list);
		model.addAttribute("page", page.getPage());

		return "orderManage";
	}
	/*==============================
	 * 관리자 페이지 (방송관리)
	 *==============================*/
	@GetMapping("/adminPage/streamingManage")
	public String streamingManagePage(@RequestParam(defaultValue="1") int pageNum,
			@RequestParam(defaultValue="") String category,
			String keyfield,
			String keyword,Model model,
			HttpSession session,
			HttpServletRequest request) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user.getMem_auth()!= 9) {
			model.addAttribute("message","관리자 등급만 접속할 수 있습니다.");
			model.addAttribute("url",request.getContextPath()+"/main/login");
			return "common/resultAlert";
		}
		Map<String,Object> map = new HashMap<>();

		map.put("category", category);
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);

		int count = itemService.selectRowCount2(map);

		PagingUtil page =
				new PagingUtil(keyfield,keyword,pageNum,count,20,10,"gameManage");

		List<ItemVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());


			list = itemService.selectList(map);
		}

		model.addAttribute("count", count);
		model.addAttribute("list", list);
		model.addAttribute("page", page.getPage());

		return "streamingManage";
	}
	/*==============================
	 * 관리자 페이지 (포인트 관리)
	 *==============================*/
	@GetMapping("/adminPage/pointManage")
	public String pointManagePage(@RequestParam(defaultValue="1") int pageNum,
			@RequestParam(defaultValue="") String category,
			String keyfield,
			String keyword,Model model,
			HttpSession session,
			HttpServletRequest request) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user.getMem_auth()!= 9) {
			model.addAttribute("message","관리자 등급만 접속할 수 있습니다.");
			model.addAttribute("url",request.getContextPath()+"/main/login");
			return "common/resultAlert";
		}
		Map<String,Object> map = new HashMap<>();

		map.put("category", category);
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);

		int count = itemService.selectRowCount2(map);

		PagingUtil page =
				new PagingUtil(keyfield,keyword,pageNum,count,20,10,"gameManage");

		List<ItemVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());


			list = itemService.selectList(map);
		}

		model.addAttribute("count", count);
		model.addAttribute("list", list);
		model.addAttribute("page", page.getPage());

		return "pointManage";
	}
	/*==============================
	 * 관리자 페이지 (신고 관리)
	 *==============================*/
	@GetMapping("/adminPage/reportManage")
	public String reportManagePage(@RequestParam(defaultValue="1") int pageNum,
			@RequestParam(defaultValue="") String category,
			String keyfield,
			String keyword,Model model,
			HttpSession session,
			HttpServletRequest request) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user.getMem_auth()!= 9) {
			model.addAttribute("message","관리자 등급만 접속할 수 있습니다.");
			model.addAttribute("url",request.getContextPath()+"/main/login");
			return "common/resultAlert";
		}
		Map<String,Object> map = new HashMap<>();

		map.put("category", category);
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);

		int count = reportService.getReportRowCount(map);

		PagingUtil page =
				new PagingUtil(keyfield,keyword,pageNum,count,10,10,"reportManage");

		List<ReportVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());


			list = reportService.selectReportList(map);
		}

		model.addAttribute("count", count);
		model.addAttribute("list", list);
		model.addAttribute("page", page.getPage());

		return "reportManage";
	}
	@GetMapping("/adminPage/reportDetail")
	public ModelAndView reportDetailPage(Long report_typeDetail,
								   int report_type) {
		
		ReportVO report = reportService.selectReportDetail(report_typeDetail, report_type);
		
		return new ModelAndView("reportDetail","report",report);
	}
	/*==============================
	 * 관리자 페이지 (Qna 관리)
	 *==============================*/
	@GetMapping("/adminPage/QnaManage")
	public String getList2(
			@RequestParam(defaultValue="1") int pageNum,
			@RequestParam(defaultValue="1") int order,
			@RequestParam(defaultValue="5") String boa_category,
			String keyfield,String keyword,Model model) {

	Map<String,Object> map = new HashMap<>();
	map.put("boa_category", boa_category);
	map.put("keyfield", keyfield);
	map.put("keyword", keyword);
	int count = boardService.selectRowCount(map);

	PagingUtil page = new PagingUtil(keyfield,keyword,pageNum,count,
						10,10,"QnaManage","&boa_category="+boa_category+"&order="+order);
	List<BoardVO> list = null;
	if(count > 0) {
		map.put("order", order);
		map.put("start", page.getStartRow());
		map.put("end", page.getEndRow());

		list = boardService.selectList(map);
	}

	model.addAttribute("count", count);
	model.addAttribute("list", list);
	model.addAttribute("page", page.getPage());


	return "QnaManage";
	}

	@GetMapping("/adminPage/QnaManage2")
	@ResponseBody
	public Map<String,Object> getList3(long boa_num) {
		Map<String,Object> map = new HashMap<>();
		log.debug("<<관리자답변>> : " + boa_num);
		List<BoardVO> list = null;
		int reply = boardService.selectAdminReply(boa_num);

		if(reply!=0) {
			map.put("result", "true");
		}else{
			map.put("result", "false");
		}

	return map;
	}
	/*=========================
	 * 관리자 대여 목록 조회
	 *=========================*/
	@GetMapping("/rent/rentListAdmin")
	public String getAdminRentList(
	        @RequestParam(defaultValue = "1") int pageNum,
	        @RequestParam(defaultValue = "") String keyfield,
	        @RequestParam(defaultValue = "") String keyword,
	        Model model) {

	    // 서비스 메서드에 전달할 파라미터를 담는 맵 생성
	    Map<String, Object> map = new HashMap<>();
	    map.put("keyfield", keyfield);
	    map.put("keyword", keyword);

	    // 검색 조건에 따른 전체 레코드 수 가져오기 (모든 회원 대여 목록 수)
	    int count = rentService.selectAllMembersRowCount(map);

	    // 페이지 처리를 위한 페이징 유틸리티 생성
	    PagingUtil page = new PagingUtil(keyfield, keyword, pageNum, count, 20, 10, "rentListAdmin");
	    List<RentVO> list = null;

	    // 검색 결과가 있는 경우, 해당 결과 리스트 가져오기
	    if (count > 0) {
	        map.put("start", page.getStartRow());
	        map.put("end", page.getEndRow());
	        list = rentService.selectAllMembersRentList(map);
	    }

	    // 뷰에서 사용할 모델에 속성 추가
	    model.addAttribute("count", count);
	    model.addAttribute("list", list);
	    model.addAttribute("page", page.getPage());

	    return "rentListAdmin"; // adminRentList 뷰 이름 반환
	}
	
	/*==============================
	 * 		관리자 페이지 (대회목록)
	 *==============================*/
	@GetMapping("/adminPage/contestAdminList")
	public String contestList(@RequestParam(defaultValue="1") int pageNum,
            						@RequestParam(defaultValue="") String category,
            						String keyfield,
            						String keyword,Model model,
            						HttpSession session,
            						HttpServletRequest request
            						) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user != null && user.getMem_auth()!= 9) {
			model.addAttribute("message","관리자 등급만 접속할 수 있습니다.");
			model.addAttribute("url",request.getContextPath()+"/main/login");
			return "common/resultAlert";
		}
		Map<String,Object> map = new HashMap<>();

		map.put("category", category);
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);

		int count = contestService.countAllcontest(map);

		PagingUtil page =
				new PagingUtil(keyfield,keyword,pageNum,count,5,10,"contestAdminList");

		List<ContestVO> list = null;
	    if(count > 0) {
	    	map.put("start", page.getStartRow());
	    	map.put("end", page.getEndRow());

	    	list = contestService.selectAllcontest(map);
	    }

	    model.addAttribute("count", count);
		model.addAttribute("list", list);
		model.addAttribute("page", page.getPage());

		return "contestAdminList";
	}

}
