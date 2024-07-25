package kr.spring.mission.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MissionVO {
	private Long mis_num;
	private int mis_point;
	private String mis_content;
	private int mis_status;
	private Date mis_date;
	private Long str_num;
	private Long mem_num;
	private String mem_nickName;
}
