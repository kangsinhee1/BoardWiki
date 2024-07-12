package kr.spring.cart.dao;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.cart.vo.CartVO;

@Mapper
public interface CartMapper {
	//장바구니
	@Select("SELECT * FROM cart JOIN item USING(item_num) WHERE mem_num=#{mem_num}")
	public CartVO selectCart(Long mem_num);
	@Insert("INSERT INTO cart (mem_num,item_num,item_quantity) VALUES (#{mem_num},#{item_num},#{item_quantity})")
	public void insertCart(CartVO cart);
	@Update("UPDATE cart set item_num=#{item_num},item_quantity=#{item_quantity} WHERE mem_num=#{mem_num}")
	public void updateCart(CartVO cart);
	
}
