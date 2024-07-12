package kr.spring.cart.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.cart.service.CartService;
import kr.spring.cart.vo.CartVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class CartController {
	
	@Autowired
	private CartService cartService;
	
	//자바빈(vo) 초기화
	@ModelAttribute
	public CartVO initCommand() {
		return new CartVO();
	}
	/*=========================
	 * 장바구니 생성
	 *=========================*/
	@GetMapping("/cart/cart")
	public ModelAndView process(Long mem_num) {
		log.debug("<<장바구니 - mem_num>> : "+mem_num);
		
		//
		
		return new ModelAndView();
	}
}
