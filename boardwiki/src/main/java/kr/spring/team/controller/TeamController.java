package kr.spring.team.controller;

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
import org.springframework.web.servlet.ModelAndView;

import kr.spring.board.vo.BoardVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.team.controller.TeamController;
import kr.spring.team.service.TeamService;
import kr.spring.team.vo.TeamApplyVO;
import kr.spring.team.vo.TeamBoardVO;
import kr.spring.team.vo.TeamVO;
import kr.spring.util.FileUtil;
import kr.spring.util.PagingUtil;
import kr.spring.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class TeamController {
	@Autowired
	private TeamService teamService;

	//자바빈(VO) 초기화
	@ModelAttribute
	public TeamVO initCommand() {
		return new TeamVO();
	}
	//자바빈(VO) 초기화
	@ModelAttribute
	public TeamApplyVO initCommandTeamApply() {
		return new TeamApplyVO();
	}
	@ModelAttribute
	public TeamBoardVO initCommandTeamBoard() {
		return new TeamBoardVO();
	}

	/*=====================
	 * 모임게시판 목록
	 *=====================*/
	@GetMapping("/team/teamList")
	public String selectList(
			@RequestParam(defaultValue="1") int pageNum,
			@RequestParam(defaultValue="1") int order,
			String keyfield,String keyword,Model model) {

		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		

		int count = teamService.getTeamRowCount(map);

		//페이지 처리
		PagingUtil page = new PagingUtil(keyfield, keyword, pageNum,count,20,10,"teamList","&order="+order);
		List<TeamVO> list = null;
		if(count >0) {
			map.put("order", order);
			map.put("start",page.getStartRow());
			map.put("end",page.getEndRow());
			list = teamService.selectTeamList(map);

		}
		model.addAttribute("count",count);
		model.addAttribute("list",list);
		model.addAttribute("page",page.getPage());
		return "teamList";
	};
	/*=====================
	 * 모임 게시판 작성
	 *=====================*/
	@GetMapping("/team/teamWrite")
	public String insertTeam(HttpServletRequest request,
			HttpSession session,
			Model model) {
		MemberVO member =(MemberVO)session.getAttribute("user");
		if(member== null) {
			model.addAttribute("message", "로그인후 작성 가능합니다.");
			model.addAttribute("url", 
					request.getContextPath()+"/team/teamList");
			return "common/resultAlert";

		}
		return "teamWrite";
	}
	@PostMapping("/team/teamWrite")
	public String submitTeam(@Valid TeamVO teamVO,
			BindingResult result,
			HttpServletRequest request,
			HttpSession session,
			Model model) {
		log.debug("<<모임게시판 글 작성>> : " + teamVO);
		//유효성 체크 결과 오류가 있으면 폼 호출
		if(result.hasErrors()) {
			return insertTeam(request, session, model);
		}
		//회원번호 세팅
		MemberVO member = (MemberVO)session.getAttribute("user");

		teamVO.setMem_num(member.getMem_num());
		//모임글쓰기
		teamService.insertTeam(teamVO);
		//View 메시지 처리
		model.addAttribute("message", "성공적으로 글이 등록되었습니다.");
		model.addAttribute("url", 
				request.getContextPath()+"/team/teamList");
		return "common/resultAlert";
	}
	/*=====================
	 * 모임 게시판 상세
	 *=====================*/
	@GetMapping("/team/teamDetail")
	public ModelAndView teamDetail(long tea_num) {

		teamService.updateTeamHit(tea_num);

		TeamVO team =  teamService.detailTeam(tea_num);
		return new ModelAndView("teamDetail","team",team);

	}
	/*=====================
	 * 모임 게시판 수정
	 *=====================*/
	@GetMapping("/team/teamUpdate")
	public String teamUpdate(long tea_num,HttpServletRequest request,HttpSession session, Model model) {
		MemberVO member = (MemberVO)session.getAttribute("user");



		TeamVO team = teamService.detailTeam(tea_num);
		// 작성자 일치여부 확인
		if(member.getMem_num()!= team.getMem_num()) {
			model.addAttribute("message", "작성자만 수정가능합니다.");
			model.addAttribute("url", request.getContextPath()+"/team/teamList");
			return "common/resultAlert";
		}

		model.addAttribute("team",team);

		return "teamUpdate";

	}
	@PostMapping("/team/teamUpdate")
	public String submitTeamUpdate(@Valid TeamVO teamVO,
			BindingResult result,
			HttpServletRequest request,
			HttpSession session,
			Model model)  throws IllegalStateException, IOException{
		log.debug("" + teamVO);
		if(result.hasErrors()) {
			teamService.detailTeam(teamVO.getTea_num());
			return "teamUpdate";
		}

		teamService.updateTeam(teamVO);
		model.addAttribute("message","글수정 완료");
		model.addAttribute("url",request.getContextPath()+"teamDetail?tea_num="+teamVO.getTea_num());


		return "common/resultAlert";

	}

	/*=====================
	 * 모임 게시판 삭제( 실제로는 삭제가 아닌 비활성화 처리해서 보이지 않도록 처리)
	 *=====================*/
	@GetMapping("/team/teamDelete")
	public String deleteTeam(long tea_num) {
		//모임장만 비활성화 되게 처리
		teamService.updateTeamStatus(tea_num);
		return "redirect:teamList";
	}

	/*=====================
	 * 모임 신청
	 *=====================*/
	@GetMapping("/team/teamApply")
	public String applyTeam(@RequestParam long tea_num,HttpServletRequest request,HttpSession session, Model model) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		if (user==null) {
			model.addAttribute("message", "회원만 신청가능합니다.");
			model.addAttribute("url", request.getContextPath()+"/team/teamList");
			return "common/resultAlert";
		}else {
			return "teamApply";
		}

	}

	@PostMapping("/team/teamApply")
	public String submitApplyTeam(TeamApplyVO applyVO,HttpServletRequest request,HttpSession session, Model model) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		log.debug(" 팀 신청 VO :"+applyVO);
		if (user==null) {
			model.addAttribute("message", "회원만 신청가능합니다.");
			model.addAttribute("url", request.getContextPath()+"/team/teamList");
			return "common/resultAlert";
		}
		//본인이 만든 모임은 신청하지 못하도록 처리
		TeamVO team = teamService.detailTeam(applyVO.getTea_num());

		if(user.getMem_num() ==  team.getMem_num()) {
			model.addAttribute("message", "본인이 등록한 모임입니다.");
			model.addAttribute("url", request.getContextPath()+"/team/teamList");
			return "common/resultAlert";
		}
		//이전에 신청한 기록이 있으면 신청한 기록이 있다고 확인시켜주기
		applyVO.setMem_num(user.getMem_num());
		log.debug(teamService.selectTeamApplyList(applyVO)+"asdf 맞아?");
		if(teamService.selectTeamApplyList(applyVO)>0){
			model.addAttribute("message","이미 신청한 기록이 있습니다.");
			model.addAttribute("url",request.getContextPath()+"teamDetail?tea_num="+applyVO.getTea_num());
			return "common/resultAlert";
		}

		teamService.insertTeamApply(applyVO);
		model.addAttribute("message","신청  완료");
		model.addAttribute("url",request.getContextPath()+"teamDetail?tea_num="+applyVO.getTea_num());
		return "common/resultAlert";

	}
	//신청 취소
	@GetMapping("/team/deleteTeamApply")
	public String deleteTeamApply(HttpSession session,@RequestParam long teaA_num, HttpServletRequest request ,Model model ) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		if (user==null) {
			model.addAttribute("message", "회원만 신청가능합니다.");
			model.addAttribute("url", request.getContextPath()+"/team/teamList");
			return "common/resultAlert";
		}
		teamService.deleteTeamApply(teaA_num);
		return "redirect:/team/myTeam";
	}


	/*=====================
	 * 나의 모임 게시판
	 *=====================*/


	/*=====================
	 * 나의 모임 게시판 목록(가입한 모임, 등록한 모임, 신청중 모임)
	 *=====================*/

	
	@GetMapping("/team/myTeam2")
	public String getMyTeam2(Model model, HttpSession session,HttpServletRequest request) {
		Map<String,Object> map = new HashMap<String,Object>();
		Map<String,Object> map2 = new HashMap<String,Object>();
		Map<String,Object> map3= new HashMap<String,Object>();


		//본인이 가입한 모임 목록
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user==null) {
			model.addAttribute("message", "로그인 후에 가능합니다.");
			model.addAttribute("url", request.getContextPath()+"/team/teamList");
			return "common/resultAlert";

		}
		map.put("mem_num",user.getMem_num());
		map.put("teaA_status",2);
		List<TeamApplyVO> list = null;
		list = teamService.selectTeamListApplied(map);
		log.debug("모임 목록 ~~~~~~~~~~~~~~~~~~~~~"+list);
		model.addAttribute("list",list);
		//본인이 등록한 모임 목록

		map2.put("mem_num",user.getMem_num());
		map2.put("teaA_status",9); 
		List<TeamApplyVO> list2 = null; list2 = teamService.selectTeamListApplied(map2);
		model.addAttribute("list2",list2);

		// 신청한 모임 목록
		map3.put("mem_num",user.getMem_num());
		map3.put("teaA_status",1);
		List<TeamApplyVO> list3 = null;
		list3 = teamService.selectTeamListApplied(map3);
		model.addAttribute("list3",list3);

		log.debug(""+list3);
		return "myTeamprac";
	}
	//글작성 폼 호출
	@GetMapping("/team/teamBoardWrite")
	public String insertTeamBoard(HttpServletRequest request,
			HttpSession session,
			Model model) {

		long teaB_num = (long)session.getAttribute("teaB_num");
		MemberVO member =(MemberVO)session.getAttribute("user");
		if(member== null) {
			model.addAttribute("message", "로그인후 작성 가능합니다.");
			model.addAttribute("url", 
					request.getContextPath()+"/member/login");
			model.addAttribute("teaB_num",teaB_num);
			return "common/resultAlert";

		}
		return "teamBoardWrite";
	}

	//게시판글 등록(사용자/관리자 동시에 사용가능한지 확인) 안되면 따로처리
	@PostMapping("/team/teamBoardWrite")
	public String submitTeamBoard(@Valid TeamBoardVO teamBoardVO,
			BindingResult result,
			HttpServletRequest request,
			HttpSession session,
			Model model)throws IllegalStateException,IOException {
		
		log.debug("<<글 모임판 작성>> : " + teamBoardVO);
		//유효성 체크 결과 오류가 있으면 폼 호출
		if(result.hasErrors()) {
			return insertTeam(request, session, model);
		}
		//회원번호 세팅
		MemberVO member = (MemberVO)session.getAttribute("user");
		//모임 게시판 번호 불러오기
		long teaB_num = (long)session.getAttribute("teaB_num");
		

		teamBoardVO.setFilename(FileUtil.createFile(request, teamBoardVO.getUpload()));
		
		teamBoardVO.setMem_num(member.getMem_num());
		teamBoardVO.setTea_num(teaB_num);
		//모임글쓰기
	    teamService.insertTeamBoard(teamBoardVO);
		//View 메시지 처리
		model.addAttribute("message", "성공적으로 글이 등록되었습니다.");
		if(member.getMem_num() == teamService.detailTeam(teaB_num).getMem_num()) {
			model.addAttribute("url", 
					request.getContextPath()+"/team/teamBoardAdmin?tea_num="+teaB_num);
		}else {
			model.addAttribute("url", 
					request.getContextPath()+"/team/teamBoardUser?tea_num="+teaB_num);
		}
		model.addAttribute("tea_num",teaB_num);
		return "common/resultAlert";
	}
	

	//관리자 게시판
		@GetMapping("/team/teamBoardAdmin")
		public String selectTeamBoardAdmin(@RequestParam long tea_num, HttpServletRequest request,
				HttpSession session,   	
				Model model,
				@RequestParam(defaultValue="1") int pageNum,
				@RequestParam(defaultValue="1") int order,
				String keyfield,String keyword) {
			session.setAttribute("tea_num", tea_num);
			model.addAttribute("tea_num",tea_num);
			MemberVO member =(MemberVO)session.getAttribute("user");
			if(member== null) {
				model.addAttribute("message", "로그인 해야 합니다.");
				model.addAttribute("url", 
						request.getContextPath()+"/member/login");
				return "common/resultAlert";
			}
			//해당 모임의 관리자만 접속가능하게 처리
			TeamVO team1 = teamService.detailTeam(tea_num);
			if(team1.getMem_num() != member.getMem_num()) {
				model.addAttribute("message", "관리자가 아닙니다.");
				model.addAttribute("url", request.getContextPath()+"/member/login");
				return "common/resultAlert";
			}
			
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("keyfield", keyfield);
			map.put("keyword", keyword);
			map.put("tea_num", tea_num);
			int count = teamService.selectTeamBoardRowCount(map);
	
			//페이지 처리
			PagingUtil page = new PagingUtil(keyfield, keyword, pageNum,count,20,10,"teamBoardAdmin","&order="+order);
			List<TeamBoardVO> list = null;
			if(count >0) {
				map.put("order", order);
				map.put("start",page.getStartRow());
				map.put("end",page.getEndRow());
				map.put("tea_num", tea_num);
				list = teamService.selectTeamBoardList(map);
	
			}
			model.addAttribute("count",count);
			model.addAttribute("list",list);
			model.addAttribute("page",page.getPage());
			model.addAttribute("TEAM",teamService.detailTeam(tea_num));
			return "teamBoardAdmin";
		}


	//사용자 게시판
	@GetMapping("/team/teamBoardUser")
	public String selectTeamBoardUser(@RequestParam long tea_num, HttpServletRequest request,
			HttpSession session,   	
			Model model,
			@RequestParam(defaultValue="1") int pageNum,
			@RequestParam(defaultValue="1") int order,
			String keyfield,String keyword) {
		session.setAttribute("tea_num", tea_num);
		model.addAttribute("tea_num",tea_num);
		MemberVO member =(MemberVO)session.getAttribute("user");
		if(member== null) {
			model.addAttribute("message", "로그인 해야 합니다.");
			model.addAttribute("url", 
					request.getContextPath()+"/member/login");
			return "common/resultAlert";

		}
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		map.put("tea_num", tea_num);
		int count = teamService.selectTeamBoardRowCount(map);

		//페이지 처리
		PagingUtil page = new PagingUtil(keyfield, keyword, pageNum,count,20,10,"teamBoardAdmin","&order="+order);
		List<TeamBoardVO> list = null;
		if(count >0) {
			map.put("order", order);
			map.put("start",page.getStartRow());
			map.put("end",page.getEndRow());
			map.put("tea_num", tea_num);
			list = teamService.selectTeamBoardList(map);

		}
		model.addAttribute("count",count);
		model.addAttribute("list",list);
		model.addAttribute("page",page.getPage());
		model.addAttribute("TEAM",teamService.detailTeam(tea_num));
		

		return "teamBoardUser";
	}
	
	//글 상세 보기
	@GetMapping("/team/teamBoardDetail")
	public ModelAndView teamBoardDetail(long teaB_num,Model model,HttpSession session) {
		//해당 글의 조회수 증가
		teamService.updateHitTeamBoard(teaB_num);
		
		TeamBoardVO board = teamService.getTeamBoardDetail(teaB_num);
		
		//해당 모임의 관리자만 접속가능하게 처리
		TeamVO team1 = teamService.detailTeam(board.getTea_num());	
		
		MemberVO member =(MemberVO)session.getAttribute("user");
		if(team1.getMem_num() == member.getMem_num()) {
			model.addAttribute("admin",true);
		}else {
			model.addAttribute("admin",false);
		}
		board.setTeaB_title(StringUtil.useNoHTML(board.getTeaB_title()));
		return new ModelAndView("teamBoardDetail","board",board);
		
	}
	@GetMapping("/team/file")
	public String download(Long teaB_num, HttpServletRequest request, Model model) {
		TeamBoardVO board = teamService.getTeamBoardDetail(teaB_num);
		byte[] downloadFile = FileUtil.getBytes(request.getServletContext().getRealPath("/upload")+"/"+board.getFilename());
		model.addAttribute("downloadFile",downloadFile);
		model.addAttribute("filename",board.getFilename());
		return "downloadView";
	}
	//글 수정하기
	@GetMapping("/team/teamBoardUpdate")
	public String teamBoardUpdate(long teaB_num,HttpServletRequest request,HttpSession session, Model model) {
		
		//로그인 확인
		MemberVO member =(MemberVO)session.getAttribute("user");
		if(member== null) {
			model.addAttribute("message", "로그인 해야 합니다.");
			model.addAttribute("url", 
					request.getContextPath()+"/member/login");
			return "common/resultAlert";
		}
		//본인이 작성한글
		TeamBoardVO board = teamService.getTeamBoardDetail(teaB_num);
		if(member.getMem_num() != board.getMem_num()) {
			model.addAttribute("message", "본인이 작성한 글만 수정가능합니다.");
			model.addAttribute("url", 
					request.getContextPath()+"/team/teamBoardDetail?teaB_num="+teaB_num);
		}
		model.addAttribute("teamBoardVO",board);
		return "teamBoardUpdate";
	}
	
	@PostMapping("/team/teamBoardUpdate")
	public String updateTeamBoard(@Valid TeamBoardVO teamBoardVO, BindingResult result, HttpServletRequest request,HttpSession session, Model model) throws IllegalStateException, IOException {
		
		
		if(result.hasErrors()) {
			//title 또는 content가 입력되지 않아서 유효성 체크에 걸리면
			//파일 정보를 잃어버리기 때문에 폼을 호출할 때 다시 파일 정보를
			//셋팅해야 함
			TeamBoardVO vo = teamService.getTeamBoardDetail(
					teamBoardVO.getTeaB_num());
			
			teamBoardVO.setFilename(vo.getFilename());
			return "teamBoardUpdate";
		}
		
		
		//로그인 확인
		MemberVO member =(MemberVO)session.getAttribute("user");
		if(member== null) {
			model.addAttribute("message", "로그인 해야 합니다.");
			model.addAttribute("url", 
					request.getContextPath()+"/member/login");
			return "common/resultAlert";
		}
		//본인이 작성한글
		TeamBoardVO board = teamService.getTeamBoardDetail(teamBoardVO.getTeaB_num());
		log.debug(board+"asdfaksdljfg asdjgklasdj glkasdjglkjlqkjweopitqj woiej");
		if(member.getMem_num() != board.getMem_num()) {
			model.addAttribute("message", "본인이 작성한 글만 수정가능합니다.");
			model.addAttribute("url", 
					request.getContextPath()+"/team/teamBoardDetail?teaB_num="+teamBoardVO.getTeaB_num());
		}
		TeamBoardVO db_teamBoard = teamService.getTeamBoardDetail(teamBoardVO.getTeaB_num());
		teamBoardVO.setFilename(FileUtil.createFile(request, teamBoardVO.getUpload()));
		if(teamBoardVO.getUpload()!= null && !teamBoardVO.getUpload().isEmpty()) {
			FileUtil.removeFile(request, db_teamBoard.getFilename());
		}
		teamService.updateTeamBoard(teamBoardVO);
		
		model.addAttribute("message", "글 수정 완료!!");
		model.addAttribute("url", 
		 request.getContextPath() + "/team/teamBoardDetail?teaB_num="
		                            +teamBoardVO.getTeaB_num());
		
		return "common/resultAlert";
	}
	// 글 삭제





}
