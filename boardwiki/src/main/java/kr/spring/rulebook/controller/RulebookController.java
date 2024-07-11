package kr.spring.rulebook.controller;

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

import kr.spring.board.vo.BoardVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.rulebook.service.RulebookService;
import kr.spring.rulebook.vo.RulebookVO;
import kr.spring.util.FileUtil;
import kr.spring.util.PagingUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class RulebookController {
	@Autowired
	private RulebookService rulebookService;
	
	@ModelAttribute
	public RulebookVO initCommand() {
		return new RulebookVO();
	}
	/*====================
	 *  룰북 글쓰기
	 *====================*/
	@GetMapping("/rulebook/write")
	public String form() {
		return "rulebookWrite";
	}
	@PostMapping("/rulebook/write")
	public String submit(@Valid RulebookVO rulebookVO,
						  BindingResult result,
						  HttpServletRequest request,
						  HttpSession session,
						  Model model) 
							throws IllegalStateException,
										IOException{
		log.debug("<<게시판 글 저장>> : " + rulebookVO);
		
		if(result.hasErrors()) {
			return form();
		}
		
		MemberVO vo = (MemberVO)session.getAttribute("user");
		rulebookVO.setMem_num(vo.getMem_num());
		
		rulebookVO.setRulB_filename(FileUtil.createFile(request, rulebookVO.getRulB_upload()));
		rulebookService.insertRulebook(rulebookVO);
		
		model.addAttribute("message","성공적으로 글이 등록되었습니다.");
		model.addAttribute("url",request.getContextPath()+"/rulebook/rulebookList");
		
		
		return "common/resultAlert";
	}
	/*====================
	 *  룰북 목록
	 *====================*/
	@GetMapping("/rulebook/rulebookList")
	public String getList(
				@RequestParam(defaultValue="1") int pageNum,
				String keyfield,String keyword,Model model) {
		
		
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		int count = rulebookService.selectRulebookRowCount(map);
		
		PagingUtil page = new PagingUtil(keyfield,keyword,pageNum,count,
							10,10,"list");
		List<RulebookVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = rulebookService.selectRulebookList(map);
		}
		
		model.addAttribute("count", count);
		model.addAttribute("list", list);
		model.addAttribute("page", page.getPage());
			
		return "rulebookList";
	}
}
