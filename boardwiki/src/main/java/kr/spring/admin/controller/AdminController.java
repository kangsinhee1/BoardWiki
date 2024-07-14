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

import kr.spring.item.service.ItemService;
import kr.spring.item.vo.ItemVO;
import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import kr.spring.util.PagingUtil;

@Controller
public class AdminController {
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private ItemService itemService;
	
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
		Map<String,Object> map = new HashMap<String,Object>();

		map.put("category", category);
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		int count = memberService.countAllmember(map); 
		
		PagingUtil page =
				new PagingUtil(keyfield,keyword,pageNum,count,10,10,"memberManage");
		 
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
		Map<String,Object> map = new HashMap<String,Object>();
		
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
		Map<String,Object> map = new HashMap<String,Object>();
		
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
		Map<String,Object> map = new HashMap<String,Object>();
		
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
		Map<String,Object> map = new HashMap<String,Object>();
		
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
		Map<String,Object> map = new HashMap<String,Object>();
		
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
		
		return "reportManage";
	}
	/*==============================
	 * 관리자 페이지 (Qna 관리)
	 *==============================*/	
	@GetMapping("/adminPage/QnaManage")
	public String QnaManagePage(@RequestParam(defaultValue="1") int pageNum,
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
		Map<String,Object> map = new HashMap<String,Object>();
		
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
		
		return "QnaManage";
	}
}
