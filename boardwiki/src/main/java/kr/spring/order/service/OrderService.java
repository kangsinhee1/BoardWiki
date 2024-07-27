package kr.spring.order.service;

import java.util.List;

import kr.spring.cart.vo.CartVO;
import kr.spring.order.vo.OrderVO;

public interface OrderService {

	public void insertOrder(OrderVO order);
	public OrderVO selectOrderDetail(Long order_num);
	public OrderVO selectOrderUser(Long mem_num);
	public List<OrderVO> selectOrderList(Long mem_num);
	public List<CartVO> selectCartList(Long mem_num);
	public List<CartVO> getnumList(Long mem_num);
	public List<CartVO> getpriceList(Long mem_num);
	public OrderVO selectagg(Long mem_num);
}
