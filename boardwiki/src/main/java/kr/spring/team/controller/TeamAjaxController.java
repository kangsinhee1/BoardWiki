package kr.spring.team.controller;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.board.service.BoardService;
import kr.spring.board.vo.BoardReplyVO;
import kr.spring.chat.service.ChatService;
import kr.spring.chat.vo.ChatRoomVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.team.service.TeamService;
import kr.spring.team.vo.TeamApplyVO;
import kr.spring.team.vo.TeamBoardVO;
import kr.spring.team.vo.TeamFavVO;
import kr.spring.team.vo.TeamReplyVO;
import kr.spring.util.FileUtil;
import kr.spring.util.PagingUtil;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Controller
public class TeamAjaxController {

	@Autowired
	private TeamService teamService;
	

	@Autowired
	private ChatService chatService;
	/*=====================
	 * 모임 좋아요 목록
	 *=====================*/
	@GetMapping("/team/teamFav")
	@ResponseBody
	public Map<String,Object> teamFav(TeamFavVO teamFav, HttpSession session){
		Map<String, Object> mapJson = new HashMap<String,Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user==null) {
			mapJson.put("status", "noFav");
		}else {
			teamFav.setMem_num(user.getMem_num());

			TeamFavVO fav = teamService.selectTeamFav(teamFav);
			if(fav !=null) {
				mapJson.put("status","yesFav");

			}else {
				mapJson.put("status", "noFav");
			}
		}
		mapJson.put("count", teamService.selectTeamFavCount(teamFav.getTea_num()));
		return mapJson;
	}

	/*=====================
	 * 모임 좋아요 등록/삭제
	 *=====================*/
	@PostMapping("/team/writeTeamFav")
	@ResponseBody
	public Map<String,Object> writeTeamFav(HttpSession session, TeamFavVO teamFav){
		Map<String, Object> mapJson = new HashMap<String,Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");

		if(user==null) {
			mapJson.put("result", "logout");
		}else {
			teamFav.setMem_num(user.getMem_num());
			TeamFavVO fav = teamService.selectTeamFav(teamFav);
			if(fav !=null) {
				teamService.deleteTeamFav(teamFav);
				mapJson.put("status","noFav");
			}else {
				teamService.insertTeamFav(teamFav);
				mapJson.put("status", "yesFav");
			}
			mapJson.put("result", "success");
			mapJson.put("count", teamService.selectTeamFavCount(teamFav.getTea_num()));
		}
		return mapJson;
	}




	/*=====================
	 * 업로드 파일 삭제
	 *=====================*/
	
	@PostMapping("/team/deleteFile")
	@ResponseBody
	public Map<String,String> deleteFile (long teaB_num, HttpSession session,
            HttpServletRequest request){
		Map<String,String> mapJson = 
				new HashMap<String,String>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user==null) {
			mapJson.put("result", "logout");
		}else {
			TeamBoardVO db_teamBoard = teamService.getTeamBoardDetail(teaB_num);
			// 로그인한 사람과 불일치
			if(db_teamBoard.getMem_num() != user.getMem_num()) {
				mapJson.put("result", "wrongAccess");
			}else {
					teamService.deleteTeamBoardFile(teaB_num);
					FileUtil.removeFile(request, db_teamBoard.getFilename());
					mapJson.put("result", "success");
				}
			}
			
		return mapJson;
	}
	/*================
	 * 댓글 등록
	 *================*/
	@PostMapping("/team/writeBoardReply")
	@ResponseBody
	public Map<String,String> writeReply(
			                   TeamReplyVO teamReplyVO,
			                   HttpSession session,
			                   HttpServletRequest request){
		log.debug("<<댓글 등록>> : " + teamReplyVO);
		
		Map<String,String> mapJson = 
				        new HashMap<String,String>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user == null) {
			//로그인 안 됨
			mapJson.put("result", "logout");
		}else {
			//회원번호 저장
			teamReplyVO.setMem_num(user.getMem_num());
			
			//댓글 등록
			teamService.insertTeamBoardReply(teamReplyVO);
			mapJson.put("result", "success");
		}		
		return mapJson;
	}
	/*================
	 * 댓글 목록
	 *================*/
	
	@GetMapping("/team/listBoardReply")
	@ResponseBody
	public Map<String,Object> getList(int teaB_num,
			                          int pageNum,
			                          int rowCount,
			                          HttpSession session){
		log.debug("<<댓글 목록 - teaB_num>> : " + teaB_num);
		log.debug("<<댓글 목록 - pageNum>> : " + pageNum);
		log.debug("<<댓글 목록 - rowCount>> : " + rowCount);
		
		Map<String,Object> map = 
				new HashMap<String,Object>();
		map.put("teaB_num", teaB_num);
		
		//총글의 개수
		int count = teamService.selectTeamBoardReplyCount(map);
		
		//페이지 처리
		PagingUtil page = 
				new PagingUtil(pageNum,count,rowCount);
		map.put("start", page.getStartRow());
		map.put("end", page.getEndRow());
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user!=null) {
			map.put("mem_num", user.getMem_num());
		}else {
			map.put("mem_num", 0);
		}
		
		List<TeamReplyVO> list = null;
		if(count > 0) {
			list = teamService.selectTeamBoardReplyList(map);
		}else {
			list = Collections.emptyList();
		}
		Map<String,Object> mapJson = 
				        new HashMap<String,Object>();
		mapJson.put("count", count);
		mapJson.put("list",list);
		if(user!=null) {
			mapJson.put("user_num", user.getMem_num());
		}
		
		return mapJson;
	}
	/*================
	 * 댓글 수정
	 *================*/	
	@PostMapping("/team/updateReply")
	@ResponseBody
	public Map<String,String> modifyReply(
							TeamReplyVO teamReplyVO,
			                HttpSession session,
			                HttpServletRequest request){
		log.debug("<<댓글 수정>> : " + teamReplyVO);
		
		Map<String,String> mapJson =
				      new HashMap<String,String>();
		
		MemberVO user = 
				(MemberVO)session.getAttribute("user");
		
		TeamReplyVO db_reply = teamService.getTeamReply(teamReplyVO.getTeaR_num());
			
		if(user==null) {
			//로그인이 되지 않은 경우
			mapJson.put("result", "logout");
		}else if(user!=null && 
				user.getMem_num()==db_reply.getMem_num()) {
			//로그인 회원번호와 작성자 회원번호 일치
			
			//댓글 수정
			mapJson.put("result", "success");
		}else {
			//로그인 회원번호와 작성자 회원번호 불일치
			mapJson.put("result", "wrongAccess");
		}		
		return mapJson;
	}
	/*================
	 * 댓글 삭제
	 *================*/	
	@PostMapping("/team/deleteReply")
	@ResponseBody
	public Map<String,String> deleteReply(long teaR_num,
			                       HttpSession session){
		log.debug("<<댓글 삭제 - teaR_num>> : " + teaR_num);
		
		Map<String,String> mapJson = 
				           new HashMap<String,String>();
		
		MemberVO user = 
				(MemberVO)session.getAttribute("user");
				//db확인
		TeamReplyVO db_reply = teamService.getTeamReply(teaR_num);
		if(user==null) {
			//로그인이 되지 않은 경우
			mapJson.put("result", "logout");
		}else if(user!=null &&
				    user.getMem_num() == db_reply.getMem_num()) {
			//로그인한 회원번호와 작성자 회원번호 일치
			teamService.deleteTeamBoardReply(teaR_num);
			mapJson.put("result", "success");
		}else {
			//로그인한 회원번호와 작성자 회원번호 불일치
			mapJson.put("result", "wrongAccess");
		}		
		return mapJson;
	}
	
	
	//모임 신청 처리 및 회원 정지 기능
	@PostMapping("/team/changeStatus")
	@ResponseBody
	public Map<String,String> changeStatus(long teaA_num ,long teaA_status, HttpSession session){
		Map<String,String> mapJson = 
		           new HashMap<String,String>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		TeamApplyVO db_applyVO = teamService.getTeamApply(teaA_num);
		long admin = teamService.detailTeam(db_applyVO.getTea_num()).getMem_num();
		ChatRoomVO chatRoomVO = chatService.selectChatRoom(db_applyVO.getTea_num());
		Map<String,Long> chatread = new HashMap<String,Long>();
		
		chatread.put("mem_num", db_applyVO.getMem_num());
		chatread.put("chaR_num", chatRoomVO.getChaR_num());
		if(user==null) {
			//로그인이 되지 않은 경우
			mapJson.put("result", "logout");
		}
		else if(admin != user.getMem_num()) {
			mapJson.put("result", "wrongAccess");
		}else {
			teamService.updateTeamApplyStatus(teaA_status,teaA_num);
			if(teaA_status == 2) {
				chatService.insertChatRoomMember(chatRoomVO.getChaR_num(), chatRoomVO.getChaR_name(), db_applyVO.getMem_num());
				
			}else {
				chatService.deleteChatRoomMemeberUser(db_applyVO.getMem_num(),chatRoomVO.getChaR_num());
				chatService.deleteChatRead(chatread);
			}
			mapJson.put("result", "success");
		}
		
		return mapJson;
	}
	
	//모임 신청 처리 및 회원 정지 기능
		@PostMapping("/team/updateMeetingDate")
		@ResponseBody
		public Map<String,String> updateMeetingDate(long tea_num ,String tea_time, HttpSession session){
			
			Map<String,String> mapJson = 
			           new HashMap<String,String>();
			MemberVO user = 
					(MemberVO)session.getAttribute("user");
			if(user==null) {
				//로그인이 되지 않은 경우
				mapJson.put("result", "logout");
			}else {
				teamService.updateTeamSchedule(tea_num, tea_time);
				// 모임 참석자 모두 미정 처리
				teamService.deleteTeamApplyAttend(tea_num);
				mapJson.put("result", "success");
			}
			
			return mapJson;
		}
	// 모임 취소 기능
		@PostMapping("/team/deleteMeetingDate")
		@ResponseBody
		public Map<String,String> deleteMeetingDate(long tea_num ,String tea_time, HttpSession session){
			
			Map<String,String> mapJson = 
			           new HashMap<String,String>();
			MemberVO user = 
					(MemberVO)session.getAttribute("user");
			if(user==null) {
				//로그인이 되지 않은 경우
				mapJson.put("result", "logout");
			}else {
				//모임 일정 취소
				teamService.updateTeamSchedule(tea_num, tea_time);
				// 모임 참석자 모두 미정 처리
				teamService.deleteTeamApplyAttend(tea_num);
				mapJson.put("result", "success");
			}
			return mapJson;
		}
		
		@PostMapping("/team/teamAttend")
		@ResponseBody
		public Map<String,String> teamAttend(long tea_num, long teaA_attend, HttpSession session){
			Map<String,String> mapJson = 
			           new HashMap<String,String>();
			MemberVO user = 
					(MemberVO)session.getAttribute("user");
			
			
			if(user==null) {
				mapJson.put("result", "logout");
			}else {
				if(teaA_attend == 0) {
					TeamApplyVO applyVO = new TeamApplyVO();
					applyVO.setTea_num(tea_num);
					applyVO.setMem_num(user.getMem_num());
					applyVO.setTeaA_attend(1);
					teamService.updateTeamApplyUser(applyVO);
					mapJson.put("result", "success1");
				}else if(teaA_attend ==1) {
					TeamApplyVO applyVO2 = new TeamApplyVO();
					applyVO2.setTea_num(tea_num);
					applyVO2.setMem_num(user.getMem_num());
					applyVO2.setTeaA_attend(0);
					teamService.updateTeamApplyUser(applyVO2);
					mapJson.put("result", "success2");
				}
				
			}
			return mapJson;
		}
}
