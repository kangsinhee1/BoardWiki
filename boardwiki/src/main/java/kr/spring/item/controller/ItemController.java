package kr.spring.item.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;

import kr.spring.item.service.ItemService;
import kr.spring.item.vo.ItemVO;
import kr.spring.util.PagingUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ItemController {
	@Autowired
	public ItemService itemService;
	
	//자바빈(VO) 초기화
	@ModelAttribute
	public ItemVO initCommand() {
		return  new ItemVO();
	}
	
	/*====================
	 *  게임 목록
	 *====================*/
	@GetMapping("/item/item_main")
	public String getList(@RequestParam(defaultValue="1") int pageNum,
                          @RequestParam(defaultValue="1") int order,
                          @RequestParam(defaultValue="") String category,
                          String keyfield,String keyword,Model model) {
		
        Map<String,Object> map = new HashMap<String,Object>();
		
		map.put("category", category);
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		//전체, 검색 레코드수
		int count = itemService.selectRowCount(map);
		
		//페이지 처리
	    PagingUtil page = 
				new PagingUtil(keyfield,keyword,pageNum,
						count,20,10,"list",
						"&category="+category+"&order="+order);
	    List<ItemVO> list = null;
	    if(count > 0) {
			map.put("order", order);
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = itemService.selectList(map);
		}
	    
	    model.addAttribute("count", count);
		model.addAttribute("list", list);
		model.addAttribute("page", page.getPage());
		
		return "item_main";
	}
}
