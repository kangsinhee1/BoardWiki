package kr.spring.item.controller;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.board.vo.BoardReplyVO;
import kr.spring.item.service.ItemService;
import kr.spring.item.vo.ItemVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.util.PagingUtil;
import lombok.Getter;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ItemAjaxController {
	@Autowired
	ItemService itemService;
	
	/*==============
	 * 답글 목록
	 *==============*/
	@GetMapping("/used/searchItem")
	@ResponseBody
	public Map<String,Object> getList(String keyword,
									  int pageNum,
									  int rowCount,
									  HttpSession session){
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyword", keyword);
		
		//총글의 개수
		int count = itemService.selectRowCount(map);
		PagingUtil page = new PagingUtil(pageNum,count,rowCount);
		map.put("start", page.getStartRow());
		map.put("end", page.getEndRow());
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user != null) {
			map.put("mem_num", user.getMem_num());
		}else {
			map.put("mem_num", 0);
		}
		
		Map<String,Object> mapJson = new HashMap<String,Object>();
		List<ItemVO> list = null;
		if(count > 0) {
			list = itemService.selectListByKeyword(map);
		}else {
			list = Collections.emptyList();
			mapJson.put("result", "none");
		}
		
		mapJson.put("count", count);
		mapJson.put("list", list);
		mapJson.put("result", "success");
		
		if(user!=null) {
			mapJson.put("user_num", user.getMem_num());
		}
		
		return mapJson;
	}
	/*==============
	 * 룰북/보드게임검색
	 *==============*/
	@GetMapping("/rulebook/searchItem")
	@ResponseBody
	public Map<String,Object> getList2(String keyword,
									  int pageNum,
									  int rowCount,
									  HttpSession session){
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyword", keyword);
		
		//총글의 개수
		int count = itemService.selectRowCount(map);
		PagingUtil page = new PagingUtil(pageNum,count,rowCount);
		map.put("start", page.getStartRow());
		map.put("end", page.getEndRow());
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user != null) {
			map.put("mem_num", user.getMem_num());
		}else {
			map.put("mem_num", 0);
		}
		
		Map<String,Object> mapJson = new HashMap<String,Object>();
		List<ItemVO> list = null;
		if(count > 0) {
			list = itemService.selectListByKeyword(map);
		}else {
			list = Collections.emptyList();
			mapJson.put("result", "none");
		}
		
		mapJson.put("count", count);
		mapJson.put("list", list);
		mapJson.put("result", "success");
		
		if(user!=null) {
			mapJson.put("user_num", user.getMem_num());
		}
		
		return mapJson;
	}
	
}
