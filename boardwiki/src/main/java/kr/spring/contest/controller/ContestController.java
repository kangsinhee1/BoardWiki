package kr.spring.contest.controller;

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

import kr.spring.board.controller.BoardController;
import kr.spring.board.vo.BoardVO;
import kr.spring.contest.service.ContestService;
import kr.spring.contest.vo.ContestVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.team.vo.TeamVO;
import kr.spring.util.FileUtil;
import kr.spring.util.PagingUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ContestController {
	@Autowired
	ContestService contestservice;

	@ModelAttribute
	public ContestVO initCommand() {
		return new ContestVO();
	}

	/*=====================
	 * 게시판 글쓰기
	 *=====================*/
	//등록 폼 호출
	@GetMapping("/contest/contestWrite")
	public String writeform() {
		return "contestWrite";
	}
	//등록 폼에서 전송된 데이터 처리
	@PostMapping("/contest/contestWrite")
	public String writesubmit(@Valid ContestVO contestVO,
			BindingResult result,
			HttpServletRequest request,
			HttpSession session,
			Model model)
					throws IllegalStateException,
					IOException{
		log.debug("<<게시판 글 저장>> : " + contestVO);
		
		//유효성 체크 결과 오류가 있으면 폼 호출
				if(result.hasErrors()) {
					return writeform();
				}

		//회원번호 셋팅
		MemberVO member = (MemberVO)session.getAttribute("user");
		contestVO.setMem_num(member.getMem_num());
		
		if(member == null || member.getMem_auth() < 9 ) {
			model.addAttribute("message", "잘못된 접근입니다.");
			model.addAttribute("url", 
					request.getContextPath()+"/main/main");

			return "common/resultAlert";
		}
		//글쓰기
		contestservice.insertContest(contestVO);

		//View 메시지 처리
		model.addAttribute("message", "성공적으로 글이 등록되었습니다.");
		model.addAttribute("url", 
				request.getContextPath()+"/board/list");

		return "common/resultAlert";
	}

	/*=====================
	 * 		대회 목록
	 *=====================*/
	@GetMapping("/contest/contestList")
	public String getList(
			@RequestParam(defaultValue="1") int pageNum,
			@RequestParam(defaultValue="1") int order,
			@RequestParam(defaultValue="") String category,
			String keyfield,String keyword,Model model) {

		log.debug("<<게시판 목록 - category>> : " + category);
		log.debug("<<게시판 목록 - order>> : " + order);

		Map<String,Object> map = 
				new HashMap<String,Object>();
		map.put("category", category);
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);

		//전체,검색 레코드수
		int count = contestservice.selectRowCount(map);

		//페이지 처리
		PagingUtil page = 
				new PagingUtil(keyfield,keyword,pageNum,
						count,20,10,"list",
						"&category="+category+"&order="+order);
		List<ContestVO> list = null;
		if(count > 0) {
			map.put("order", order);
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());

			list = contestservice.selectContestList(map);
		}

		model.addAttribute("count", count);
		model.addAttribute("list", list);
		model.addAttribute("page", page.getPage());

		return "contestList";
	}
}
