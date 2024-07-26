package kr.spring.order.vo;

import java.sql.Timestamp;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NotBlank
public class OrderVO {
	private Long order_num;
	private Long mem_num;
	
	private String order_name;
	private String order_phone;
	private Long order_zipcode;
	private String order_address1;
	private String order_address2;	
	private Long order_price;
	private int order_check;
	private Timestamp order_date;
	private int order_pay;
	
	private int cart_price;
	private int item_quantity;
	private int cart_check;
	private Timestamp cart_date;
	
	private Long item_num;
	private String item_num_list;
	private String item_quantity_list;
	private String cart_price_list;
	private Long total_price;
}
