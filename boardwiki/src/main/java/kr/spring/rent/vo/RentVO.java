package kr.spring.rent.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class RentVO {
	private long rent_num;		// 대여번호
	private String rent_sdate;	// 대여시작일
	private String rent_edate;	// 대여종료일
	private long rent_period;	// 대여기간
	private long mem_num;		// 회원본호
	private long item_num;		// 상품번호
}
