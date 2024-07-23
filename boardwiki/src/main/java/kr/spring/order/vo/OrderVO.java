package kr.spring.order.vo;

import java.sql.Date;

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
	private Long item_num;
	@NotEmpty
	private String order_name;
	@NotEmpty
	private String order_phone;
	@NotEmpty
	private Long order_zipcode;
	@NotEmpty
	private String order_address1;
	@NotEmpty
	private String order_address2;
	private Date order_reg_date;
	private Long order_price;
	private int order_check;
}
