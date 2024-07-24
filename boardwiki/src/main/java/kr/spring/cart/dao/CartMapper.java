package kr.spring.cart.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.cart.vo.CartVO;

@Mapper
public interface CartMapper {
	//장바구니
	public List<CartVO> selectCartList(Map<String,Object> map);
	public Integer selectRowCount(Map<String, Object> map);
	public CartVO selectCart(Long mem_num);
	@Insert("INSERT INTO cart (mem_num,item_num,item_quantity,cart_price) VALUES (#{mem_num},#{item_num},#{item_quantity},#{cart_price})")
	public void insertCart(CartVO cart);
	@Update("UPDATE cart set item_quantity=#{item_quantity},cart_price=#{cart_price},cart_date=SYSTIMESTAMP WHERE mem_num=#{mem_num} AND item_num=#{item_num}")
	public void updateCart(CartVO cart);
	@Update("UPDATE cart set item_quantity=#{item_quantity},cart_price=#{cart_price},cart_date=SYSTIMESTAMP WHERE mem_num=#{mem_num} AND item_num=#{item_num}")
	public void updateCart2(CartVO cart);
	@Update("UPDATE cart set cart_date=SYSTIMESTAMP,cart_check=1 WHERE mem_num=#{mem_num},cart_check=0")
	public void updateCartDate(CartVO cart);
	@Select("SELECT * FROM cart WHERE mem_num=#{mem_num} AND item_num=#{item_num}")
	public CartVO getCart(CartVO cart);
	@Delete("DELETE FROM cart WHERE mem_num=#{mem_num} AND item_num=#{item_num}")
	public void deleteSmallCart(CartVO cart);
}
