package kr.spring.contest.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ContestApplyVO {
	private Long cona_num;
	private Long con_num;
	private Long mem_num;
	private Integer cona_status;
	private Date cona_rdate;
	private String mem_email;
	private String mem_nickname;
}
