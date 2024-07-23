package kr.spring.point.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PointVO {
	private long point_total; 	//총 포인트
	private long mem_num;		//회원번호
	private long poi_num;		//포인트 고유 번호
	private int poi_status;		//포인트 사용 유형 1:도네이션,2:미션,3:포인트게임
	private int poi_increase;   //1:사용, 2:획득
	private int poi_use;		//사용 포인트
	private Date poi_date;		//사용일
	private long poi_re;         //변경전 포인트
}
