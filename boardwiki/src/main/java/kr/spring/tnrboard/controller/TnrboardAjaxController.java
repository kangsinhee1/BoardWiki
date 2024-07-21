package kr.spring.tnrboard.controller;

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

import kr.spring.member.vo.MemberVO;
import kr.spring.tnrboard.service.TnrboardService;
import kr.spring.tnrboard.vo.TnrboardFavVO;
import kr.spring.tnrboard.vo.TnrboardReplyVO;
import kr.spring.tnrboard.vo.TnrboardVO;
import kr.spring.util.FileUtil;
import kr.spring.util.PagingUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class TnrboardAjaxController {
	@Autowired
	private TnrboardService tnrboardService;
	
	/*================
	 * 부모글 좋아요
	 *================*/
	//부모글 좋아요 읽기
	@GetMapping("/tnrboard/getFav")
	@ResponseBody
	public Map<String,Object> getFav(TnrboardFavVO fav,
			                         HttpSession session){
		log.debug("<<게시판 좋아요 - TnrboardFavVO>> : " + fav);
		
		Map<String,Object> mapJson = 
				          new HashMap<String,Object>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user==null) {
			mapJson.put("status", "noFav");
		}else {
			//로그인된 회원번호 셋팅
			fav.setMem_num(user.getMem_num());
			TnrboardFavVO tnrboardFav = tnrboardService.selectTnrFav(fav);
			
			if(tnrboardFav!=null) {
				mapJson.put("status", "yesFav");
			}else {
				mapJson.put("status", "noFav");
			}
		}
		mapJson.put("count", tnrboardService.selectTnrFavCount(
				                     fav.getTnr_num()));		
		return mapJson;
	}
	//부모글 좋아요 등록/삭제
	@PostMapping("/tnrboard/writeTnrFav")
	@ResponseBody
	public Map<String,Object> writeTnrFav(TnrboardFavVO fav,
			                          HttpSession session){
		log.debug("<<게시판 좋아요 - 등록>> : " + fav);
		
		Map<String,Object> mapJson = 
				new HashMap<String,Object>();
		
		MemberVO user = 
				 (MemberVO)session.getAttribute("user");
		if(user==null) {
			mapJson.put("result", "logout");
		}else {
			//로그인된 회원번호 셋팅
			fav.setMem_num(user.getMem_num());
			
			TnrboardFavVO tnrboardFav = tnrboardService.selectTnrFav(fav);
			if(tnrboardFav!=null) {
				//등록 -> 삭제
				tnrboardService.deleteTnrFav(fav);
				mapJson.put("status", "noFav");
			}else {
				//등록
				tnrboardService.insertTnrFav(fav);
				mapJson.put("status", "yesFav");
			}
			mapJson.put("result", "success");
			mapJson.put("count", tnrboardService.selectTnrFavCount(
					                      fav.getTnr_num()));			
		}		
		return mapJson;
	}
	
	
	
	/*================
	 * 부모글 데이터 처리
	 *================*/
	//업로드 파일 삭제
	@PostMapping("/tnrboard/deleteTnrboardFile")
	@ResponseBody
	public Map<String,String> processFile(
			              long tnr_num,
			              HttpSession session,
			              HttpServletRequest request){
		Map<String,String> mapJson = 
				      new HashMap<String,String>();
		MemberVO user = 
				(MemberVO)session.getAttribute("user");
		if(user==null) {
			mapJson.put("result", "logout");
		}else {
			TnrboardVO db_tnrboard = tnrboardService.selectTnrBoard(tnr_num); 
			//로그인한 회원번호와 작성자 회원번호 일치 여부 체크
			if(user.getMem_num() != db_tnrboard.getMem_num()) {
				//불일치
				mapJson.put("result", "wrongAccess");
			}else {
				//일치
				tnrboardService.deleteTnrboardFile(tnr_num);
				FileUtil.removeFile(request, db_tnrboard.getFilename());
				
				mapJson.put("result", "success");
			}
		}
		
		return mapJson;
	}
	/*================
	 * 댓글 등록
	 *================*/
	@PostMapping("/tnrboard/writeReply")
	@ResponseBody
	public Map<String,String> writeReply(
			                   TnrboardReplyVO tnrboardReplyVO,
			                   HttpSession session,
			                   HttpServletRequest request){
		log.debug("<<댓글 등록>> : " + tnrboardReplyVO);
		
		Map<String,String> mapJson = 
				        new HashMap<String,String>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user == null) {
			//로그인 안 됨
			mapJson.put("result", "logout");
		}else {
			//회원번호 저장
			tnrboardReplyVO.setMem_num(user.getMem_num());
			
			//댓글 등록
			tnrboardService.insertTnrReply(tnrboardReplyVO);
			mapJson.put("result", "success");
		}		
		return mapJson;
	}
	/*================
	 * 댓글 목록
	 *================*/
	@GetMapping("/tnrboard/listReply")
	@ResponseBody
	public Map<String,Object> getList(int tnr_num,
			                          int pageNum,
			                          int rowCount,
			                          HttpSession session){
		log.debug("<<댓글 목록 - tnr_num>> : " + tnr_num);
		log.debug("<<댓글 목록 - pageNum>> : " + pageNum);
		log.debug("<<댓글 목록 - rowCount>> : " + rowCount);
		
		Map<String,Object> map = 
				new HashMap<String,Object>();
		map.put("tnr_num", tnr_num);
		
		//총글의 개수
		int count = tnrboardService.selectTnrRowCountReply(map);
		
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
		
		List<TnrboardReplyVO> list = null;
		if(count > 0) {
			list = tnrboardService.selectTnrListReply(map);
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
	@PostMapping("/tnrboard/updateReply")
	@ResponseBody
	public Map<String,String> modifyReply(
			                TnrboardReplyVO tnrboardReplyVO,
			                HttpSession session,
			                HttpServletRequest request){
		log.debug("<<댓글 수정>> : " + tnrboardReplyVO);
		
		Map<String,String> mapJson =
				      new HashMap<String,String>();
		
		MemberVO user = 
				(MemberVO)session.getAttribute("user");
		
		TnrboardReplyVO db_reply = 
				tnrboardService.selectTnrReply(
						   tnrboardReplyVO.getTnrR_num());
		if(user==null) {
			//로그인이 되지 않은 경우
			mapJson.put("result", "logout");
		}else if(user!=null && 
				user.getMem_num()==db_reply.getMem_num()) {
			//로그인 회원번호와 작성자 회원번호 일치
			
			//댓글 수정
			tnrboardService.updateTnrReply(tnrboardReplyVO);
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
	@PostMapping("/tnrboard/deleteReply")
	@ResponseBody
	public Map<String,String> deleteReply(long tnrR_num,
			                       HttpSession session){
		log.debug("<<댓글 삭제 - tnrR_num>> : " + tnrR_num);
		
		Map<String,String> mapJson = 
				           new HashMap<String,String>();
		
		MemberVO user = 
				(MemberVO)session.getAttribute("user");
		TnrboardReplyVO db_reply = 
				         tnrboardService.selectTnrReply(tnrR_num);
		if(user==null) {
			//로그인이 되지 않은 경우
			mapJson.put("result", "logout");
		}else if(user!=null &&
				    user.getMem_num() == db_reply.getMem_num()) {
			//로그인한 회원번호와 작성자 회원번호 일치
			tnrboardService.deleteTnrReply(tnrR_num);
			mapJson.put("result", "success");
		}else {
			//로그인한 회원번호와 작성자 회원번호 불일치
			mapJson.put("result", "wrongAccess");
		}		
		return mapJson;
	}
	
}
