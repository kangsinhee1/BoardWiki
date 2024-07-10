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

import kr.spring.member.vo.MemberVO;
import kr.spring.team.controller.TeamController;
import kr.spring.team.service.TeamService;
import kr.spring.team.vo.TeamApplyVO;
import kr.spring.team.vo.TeamVO;
import kr.spring.util.PagingUtil;
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
		log.debug(" 팀 신청 VO :"+applyVO);
		MemberVO user = (MemberVO)session.getAttribute("user");
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
		teamService.insertTeamApply(applyVO);
		return getMyTeam(model, session);
	}
	  
	
	/*=====================
	 * 나의 모임 게시판
	 *=====================*/
	

	/*=====================
	 * 나의 모임 게시판 목록(가입한 모임, 등록한 모임, 신청중 모임)
	 *=====================*/
	
	@GetMapping("/team/myTeam")
	public String getMyTeam(Model model, HttpSession session) {
		Map<String,Object> map = new HashMap<String,Object>();
		Map<String,Object> map2 = new HashMap<String,Object>();
		Map<String,Object> map3= new HashMap<String,Object>();
		
		
		//본인이 가입한 모임 목록
		MemberVO user = (MemberVO)session.getAttribute("user");
		map.put("mem_num",user.getMem_num());
		map.put("teaA_status",2);
		List<TeamVO> list = null;
		list = teamService.selectTeamListApplied(map);
		model.addAttribute("list",list);
		//본인이 등록한 모임 목록
		
		  map2.put("mem_num",user.getMem_num());
		  map2.put("teaA_status",9); 
		  List<TeamVO> list2 = null; list2 = teamService.selectTeamListApplied(map2);
		  model.addAttribute("list2",list2);
		 
		// 신청한 모임 목록
		map3.put("mem_num",user.getMem_num());
		map3.put("teaA_status",1);
		List<TeamVO> list3 = null;
		list3 = teamService.selectTeamListApplied(map3);
		model.addAttribute("list3",list3);
		
		
		model.addAttribute("navJspPath", "/WEB-INF/views/team/myTeam-nav.jsp");
        model.addAttribute("bodyJspPath", "/WEB-INF/views/team/myTeam.jsp");
        
		return "myTeam";
	}
	@GetMapping("/team/teamBoardWrite")
	public String insertTeamBoard(HttpServletRequest request,
			HttpSession session,
			Model model) {
		MemberVO member =(MemberVO)session.getAttribute("user");
		if(member== null) {
			model.addAttribute("message", "로그인후 작성 가능합니다.");
			model.addAttribute("url", 
					 request.getContextPath()+"/team/teamBoardList");
	return "common/resultAlert";
			
		}
		return "teamBoardWrite";
	}
	
	
	
	
	
}
