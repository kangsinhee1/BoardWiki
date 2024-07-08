package kr.spring.board.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;

import kr.spring.board.service.BoardService;
import kr.spring.board.vo.BoardVO;
import kr.spring.util.PagingUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class BoardController {
	@Autowired
	private BoardService boardService;
	
	//자바빈(VO) 초기화
	@ModelAttribute
	public BoardVO initCommand() {
		return new BoardVO();
	}
	
	
	/*====================
	 *  게시판 목록
	 *====================*/
	@GetMapping("/board/list")
	public String getList(
				@RequestParam(defaultValue="1") int pageNum,
				@RequestParam(defaultValue="1") int order,
				@RequestParam(defaultValue="") String category,
				String keyfield,String keyword,Model model) {
		
		log.debug("<<게시판 목록 - category>> : " + category);
		log.debug("<<게시판 목록 - order>> : " + order);
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("category", category);
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		//전체,검색 레코드 수
		int count = boardService.selectRowCount(map);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(keyfield,keyword,pageNum,count,
							10,10,"list","&category="+category+"&order="+order);
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
			
		return "boardList";
	}
	
}



















