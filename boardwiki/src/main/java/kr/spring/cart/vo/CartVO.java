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
	private int item_quantity;
	private Long cart_price;

	private String item_name;
	private Long item_price;//가격
	private String item_image;
	private String item_thumbnail;//썸네일
	private int item_stock;//재고
}
