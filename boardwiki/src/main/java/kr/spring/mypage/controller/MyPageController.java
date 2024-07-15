package kr.spring.mypage.controller;



import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.spring.board.service.BoardService;
import kr.spring.board.vo.BoardVO;
import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import kr.spring.util.PagingUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MyPageController {
	@Autowired
	private MemberService memberService;

	@Autowired
	private BoardService boardService;




	/*==============================
	 * MY페이지
	 *==============================*/	
	@GetMapping("/myPage/myPage")
	public String process(HttpSession session,Model model) {
		MemberVO user = 
				(MemberVO)session.getAttribute("user");
		//회원정보
		MemberVO member = 
				memberService.selectMember(user.getMem_num());
		log.debug("<<MY페이지>> : " + member);

		model.addAttribute("member", member);

		return "myPage";
	}
	/*==============================
	 * MY페이지 (내 알람)
	 *==============================*/	
	@GetMapping("/myPage/myAlert")
	public String myAlertPage(HttpSession session,Model model) {
		MemberVO user = 
				(MemberVO)session.getAttribute("user");
		//회원정보
		MemberVO member = 
				memberService.selectMember(user.getMem_num());
		log.debug("<<MY페이지>> : " + member);

		model.addAttribute("member", member);

		return "myAlert";
	}
	/*==============================
	 * MY페이지 (내 채팅방)
	 *==============================*/	
	@GetMapping("/myPage/myChat")
	public String myChatPage(HttpSession session,Model model) {
		MemberVO user = 
				(MemberVO)session.getAttribute("user");
		//회원정보
		MemberVO member = 
				memberService.selectMember(user.getMem_num());
		log.debug("<<MY페이지>> : " + member);

		model.addAttribute("member", member);

		return "myChat";
	}
	/*==============================
	 * MY페이지 (내 주문)
	 *==============================*/	
	@GetMapping("/myPage/myOrder")
	public String myOrderPage(HttpSession session,Model model) {
		MemberVO user = 
				(MemberVO)session.getAttribute("user");
		//회원정보
		MemberVO member = 
				memberService.selectMember(user.getMem_num());
		log.debug("<<MY페이지>> : " + member);

		model.addAttribute("member", member);

		return "myOrder";
	}
	/*==============================
	 * MY페이지 (내 전적)
	 *==============================*/	
	@GetMapping("/myPage/myLog")
	public String myLogPage(HttpSession session,Model model) {
		MemberVO user = 
				(MemberVO)session.getAttribute("user");
		//회원정보
		MemberVO member = 
				memberService.selectMember(user.getMem_num());
		log.debug("<<MY페이지>> : " + member);

		model.addAttribute("member", member);

		return "myLog";
	}
	/*==============================
	 * MY페이지 (내가 쓴 글 )
	 *==============================*/	
	//자유게시판
	@GetMapping("/myPage/myWrite")
	public String myWritePage(@RequestParam(defaultValue="1") int pageNum,
			@RequestParam(defaultValue="1") int order,
			@RequestParam(defaultValue="1")String boa_category,
			String keyfield,String keyword,HttpSession session,Model model) {

		MemberVO user = 
				(MemberVO)session.getAttribute("user");
		//회원정보
		MemberVO member = 
				memberService.selectMember(user.getMem_num());
		log.debug("<<MY페이지>> : " + member);

		Map<String,Object> map = new HashMap<String,Object>();
		map.put("boa_category", boa_category);
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		int count = boardService.selectRowCount(map);

		PagingUtil page = new PagingUtil(keyfield,keyword,pageNum,count,
				10,10,"myWrite","&boa_category="+boa_category+"&order="+order);
		model.addAttribute("page", page.getPage());
		List<BoardVO> list = null;
		if(count > 0) {
			map.put("order", order);
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());

			long mem_num = user.getMem_num();
			map.put("mem_num", mem_num);

			list = boardService.selectList(map);
		}
		model.addAttribute("count", count);
		model.addAttribute("list", list);
		model.addAttribute("page", page.getPage());
		model.addAttribute("member", member);

		return "myWrite";
	}
	//팁게시판
	@GetMapping("/myPage/myWrite2")
	public String myWritePage2(@RequestParam(defaultValue="1") int pageNum,
			@RequestParam(defaultValue="1") int order,
			@RequestParam(defaultValue="2")String boa_category,
			String keyfield,String keyword,HttpSession session,Model model) {

		MemberVO user = 
				(MemberVO)session.getAttribute("user");
		//회원정보
		MemberVO member = 
				memberService.selectMember(user.getMem_num());
		log.debug("<<MY페이지>> : " + member);

		Map<String,Object> map = new HashMap<String,Object>();
		map.put("boa_category", boa_category);
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		int count = boardService.selectRowCount(map);

		PagingUtil page = new PagingUtil(keyfield,keyword,pageNum,count,
				10,10,"myWrite","&boa_category="+boa_category+"&order="+order);
		model.addAttribute("page", page.getPage());
		List<BoardVO> list = null;
		if(count > 0) {
			map.put("order", order);
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());

			long mem_num = user.getMem_num();
			map.put("mem_num", mem_num);

			list = boardService.selectList(map);
		}
		model.addAttribute("count", count);
		model.addAttribute("list", list);
		model.addAttribute("page", page.getPage());
		model.addAttribute("member", member);

		return "myWrite2";
	}
	//후기게시판
	@GetMapping("/myPage/myWrite3")
	public String myWritePage3(@RequestParam(defaultValue="1") int pageNum,
			@RequestParam(defaultValue="1") int order,
			@RequestParam(defaultValue="3")String boa_category,
			String keyfield,String keyword,HttpSession session,Model model) {

		MemberVO user = 
				(MemberVO)session.getAttribute("user");
		//회원정보
		MemberVO member = 
				memberService.selectMember(user.getMem_num());
		log.debug("<<MY페이지>> : " + member);

		Map<String,Object> map = new HashMap<String,Object>();
		map.put("boa_category", boa_category);
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		int count = boardService.selectRowCount(map);

		PagingUtil page = new PagingUtil(keyfield,keyword,pageNum,count,
				10,10,"myWrite","&boa_category="+boa_category+"&order="+order);
		model.addAttribute("page", page.getPage());
		List<BoardVO> list = null;
		if(count > 0) {
			map.put("order", order);
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());

			long mem_num = user.getMem_num();
			map.put("mem_num", mem_num);

			list = boardService.selectList(map);
		}
		model.addAttribute("count", count);
		model.addAttribute("list", list);
		model.addAttribute("page", page.getPage());
		model.addAttribute("member", member);

		return "myWrite3";
	}
	/*==============================
	 * MY페이지 (내 주문)
	 *==============================*/	
	@GetMapping("/myPage/myPoint")
	public String myPointPage(HttpSession session,Model model) {
		MemberVO user = 
				(MemberVO)session.getAttribute("user");
		//회원정보
		MemberVO member = 
				memberService.selectMember(user.getMem_num());
		log.debug("<<MY페이지>> : " + member);

		model.addAttribute("member", member);

		return "myPoint";
	}
	/*==============================
	 * MY페이지 (내 Qna)
	 *==============================*/	
	@GetMapping("/myPage/myQna")
	public String myQnaPage(@RequestParam(defaultValue="1") int pageNum,
			@RequestParam(defaultValue="1") int order,
			@RequestParam(defaultValue="5") String boa_category,
			String keyfield,String keyword,HttpSession session,Model model) {
		MemberVO user = 
				(MemberVO)session.getAttribute("user");
		//회원정보
		MemberVO member = 
				memberService.selectMember(user.getMem_num());
		log.debug("<<MY페이지>> : " + member);
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("boa_category", boa_category);
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);

		int count = boardService.selectRowCount(map);

		PagingUtil page = new PagingUtil(keyfield,keyword,pageNum,count,
				10,10,"list","&boa_category="+boa_category+"&order="+order);
		List<BoardVO> list = null;
		if(count > 0) {
			map.put("order", order);
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());

			long mem_num = user.getMem_num();
			map.put("mem_num", mem_num);

			list = boardService.selectList(map);
		}

		model.addAttribute("count", count);
		model.addAttribute("list", list);
		model.addAttribute("page", page.getPage());
		model.addAttribute("member", member);

		return "myQna";
	}
}
