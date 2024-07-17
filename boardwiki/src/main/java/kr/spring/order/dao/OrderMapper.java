package kr.spring.order.dao;

import org.apache.ibatis.annotations.Mapper;

import kr.spring.order.vo.OrderVO;

@Mapper
public interface OrderMapper {
	//상품주문
	public void insertOrder(OrderVO order);
	
	public OrderVO selectOrderDetail(Long order_num);
	
	public OrderVO selectOrderUser(Long mem_num);
}
