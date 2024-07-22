package kr.spring.main.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.spring.board.service.BoardService;
import kr.spring.board.vo.BoardVO;
import kr.spring.item.service.ItemService;
import kr.spring.item.vo.ItemVO;
import kr.spring.used.service.UsedService;
import kr.spring.used.vo.UsedItemVO;
import kr.spring.util.PagingUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MainController {
	@Autowired
	public ItemService itemService;

	@Autowired
	private BoardService boardService;

	@Autowired
	private UsedService usedService;

	@GetMapping("/")
	public String init() {
		return "redirect:/main/main";
	}

	@GetMapping("/main/main")
	public String main() {
		return "main";//Tiles의 설정명
	}


	@GetMapping("/*/mainList")
	public String returnMainList(String keyword1) {
		Map<String,Object> map = new HashMap<>();
		map.put("keyword1", keyword1);

		return "redirect:/main/mainList?keyword1=" + keyword1;
	}
	@GetMapping("/main/mainList")
	public String mainSearch(@RequestParam(defaultValue="1") int pageNum,
            @RequestParam(defaultValue="") String category,
            String keyfield,
            String keyword1,Model model) {

			keyfield = "1";
			Map<String,Object> map = new HashMap<>();

			map.put("category", category);
			map.put("keyfield", keyfield);
			map.put("keyword", keyword1);

			//전체, 검색 레코드수
			int count = itemService.selectRowCount2(map);
			int count2 = boardService.selectRowCount(map);
			int count3 = usedService.getUsedRowCount(map);

			//페이지 처리
		    PagingUtil gamePage =
					new PagingUtil(keyfield,keyword1,pageNum,count,21,10,"mainList");
		    PagingUtil boardPage =
		    		new PagingUtil(keyfield,keyword1,pageNum,count2,20,10,"mainList");
		    PagingUtil usedPage =
		    		new PagingUtil(keyfield, keyword1, pageNum,count3,20,10,"mainList");


		    List<ItemVO> list = null;
		    if(count > 0) {
		    	map.put("start", gamePage.getStartRow());
		    	map.put("end", gamePage.getEndRow());

		    	list = itemService.selectListByKeyword(map);
		    }
		    List<BoardVO> list2 = null;
		    if(count2 > 0) {
		    	map.put("start", boardPage.getStartRow());
		    	map.put("end", boardPage.getEndRow());

		    	list2 = boardService.selectList(map);
		    }
		    List<UsedItemVO> list3 = null;
			if(count3 >0) {
				map.put("start",usedPage.getStartRow());
				map.put("end",usedPage.getEndRow());
				list3 = usedService.selectUsedList(map);
			}

		    model.addAttribute("count", count);
		    model.addAttribute("count2", count2);
		    model.addAttribute("count3", count2);
			model.addAttribute("list", list);
			model.addAttribute("list2", list2);
			model.addAttribute("list3", list3);
			model.addAttribute("page", gamePage.getPage());
			model.addAttribute("page2", boardPage.getPage());
			model.addAttribute("page3", usedPage.getPage());


		return "mainList";
	}
}








