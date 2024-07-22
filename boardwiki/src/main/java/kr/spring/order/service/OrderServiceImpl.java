package kr.spring.order.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.spring.cart.vo.CartVO;
import kr.spring.order.dao.OrderMapper;
import kr.spring.order.vo.OrderVO;

@Service
@Transactional
public class OrderServiceImpl implements OrderService{

	@Autowired
	OrderMapper orderMapper;

	@Override
	public void insertOrder(OrderVO order) {
		orderMapper.insertOrder(order);
	}

	@Override
	public OrderVO selectOrderDetail(Long order_num) {
		return orderMapper.selectOrderDetail(order_num);
	}

	@Override
	public OrderVO selectOrderUser(Long mem_num) {
		return orderMapper.selectOrderUser(mem_num);
	}

	@Override
	public List<OrderVO> selectOrderList(Long mem_num) {
		return orderMapper.selectOrderList(mem_num);
	}

	@Override
	public List<CartVO> selectCartList(Long mem_num) {
		return orderMapper.selectCartList(mem_num);
	}

}
