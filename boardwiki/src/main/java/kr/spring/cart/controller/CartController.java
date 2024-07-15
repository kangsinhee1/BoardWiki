package kr.spring.cart.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.cart.service.CartService;
import kr.spring.cart.vo.CartVO;
import kr.spring.item.vo.ItemVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.util.PagingUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class CartController {

	@Autowired
	private CartService cartService;

	//자바빈(VO) 초기화
	@ModelAttribute
	public CartVO initCommand() {
		return new CartVO();
	}
	/*=========================
	 * 장바구니에 데이터 담기
	 *=========================*/
	@PostMapping("/item/detail")
	public String addToCart(@RequestParam Long item_num,
			HttpSession session, HttpServletRequest request, Model model) {
		
		MemberVO member = (MemberVO) session.getAttribute("user");
		ItemVO item = (ItemVO) session.getAttribute("item");
		
		log.debug("<<게임 목록 - member>> : "+member);
		
		if (member == null || item == null) {
			model.addAttribute("message", "사용자 정보나 상품 정보가 누락되었거나 잘못되었습니다.");
			model.addAttribute("url", "/item/detail");
			return "common/resultAlert";
		}

		CartVO cartVO = new CartVO();
		cartVO.setMem_num(member.getMem_num());
		cartVO.setItem_num(item.getItem_num());
		cartVO.setItem_quantity(1); // 기본 수량을 1로 설정

		cartService.insertCart(cartVO);
		
		model.addAttribute("member", member); // member 객체를 모델에 추가
		model.addAttribute("message", "상품이 장바구니에 추가되었습니다.");
		model.addAttribute("url", request.getContextPath() + "/cart/cart");

		return "common/resultAlert";
	}

}
