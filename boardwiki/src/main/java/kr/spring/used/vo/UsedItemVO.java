package kr.spring.used.vo;

import java.sql.Date;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class UsedItemVO {
	private long use_num;
	private long mem_num;
	private long item_num;
	@NotBlank
	private String use_title;
	@NotEmpty
	private String use_content;
	private String use_comment;
	private int use_grade;
	private String use_photo;
	@Max(value=999999999)
	@Min(value=0)
	private int use_price;
	private int use_check;
	private Date use_rdate;
	private Date use_mdate;
	
	private String mem_email;
	private String item_name;
	
}
