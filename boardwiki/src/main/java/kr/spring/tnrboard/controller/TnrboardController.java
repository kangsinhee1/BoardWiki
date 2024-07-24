package kr.spring.tnrboard.controller;

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

import kr.spring.member.vo.MemberVO;
import kr.spring.tnrboard.service.TnrboardService;
import kr.spring.tnrboard.vo.TnrboardVO;
import kr.spring.util.FileUtil;
import kr.spring.util.PagingUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class TnrboardController {
	@Autowired
	private TnrboardService tnrboardService;

	@ModelAttribute
	public TnrboardVO initCommand() {
		return new TnrboardVO();
	}
	/*====================
	 *  게시판 글쓰기 category 1,2
	 *====================*/
	@GetMapping("/tnrboard/tnrwrite")
	public String insertTnrBoard(HttpServletRequest request,
			 HttpSession session,
			 Model model) {
		MemberVO member =(MemberVO)session.getAttribute("user");
		if(member== null) {
			model.addAttribute("message", "로그인후 작성 가능합니다.");
			model.addAttribute("url",
			request.getContextPath()+"/tnrboard/tnrboardList");
			return "common/resultAlert";

		}
		model.addAttribute("member", member);
		return "tnrboardWrite";
	}
	//등록 폼에서 전송된 데이터 처리
	@PostMapping("/tnrboard/tnrwrite")
	public String submittnrboard(@Valid TnrboardVO tnrboardVO,
			             BindingResult result,
			             HttpServletRequest request,
			             HttpSession session,
			             Model model)
	                      throws IllegalStateException,
	                                 IOException{
		log.debug("<<게시판 글 저장>> : " + tnrboardVO);
		//유효성 체크 결과 오류가 있으면 폼 호출
		if(result.hasErrors()) {
			for(FieldError f : result.getFieldErrors()) {
				log.debug("에러 필드 : " + f.getField());
			}
			log.debug("안됨");
			return insertTnrBoard(request, session, model);
		}

		//회원번호 셋팅
		MemberVO vo = (MemberVO)session.getAttribute("user");
		tnrboardVO.setMem_num(vo.getMem_num());
		//파일 업로드
		tnrboardVO.setFilename(FileUtil.createFile(request, tnrboardVO.getUpload()));
		//글쓰기
		tnrboardService.insertTnrBoard(tnrboardVO);

		model.addAttribute("message","성공적으로 글이 등록되었습니다");
		model.addAttribute("url","/tnrboard/tnrboardList?tnr_category=" + tnrboardVO.getTnr_category());
		return "common/resultAlert";
	}

	/*====================
	 *  게시판 목록 category 1,2
	 *====================*/
	@GetMapping("/tnrboard/tnrboardList")
	public String getList(
				@RequestParam(defaultValue="1") int pageNum,
				@RequestParam(defaultValue="1") int order,
				@RequestParam(defaultValue="") String tnr_category, Long item_num,
				String keyfield,String keyword,Model model) {

		Map<String,Object> map = new HashMap<>();
		map.put("tnr_category", tnr_category);
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);

		int count = tnrboardService.selectTnrRowCount(map);

		PagingUtil page = new PagingUtil(keyfield,keyword,pageNum,count,
							10,10,"tnrboardList","&tnr_category="+tnr_category+"&order="+order);
		List<TnrboardVO> list = null;
		if(count > 0) {
			map.put("order", order);
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());

			list = tnrboardService.selectTnrList(map);
		}

		model.addAttribute("count", count);
		model.addAttribute("list", list);
		model.addAttribute("page", page.getPage());

		return "tnrboardList";
	}


	/*====================
	 *  게시판 글상세 category 1,2
	 *====================*/
	@GetMapping("/tnrboard/tnrboardDetail")
	public ModelAndView process(long tnr_num) {
		log.debug("<<게시판 글 상세 - tnr_num>> : " + tnr_num);

		tnrboardService.updateTnrHit(tnr_num);

		TnrboardVO tnrboard = tnrboardService.selectTnrBoard(tnr_num);

		return new ModelAndView("tnrboardView","tnrboard",tnrboard);
	}

	//파일 다운로드
	@GetMapping("/tnrboard/file")
	public String download(long tnr_num,HttpServletRequest request, Model model) {
		TnrboardVO tnrboard = tnrboardService.selectTnrBoard(tnr_num);
		byte[] downloadFile =
				FileUtil.getBytes(request.getServletContext().getRealPath(
											"/upload")+"/"+tnrboard.getFilename());

		model.addAttribute("downloadFile", downloadFile);
		model.addAttribute("filename", tnrboard.getFilename());

		return "downloadView";
	}
	/*====================
	 *  게시판 글 수정 category1,2
	 *====================*/
	@GetMapping("/tnrboard/tnrboardUpdate")
	public String formUpdate(long tnr_num,Model model) {
		TnrboardVO tnrboardVO = tnrboardService.selectTnrBoard(tnr_num);
		model.addAttribute("tnrboardVO", tnrboardVO);

		return "tnrboardModify";
	}
	@PostMapping("/tnrboard/tnrboardUpdate")
	public String submitUpdate(@Valid TnrboardVO tnrboardVO,
							   BindingResult result,
							   Model model,
							   HttpServletRequest request) throws IllegalStateException, IOException {
		log.debug("<<게시판 글 수정>> : " +  tnrboardVO);

		if(result.hasErrors()) {
			TnrboardVO vo = tnrboardService.selectTnrBoard(tnrboardVO.getTnr_num());
			tnrboardVO.setFilename(vo.getFilename());
			return "tnrboardModify";
		}

		TnrboardVO db_board = tnrboardService.selectTnrBoard(tnrboardVO.getTnr_num());
		tnrboardVO.setFilename(FileUtil.createFile(request, tnrboardVO.getUpload()));

		tnrboardService.updateTnrBoard(tnrboardVO);

		if(tnrboardVO.getUpload() != null && !tnrboardVO.getUpload().isEmpty()) {
			FileUtil.removeFile(request, db_board.getFilename());
		}

		model.addAttribute("message", "글 수정 완료!!");
		model.addAttribute("url","/tnrboard/tnrboardList?tnr_category=" + tnrboardVO.getTnr_category());


		return "common/resultAlert";
	}


	/*====================
	 *  게시판 글 삭제
	 *====================*/
	@GetMapping("/tnrboard/tnrboardDelete")
	public String submitDelete(@Valid TnrboardVO tnrboardVO,
							   long tnr_num,
							   Model model,
							   HttpServletRequest request) {
		log.debug("<<게시판 글 삭제 -- tnr_num>> : " + tnr_num);

		TnrboardVO db_board = tnrboardService.selectTnrBoard(tnr_num);

		tnrboardService.deleteTnrBoard(tnr_num);

		if(db_board.getFilename()!=null) {
			FileUtil.removeFile(request, db_board.getFilename());
		}

		model.addAttribute("message", "글 삭제 완료!!");
		model.addAttribute("url","/tnrboard/tnrboardList?tnr_category=" + tnrboardVO.getTnr_category());

		return "common/resultAlert";
	}
}



















