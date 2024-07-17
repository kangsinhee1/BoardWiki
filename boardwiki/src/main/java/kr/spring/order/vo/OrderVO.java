package kr.spring.order.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString

public class OrderVO {
	private Long order_num;
	private Long mem_num;
	private Long item_num;
	private String order_name;
	private String order_phone;
	private Long order_zipcode;
	private String order_address1;
	private String order_address2;
	private int order_pay;
	private int order_check;
	private Date order_reg_date;
}
