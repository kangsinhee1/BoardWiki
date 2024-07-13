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
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

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
	@GetMapping("/rulebook/rulebookWrite")
	public String insertrulebook(HttpServletRequest request,
			 HttpSession session,
			 Model model) {
		MemberVO member =(MemberVO)session.getAttribute("user");
		if(member== null) {
			model.addAttribute("message", "로그인후 작성 가능합니다.");
			model.addAttribute("url", 
			request.getContextPath()+"/rulebook/rulebookList");
			return "common/resultAlert";
			
		}
		model.addAttribute("member", member);
		return "rulebookWrite";
	}
	@PostMapping("/rulebook/rulebookWrite")
	public String submitrulebook(@Valid RulebookVO rulebookVO,
						  BindingResult result,
						  HttpServletRequest request,
						  HttpSession session,
						  Model model) 
							throws IllegalStateException,
										IOException{
		log.debug("<<게시판 글 저장>> : " + rulebookVO);
		
		if(result.hasErrors()) {
			for(FieldError f : result.getFieldErrors()) {
				log.debug("에러 필드 : " + f.getField());
			}
			log.debug("안됨");
			return insertrulebook(request, session, model);
		}
		
		MemberVO vo = (MemberVO)session.getAttribute("user");
		rulebookVO.setMem_num(vo.getMem_num());
		
		rulebookVO.setFilename(FileUtil.createFile(request, rulebookVO.getUpload()));
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
	/*====================
	 *  룰북 상세
	 *====================*/
	@GetMapping("/rulebook/rulebookDetail")
	public ModelAndView process(long rulB_num) {
		
		RulebookVO rulebook = rulebookService.selectRulebook(rulB_num);
		
		return new ModelAndView("rulebookView","rulebook",rulebook);
	}
	//파일 다운로드
	@GetMapping("/rulebook/file")
	public String download(long rulB_num,HttpServletRequest request, Model model) {
		RulebookVO rulebook = rulebookService.selectRulebook(rulB_num);
		byte[] downloadFile = 
				FileUtil.getBytes(request.getServletContext().getRealPath(
											"/upload")+"/"+rulebook.getFilename());
		
		model.addAttribute("downloadFile", downloadFile);
		model.addAttribute("filename", rulebook.getFilename());
		
		return "downloadView";
	}
}
