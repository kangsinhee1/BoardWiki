package kr.spring.cart.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CartVO {
	private Long mem_num;
	private Long item_num;
	private Long item_quantity;
}
