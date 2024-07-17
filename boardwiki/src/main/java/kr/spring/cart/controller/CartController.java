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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.cart.service.CartService;
import kr.spring.cart.vo.CartVO;
import kr.spring.item.service.ItemService;
import kr.spring.item.vo.ItemVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.util.PagingUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class CartController {

	@Autowired
	private CartService cartService;
	@Autowired
	private ItemService itemService;

	//자바빈(VO) 초기화
	@ModelAttribute
	public CartVO initCommand() {
		return new CartVO();
	}
	/*=========================
	 * 장바구니에 데이터 담기
	 *=========================*/
	@PostMapping("/item/addToCart")
	@ResponseBody
	public Map<String, Object> addToCart(@RequestParam Long item_num, @RequestParam Integer item_quantity,
			HttpSession session) {
		Map<String, Object> mapAjax = new HashMap<String, Object>();

		MemberVO member = (MemberVO) session.getAttribute("user");

		log.debug("<<유저 - member>> : " + member);
		log.debug("<<수량 - item_quantity>> : " + item_quantity);

		if (member == null) {
			mapAjax.put("result", "logout");
			
		}else {
			CartVO cart = new CartVO();
			cart.setMem_num(member.getMem_num());
			cart.setItem_num(item_num);
			cart.setItem_quantity(item_quantity); // 사용자가 선택한 수량 설정
			
			log.debug("<<장바구니 VO - cartVO>> : " + cart);
			
			ItemVO item = itemService.selectItem(item_num);
			
			if (item == null) {
	            mapAjax.put("result", "noitem");
	            return mapAjax;
	        }
			
			CartVO db_cart = cartService.getCart(cart);
			
			
			
		    if(db_cart==null) {//동일 상품이 없을 경우
		    	
		    	//재고수를 구하기 위해서 Item get 호출
				int db_item = itemService.getterItem(item_num);
				
				if(db_item<item_quantity) {
					//상품재고 수량보다 장바구니에 담은 구매수량이 더 많음
					log.debug("<<재고 수량 초과>>");
					mapAjax.put("result", "overquantity");
				}else {
					
					cartService.insertCart(cart);
                  //itemService.updateStock(item_num, db_item - item_quantity); // 아이템 번호와 재고 수량을 함께 전달
					log.debug("<<장바구니에 상품 추가 성공>>");
					mapAjax.put("result", "success");
				}
			}else {//동일 상품이 있을 경우
				//재고수를 구하기 위해서 Item get 호출
				int db_item = itemService.getterItem(item_num);
				
				//구매수량 합산(기존 장바구니에 저장된 구매수량 + 새로 입력한 구매수량
				item_quantity = db_cart.getItem_quantity() +
						           cart.getItem_quantity();
				if(db_item<item_quantity) {
					//상품재고 수량보다 장바구니에 담은 구매수량이 더 많음
					log.debug("<<재고 수량 초과>>");
					mapAjax.put("result", "overquantity");
				}else {
					cart.setItem_quantity(item_quantity);
                    cartService.updateCart(cart);
                  //itemService.updateStock(item_num, db_item - item_quantity); // 아이템 번호와 재고 수량을 함께 전달
                    log.debug("<<장바구니에 상품 추가 성공>>");
                    mapAjax.put("result", "success");
				}
			}
		}
		log.debug("<<mapAjax 결과>> : " + mapAjax);
		return mapAjax;
	}
	/*=========================
	 * 장바구니 목록
	 *=========================*/
	@GetMapping("/cart/cart")
	public String getList(
	        Model model,
	        HttpSession session) throws IllegalStateException, IOException {

	    MemberVO member = (MemberVO) session.getAttribute("user");
	    
	    
	    if (member == null) {
	        return "redirect:/login"; // 세션에 user가 없으면 로그인 페이지로 리다이렉트
	    }

	    log.debug("<<유저 - member>> : " + member);

	    Map<String, Object> map = new HashMap<>();
	    map.put("mem_num", member.getMem_num());

	    List<CartVO> list = null;

	    list = cartService.selectCartList(map);
	    
	    model.addAttribute("list", list);

	    return "cart";
	}
	/*====================
	 *  장바구니 품목 삭제
	 *====================*/
	@GetMapping("/cart/delete")
	public String smallDelete(Long mem_num,Long item_num,
			                  HttpServletRequest request) {
		log.debug("<<장바구니 품목 삭제 -- item_num,mem_num>>"+ item_num + mem_num);
		
		CartVO cart = new CartVO();
		
		cart.setMem_num(mem_num);
		cart.setItem_num(item_num);
		
		cartService.deleteSmallCart(cart);
		
		return "redirect:/cart/cart";
	}
}
















