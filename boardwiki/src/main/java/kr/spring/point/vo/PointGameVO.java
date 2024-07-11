package kr.spring.point.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PointGameVO {
	//포인트 게임
	private Long poiG_num; //게임번호
	private String poiG_content; //게임 제목
	private Date poiG_start;//게임시작 날짜
	private Date poiG_end;//게임종료 날짜
	private int str_num; //방송 구별 번호
	
	
	//포인트 게임 선택지
	private Long poiO_num;//선택지 고유번호
	private String poiO_content;//선택지 내용
	private int poiO_no; //선택지번호
	
	//포인트 게임 배팅
	private Long bet_num;//배팅 고유 번호
	private int bet_point;//배팅 포인트
	private Date bet_date;//배팅 날짜
	private Long mem_num;//회원 구분
	
	//조건 체크용
	private int poi_ck;//조건체크
}
