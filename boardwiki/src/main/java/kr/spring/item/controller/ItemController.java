package kr.spring.item.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;

import kr.spring.item.service.ItemService;
import kr.spring.item.vo.ItemVO;
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
	public String getList() {
		
		return "item_main";
	}
}
