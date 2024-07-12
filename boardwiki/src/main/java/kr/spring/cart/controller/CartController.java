package kr.spring.cart.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.cart.service.CartService;
import kr.spring.cart.vo.CartVO;
import kr.spring.item.vo.ItemVO;
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
	 * 장바구니에 넣기
	 *=========================*/
	@GetMapping("/item/item_detail")
	public String submit(@Valid CartVO cartVO,
			BindingResult result,
			HttpServletRequest request,
			HttpSession session,
			Model model)
					throws IllegalStateException,
					IOException{
		log.debug("<<장바구니 생성>> : " + cartVO);

		if(result.hasErrors()) {
			return "/item/item_detail";
		}

		CartVO vo = (CartVO)session.getAttribute("cart");
		cartVO.setItem_num(vo.getItem_num());

		model.addAttribute("message","상품이 장바구니에 추가되었습니다.");
		model.addAttribute("url",request.getContextPath()+"/board/list");

		return "common/resultAlert";
	}
}
