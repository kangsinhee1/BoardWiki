package kr.spring.order.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.cart.controller.CartController;
import kr.spring.cart.service.CartService;
import kr.spring.cart.vo.CartVO;
import kr.spring.item.service.ItemService;
import kr.spring.member.vo.MemberVO;
import kr.spring.order.vo.OrderVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class OrderController {
	@Autowired
	private CartService cartService;
	@Autowired
	private ItemService itemService;
	
	//자바빈(VO) 초기화
    @ModelAttribute
    public OrderVO initCommand() {
    	return new OrderVO();
    }
    
    /*=========================
	 * 장바구니에서 데이터 불러오기
	 *=========================*/
    @GetMapping("/order/order")
    public String addToOrder(Model model,Long mem_num, HttpSession session){
    	
    	MemberVO member = (MemberVO) session.getAttribute("user");
    	
    	if (member == null) {
	        return "redirect:/login"; // 세션에 user가 없으면 로그인 페이지로 리다이렉트
	    }
    	
    	Map<String, Object> map = new HashMap<>();
    	map.put("mem_num", member.getMem_num());
    	
    	List<CartVO> list = null;
    	list = cartService.selectCartList(map);
    	
    	model.addAttribute("mem_num",mem_num);
    	model.addAttribute("list",list);
    	
    	return "order";
    }
    
    /*=========================
	 * 주문창에 데이터 담기
	 *=========================*/
    @PostMapping("/order/order")
    @ResponseBody
    public Map<String, Object> addTOOrder(@RequestParam Long mem_num,OrderVO orderVO,
    		                              HttpSession session){
    	Map<String, Object> mapAjax = new HashMap<String, Object>();
    	
    	log.debug("<<유저 - mem_num>>" + mem_num);
    	
    	if (mem_num == null) {
    		mapAjax.put("result", "logout");
    	}else {
    		
//    		OrderVO order = new OrderVO();
//    		order.setMem_num(mem_num);
//    		order.setItem_num();
//    		order.setOrder_name();
//    		order.setOrder_phone();
//    		order.setOrder_zipcode();
//    		order.setOrder_address1();
//    		order.setOrder_address2();
//    		order.setOrder_pay();
//    		order.setOrder_check();
//    		
//    		log.debug("<<주문 VO - orderVO>> : " + order);
    	}
    	
    	return mapAjax;
    }
}




































