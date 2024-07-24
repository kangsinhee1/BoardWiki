package kr.spring.donation.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class DonationVO {
	private Long don_num;
    private int don_point;
    private String don_content;
    private Date don_date;
    private Long str_num;
    private Long mem_num;
    private String mem_nickName;
}
