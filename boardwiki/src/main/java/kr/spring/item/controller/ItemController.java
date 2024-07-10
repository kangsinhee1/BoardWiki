package kr.spring.item.controller;

import java.util.HashMap;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

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
		return new ItemVO();
	}

	/*====================
	 *  게임 목록
	 *====================*/
	//인기 게임
	@GetMapping("/item/item_main")
	public String getList(@RequestParam(defaultValue="1") int pageNum,
                          @RequestParam(defaultValue="1") int order,
                          @RequestParam(defaultValue="") String category,
                          String keyfield,String keyword,Model model) {
		log.debug("<<게임 목록 - category>> : "+category);
		log.debug("<<게임 목록 - order>> : "+order);
		
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
	    
	    //////////////////////////
	    List<ItemVO> list = null;
	    if(count > 0) {
			map.put("order", order);
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());

			list = itemService.selectList(map);
		}
	    List<ItemVO> list2 = null;
	    if(count > 0) {
			map.put("order", order);
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());

			list2 = itemService.selectList2(map);
		}

	    model.addAttribute("count", count);
		model.addAttribute("list", list);
		model.addAttribute("list2", list2);
		model.addAttribute("page", page.getPage());

		return "item_main";
	}
	/*=========================
	 * 게임 상세
	 *=========================*/
	@GetMapping("/item/item_detail")
	public ModelAndView process(Long item_num) {
		log.debug("<<게임 상세 - item_num>> : "+item_num);
		
		ItemVO item = itemService.selectItem(item_num);
		
		return new ModelAndView("item_detail","item",item);
	}
}





















