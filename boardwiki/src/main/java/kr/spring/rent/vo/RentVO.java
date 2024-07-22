package kr.spring.rent.vo;

import javax.validation.constraints.NotBlank;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class RentVO {
	private long rent_num;		// 대여번호
	@NotBlank
	private String rent_sdate;	// 대여시작일
	@NotBlank
	private String rent_edate;	// 대여종료일
	private long rent_period;	// 대여기간
	private long mem_num;		// 회원본호
	private long item_num;		// 상품번호
	private long rent_status;	// 대여상태(0: 대여 가능, 1: 대여중, 2: 반납)


	private String item_name;	// 상품이름
	private String mem_email;
	private String mem_nickname;
}
