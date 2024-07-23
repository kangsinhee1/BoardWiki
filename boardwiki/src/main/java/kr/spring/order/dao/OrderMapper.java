package kr.spring.order.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import kr.spring.cart.vo.CartVO;
import kr.spring.order.vo.OrderVO;

@Mapper
public interface OrderMapper {
	//상품주문
	public void insertOrder(OrderVO order);

	public OrderVO selectOrderDetail(Long order_num);

	public OrderVO selectOrderUser(Long mem_num);
	@Select("SELECT * FROM order WHERE mem_num=#{mem_num}")
	public List<OrderVO> selectOrderList(Long mem_num);
	@Select("SELECT * FROM cart WHERE mem_num=#{mem_num}")
	public List<CartVO> selectCartList(Long mem_num);
	@Select("SELECT item_num FROM cart WHERE mem_num=#{mem_num}")
	public List<CartVO> getnumList(Long mem_num);
	@Select("SELECT cart_price FROM cart WHERE mem_num=#{mem_num}")
	public List<CartVO> getpriceList(Long mem_num);
}
