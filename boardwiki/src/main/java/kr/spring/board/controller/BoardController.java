package kr.spring.board.controller;

import java.io.IOException;
import java.net.http.HttpClient.Redirect;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.server.reactive.ContextPathCompositeHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.board.service.BoardService;
import kr.spring.board.vo.BoardVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.util.FileUtil;
import kr.spring.util.PagingUtil;
import kr.spring.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class BoardController {
	@Autowired
	private BoardService boardService;
	
	@ModelAttribute
	public BoardVO initCommand() {
		return new BoardVO();
	}
	/*====================
	 *  게시판 글쓰기 category 1,2,3
	 *====================*/
	@GetMapping("/board/write")
	public String form() {
		return "boardWrite";
	}
	//등록 폼에서 전송된 데이터 처리
	@PostMapping("/board/write")
	public String submit(@Valid BoardVO boardVO,
			             BindingResult result,
			             HttpServletRequest request,
			             HttpSession session,
			             Model model)
	                      throws IllegalStateException,
	                                 IOException{
		log.debug("<<게시판 글 저장>> : " + boardVO);
		//유효성 체크 결과 오류가 있으면 폼 호출
		if(result.hasErrors()) {
			return form();
		}
		
		//회원번호 셋팅
		MemberVO vo = (MemberVO)session.getAttribute("user");
		boardVO.setMem_num(vo.getMem_num());
		//파일 업로드
		boardVO.setFilename(FileUtil.createFile(request, 
				                      boardVO.getUpload()));
		//글쓰기
		boardService.insertBoard(boardVO);
		
		model.addAttribute("message","성공적으로 글이 등록되었습니다");
		model.addAttribute("url","/board/list?boa_category=" + boardVO.getBoa_category());
		return "common/resultAlert";
	}
	/*====================
	 *  게시판 글쓰기 catergory 4,5
	 *====================*/
	@GetMapping("/board/write2")
	public String form2() {
		return "boardWrite2";
	}
	//등록 폼에서 전송된 데이터 처리
	@PostMapping("/board/write2")
	public String submit2(@Valid BoardVO boardVO,
			             BindingResult result,
			             HttpServletRequest request,
			             HttpSession session,
			             Model model)
	                      throws IllegalStateException,
	                                 IOException{
		log.debug("<<게시판 글 저장>> : " + boardVO);
		//유효성 체크 결과 오류가 있으면 폼 호출
		if(result.hasErrors()) {
			return form2();
		}
		
		//회원번호 셋팅
		MemberVO vo = (MemberVO)session.getAttribute("user");
		boardVO.setMem_num(vo.getMem_num());
		//파일 업로드
		boardVO.setFilename(FileUtil.createFile(request, 
				                      boardVO.getUpload()));
		//글쓰기
		boardService.insertBoard(boardVO);
		
		model.addAttribute("message","성공적으로 글이 등록되었습니다");
		model.addAttribute("url","/board/list2?boa_category=" + boardVO.getBoa_category());
		return "common/resultAlert";
	}

	
	/*====================
	 *  게시판 목록 category 1,2,3
	 *====================*/
	@GetMapping("/board/list")
	public String getList(
				@RequestParam(defaultValue="1") int pageNum,
				@RequestParam(defaultValue="1") int order,
				@RequestParam(defaultValue="") String boa_category,
				String keyfield,String keyword,Model model) {
		
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
			
			list = boardService.selectList(map);
		}
		
		model.addAttribute("count", count);
		model.addAttribute("list", list);
		model.addAttribute("page", page.getPage());
			
		return "boardList";
	}
	
	/*====================
	 *  게시판 목록 category 4,5
	 *====================*/
	@GetMapping("/board/list2")
	public String getList2(
				@RequestParam(defaultValue="1") int pageNum,
				@RequestParam(defaultValue="1") int order,
				@RequestParam(defaultValue="") String boa_category,
				String keyfield,String keyword,Model model) {
		
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
			
			list = boardService.selectList(map);
		}
		
		model.addAttribute("count", count);
		model.addAttribute("list", list);
		model.addAttribute("page", page.getPage());
			
		return "boardList2";
	}
	/*====================
	 *  게시판 글상세 category 1,2,3
	 *====================*/
	@GetMapping("/board/detail")
	public ModelAndView process(long boa_num) {
		log.debug("<<게시판 글 상세 - boa_num>> : " + boa_num);
		
		boardService.updateHit(boa_num);
		
		BoardVO board = boardService.selectBoard(boa_num);
		
		return new ModelAndView("boardView","board",board);
	}
	/*====================
	 *  게시판 글상세 category 4,5
	 *====================*/
	@GetMapping("/board/detail2")
	public ModelAndView process2(long boa_num) {
		log.debug("<<게시판 글 상세 - boa_num>> : " + boa_num);
		
		boardService.updateHit(boa_num);
		
		BoardVO board = boardService.selectBoard(boa_num);
		
		return new ModelAndView("boardView2","board",board);
	}
	//파일 다운로드
	@GetMapping("/board/file")
	public String download(long boa_num,HttpServletRequest request, Model model) {
		BoardVO board = boardService.selectBoard(boa_num);
		byte[] downloadFile = 
				FileUtil.getBytes(request.getServletContext().getRealPath(
											"/upload")+"/"+board.getFilename());
		
		model.addAttribute("downloadFile", downloadFile);
		model.addAttribute("filename", board.getFilename());
		
		return "downloadView";
	}
	/*====================
	 *  게시판 글 수정 category1,2,3
	 *====================*/
	@GetMapping("/board/update")
	public String formUpdate(long boa_num,Model model) {
		BoardVO boardVO = boardService.selectBoard(boa_num);
		model.addAttribute("boardVO", boardVO);
		
		return "boardModify";
	}
	@PostMapping("/board/update")
	public String submitUpdate(@Valid BoardVO boardVO,
							   BindingResult result,
							   Model model,
							   HttpServletRequest request) throws IllegalStateException, IOException {
		log.debug("<<게시판 글 수정>> : " +  boardVO);
		
		if(result.hasErrors()) {
			BoardVO vo = boardService.selectBoard(boardVO.getBoa_num());
			boardVO.setFilename(vo.getFilename());
			return "boardModify";
		}
		
		BoardVO db_board = boardService.selectBoard( boardVO.getBoa_num());
		boardVO.setFilename(FileUtil.createFile(request, boardVO.getUpload()));
		
		boardService.updateBoard(boardVO);
		
		if(boardVO.getUpload() != null && !boardVO.getUpload().isEmpty()) {
			FileUtil.removeFile(request, db_board.getFilename());
		}
		
		model.addAttribute("message", "글 수정 완료!!");
		model.addAttribute("url","/board/list?boa_category=" + boardVO.getBoa_category());
		
		
		return "common/resultAlert";
	}
	
	/*====================
	 *  게시판 글 수정 category4,5
	 *====================*/
	@GetMapping("/board/update2")
	public String formUpdate2(long boa_num,Model model) {
		BoardVO boardVO = boardService.selectBoard(boa_num);
		model.addAttribute("boardVO", boardVO);
		
		return "boardModify2";
	}
	@PostMapping("/board/update2")
	public String submitUpdate2(@Valid BoardVO boardVO,
							   BindingResult result,
							   Model model,
							   HttpServletRequest request) throws IllegalStateException, IOException {
		log.debug("<<게시판 글 수정>> : " +  boardVO);
		
		if(result.hasErrors()) {
			BoardVO vo = boardService.selectBoard(boardVO.getBoa_num());
			boardVO.setFilename(vo.getFilename());
			return "boardModify2";
		}
		
		BoardVO db_board = boardService.selectBoard( boardVO.getBoa_num());
		boardVO.setFilename(FileUtil.createFile(request, boardVO.getUpload()));
		
		boardService.updateBoard(boardVO);
		
		if(boardVO.getUpload() != null && !boardVO.getUpload().isEmpty()) {
			FileUtil.removeFile(request, db_board.getFilename());
		}
		
		model.addAttribute("message", "글 수정 완료!!");
		model.addAttribute("url","/board/list2?boa_category=" + boardVO.getBoa_category());
		
		return "common/resultAlert";
	}
	/*====================
	 *  게시판 글 삭제
	 *====================*/
	@GetMapping("/board/delete") 
	public String submitDelete(long boa_num, 
							   HttpServletRequest request) {
		log.debug("<<게시판 글 삭제 -- boa_num>> : " + boa_num);
		
		BoardVO db_board = boardService.selectBoard(boa_num);
		
		boardService.deleteBoard(boa_num);
		
		if(db_board.getFilename()!=null) {
			FileUtil.removeFile(request, db_board.getFilename());
		}
		
		return "redirect:/board/list";
	}
}



















