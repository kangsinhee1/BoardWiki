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
					itemService.updateStock(item_num, db_item - item_quantity); // 아이템 번호와 재고 수량을 함께 전달
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
                    itemService.updateStock(item_num, db_item - item_quantity); // 아이템 번호와 재고 수량을 함께 전달
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
			@RequestParam(defaultValue="1") int pageNum,
			@RequestParam(defaultValue="1") int order,
			@RequestParam(defaultValue="") String cart_category,
			String keyfield,String keyword,Model model,HttpSession session)
			            		  throws IllegalStateException, IOException {
		
		MemberVO member = (MemberVO) session.getAttribute("user");
		Long mem_num = member.getMem_num();
		
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("cart_category", cart_category);
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		int count = cartService.selectRowCount(map);
		
		PagingUtil page = new PagingUtil(keyfield,keyword,pageNum,count,
				10,10,"list","&cart_category="+cart_category+"&order="+order);
		
		List<CartVO> list = null;
		
		if(count > 0) {
			map.put("order", order);
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = cartService.selectCartList(map);
		}
		
		model.addAttribute("count", count);
		model.addAttribute("list", list);
		model.addAttribute("page", page.getPage());
		
		return "cart";
	}
}
















