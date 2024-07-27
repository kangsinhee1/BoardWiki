package kr.spring.used.controller;

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
import kr.spring.used.service.UsedService;
import kr.spring.used.vo.UsedItemVO;
import kr.spring.usedChat.service.UsedChatService;
import kr.spring.util.FileUtil;
import kr.spring.util.PagingUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class UsedController {
	@Autowired
	UsedService usedService;
	@Autowired
	UsedChatService usedChatService;
	//자바빈(VO) 초기화
	@ModelAttribute
	public UsedItemVO initCommand() {
		return new UsedItemVO();
	}
	/*=====================
	 * 중고게시판 목록
	 *=====================*/
	@GetMapping("/*/usedList")
	public String selectList(
			 @RequestParam(defaultValue="1") int pageNum,
			 @RequestParam(defaultValue="1") int order,
			 Long item_num,
			 String keyfield,String keyword,Model model) {
		log.debug("<<item_num>> : " + item_num);


		if(item_num ==null) {
			if(keyword != null) { keyword = keyword.toLowerCase(); }

			Map<String,Object> map = new HashMap<>();
			map.put("keyfield", keyfield);
			map.put("keyword", keyword);

			int count = usedService.getUsedRowCountForClient(map);

			//페이지 처리
			PagingUtil page = new PagingUtil(keyfield, keyword, pageNum,count,10,10,"usedList","&order="+order);
			List<UsedItemVO> list = null;
			if(count >0) {
				map.put("order", order);
				map.put("start",page.getStartRow());
				map.put("end",page.getEndRow());
				list = usedService.selectUsedListForClient(map);
			}

			model.addAttribute("count",count);
			model.addAttribute("list",list);
			model.addAttribute("page",page.getPage());
			return "usedList";

		}else {
			Map<String,Object> map = new HashMap<>();
			map.put("keyfield", keyfield);
			map.put("keyword", keyword);
			map.put("item_num", item_num);

			int count = usedService.getUsedRowCountByItemNum(map);

			//페이지 처리
			PagingUtil page = new PagingUtil(keyfield, keyword, pageNum,count,10,10,"usedList","&order="+order);
			List<UsedItemVO> list = null;
			if(count >0) {
				map.put("order", order);
				map.put("start",page.getStartRow());
				map.put("end",page.getEndRow());
				list = usedService.selectUsedListByItemNum(map);
			}

			model.addAttribute("count",count);
			model.addAttribute("list",list);
			model.addAttribute("page",page.getPage());

			return "usedList";
		}
	}
	/*=====================
	 * 중고 게시판 작성
	 *=====================*/
	@GetMapping("/used/usedWrite")
	public String insertUsed(HttpServletRequest request,
							 HttpSession session,
							 Model model) {
		MemberVO member =(MemberVO)session.getAttribute("user");
		if(member== null) {
			model.addAttribute("message", "로그인후 작성 가능합니다.");
			model.addAttribute("url",
			request.getContextPath()+"/used/usedList");
			return "common/resultAlert";

		}
		model.addAttribute("member", member);
		return "usedWrite";
	}
	@PostMapping("/used/usedWrite")
	public String submitUsed(@Valid UsedItemVO usedVO,
								BindingResult result,
								HttpServletRequest request,
								HttpSession session,
								Model model) throws IllegalStateException, IOException {
		log.debug("<<중고게시판 글 작성>> : " + usedVO);
		//유효성 체크 결과 오류가 있으면 폼 호출
		if(result.hasErrors()) {
			for(FieldError f : result.getFieldErrors()) {
				log.debug("에러 필드 : " + f.getField());
			}
			log.debug("안됨");
			return insertUsed(request, session, model);
		}
		//회원번호 세팅
		MemberVO member = (MemberVO)session.getAttribute("user");

		usedVO.setMem_num(member.getMem_num());
		usedVO.setMem_nickname(member.getMem_nickName());
		usedVO.setMem_email(member.getMem_email());
		usedVO.setUse_photo(FileUtil.createFile(request, usedVO.getUse_upload()));
		//모임글쓰기
		usedService.insertUsed(usedVO);
		//View 메시지 처리
		model.addAttribute("message", "성공적으로 글이 등록되었습니다.");
		model.addAttribute("url", request.getContextPath()+"/used/usedList");

		return "common/resultAlert";
	}
	/*=====================
	 * 중고 게시판 상세보기
	 *=====================*/
	@GetMapping("/used/usedDetail")
	public ModelAndView process(long use_num) {
		log.debug("<<게시판 글 상세 - use_num>> : " + use_num);
		UsedItemVO used = usedService.selectUsed(use_num);
		log.debug("게시판 작성자 누구야~  " + used);
		if(usedChatService.selectAvgGrade(used.getMem_num())==null) {
			used.setUseC_grade(-1L);
		}else {
			used.setUseC_grade(usedChatService.selectAvgGrade(used.getMem_num()));
		}
		return new ModelAndView("usedView","used",used);
	}
	/*====================
	 *  게시판 글 수정
	 *====================*/
	@GetMapping("/used/usedUpdate")
	public String formUpdate(long use_num,HttpServletRequest request,HttpSession session, Model model) {
		MemberVO member = (MemberVO)session.getAttribute("user");


		UsedItemVO used = usedService.selectUsed(use_num);
		// 작성자 일치여부 확인
				if(member.getMem_num()!= used.getMem_num()) {
					model.addAttribute("message", "작성자만 수정가능합니다.");
					model.addAttribute("url", request.getContextPath()+"/team/teamList");
					return "common/resultAlert";
				}

				log.debug("<<게시판 글 수정>> : " +  used);
		model.addAttribute("used",used);
		return "usedModify";
	}
	@PostMapping("/used/usedUpdate")
	public String submitUpdate(@Valid UsedItemVO usedVO,
							   BindingResult result,
							   Model model,
							   HttpServletRequest request) throws IllegalStateException, IOException {
		log.debug("<<게시판 글 수정>> : " +  usedVO);

		if(result.hasErrors()) {
			UsedItemVO vo = usedService.selectUsed(usedVO.getUse_num());
			usedVO.setUse_photo(vo.getUse_photo());
			return "usedModify";
		}

		UsedItemVO db_board = usedService.selectUsed( usedVO.getUse_num());
		usedVO.setUse_photo(FileUtil.createFile(request, usedVO.getUse_upload()));

		usedService.updateUsed(usedVO);

		if(usedVO.getUse_upload() != null && !usedVO.getUse_upload().isEmpty()) {
			FileUtil.removeFile(request, db_board.getUse_photo());
		}

		model.addAttribute("message", "글 수정 완료!!");
		model.addAttribute("url", request.getContextPath() + "/used/usedDetail?use_num="
														+usedVO.getUse_num());


		return "common/resultAlert";
	}
	/*====================
	 *  게시판 글 삭제
	 *====================*/
	@GetMapping("/used/usedDelete")
	public String submitDelete(long use_num,
							   HttpServletRequest request) {
		log.debug("<<게시판 글 삭제 -- used_num>> : " + use_num);

		Map<String,Object> map = new HashMap<>();
		map.put("use_num", use_num);

		UsedItemVO db_board = usedService.selectUsed(use_num);

		usedService.deleteUsed(map);

		if(db_board.getUse_photo()!=null) {
			FileUtil.removeFile(request, db_board.getUse_photo());
		}

		return "redirect:/used/usedList";
	}
}
