package kr.spring.cart.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Update;

import kr.spring.cart.vo.CartVO;

public interface CartService {
	//장바구니
	public List<CartVO> selectCart(Map<String,Object> map);
	public void insertCart(CartVO cart);
	public void updateCart(CartVO cart);
}
