package kr.spring.cart.service;

import java.util.List;
import java.util.Map;

import kr.spring.cart.vo.CartVO;

public interface CartService {
	//장바구니
	public CartVO selectCart(Long mem_num);
	public List<CartVO> selectCartList(Map<String, Object> map);
	public Integer selectRowCount(Map<String, Object> map);
	public void insertCart(CartVO cart);
	public void updateCart(CartVO cart);
	public void updateCart2(CartVO cart);
	public void updateCartDate(CartVO cart);
	public CartVO getCart(CartVO cart);
	public void deleteSmallCart(CartVO cart);
}
