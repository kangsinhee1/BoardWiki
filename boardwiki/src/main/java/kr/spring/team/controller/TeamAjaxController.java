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
import kr.spring.member.vo.MemberVO;
import kr.spring.team.service.TeamService;
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



}
