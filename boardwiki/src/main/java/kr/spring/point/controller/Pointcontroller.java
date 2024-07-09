package kr.spring.point.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;

import kr.spring.member.vo.MemberVO;
import kr.spring.point.service.PointService;
import kr.spring.point.vo.PointVO;
import kr.spring.util.PagingUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class Pointcontroller {
	@Autowired
	private PointService pointService;
	
	@ModelAttribute
	public PointVO initCommand() {
		return new PointVO();
	}
	/**포인트 목록*/
	@GetMapping("/point/list")
	public String getList(
	        @RequestParam(defaultValue="1") int pageNum,
	        @RequestParam(defaultValue="") String poi_status,
	        Model model, HttpSession session) {
	    
	    MemberVO user = (MemberVO) session.getAttribute("user");
	    long mem_num = user.getMem_num();
	    
	    log.debug("<<포인트 목록 - poi_status>> : {}", poi_status);
	    log.debug("<<포인트 목록 - user>> : {}", mem_num);
	    
	    Map<String, Object> map = new HashMap<>();
	    map.put("mem_num", mem_num);
	    if (!poi_status.isEmpty()) {
	        map.put("poi_status", Integer.parseInt(poi_status));
	    }
	    
	    // 전체, 검색 레코드 수
	    int count = pointService.selectRowCount(map);
	    
	    // 페이지 처리
	    PagingUtil page = new PagingUtil(pageNum, count, 20, 10, "list",
	            "&poi_status=" + poi_status + "&mem_num=" + mem_num);
	    
	    List<PointVO> list = null;
	    if (count > 0) {
	        map.put("start", page.getStartRow());
	        map.put("end", page.getEndRow());
	        
	        list = pointService.selectPointList(map);
	    }
	    
	    model.addAttribute("count", count);
	    model.addAttribute("list", list);
	    model.addAttribute("page", page.getPage());
	    
	    return "pointList";
	}
}
