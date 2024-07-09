package kr.spring.team.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.board.service.BoardService;
import kr.spring.member.vo.MemberVO;
import kr.spring.team.service.TeamService;
import kr.spring.team.vo.TeamFavVO;
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
	

}
	