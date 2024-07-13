package kr.spring.cart.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CartVO {
	private long mem_num;
	private long item_num;
	private long item_quantity;
}
