package kr.spring.team.vo;

import java.sql.Date;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class TeamVO {
	private long tea_num; 	//모임번호를 식별하는 번호
	@NotBlank
	private String tea_name; 	// 등록할 모임의 이름
	@NotEmpty
	private String tea_content; 	//모임에 대한 설명
	private String tea_time; 	 //모임이 진행되는 날짜
	@Size(min=5,max=5)
	private String tea_zipcode;//모임을 진행할 장소(지도API)
	@NotBlank
	private String tea_address1;
	@NotBlank
	private String tea_address2;
	private Date tea_rdate; 		//모임을 등록한 날짜
	private long tea_man; 	// 최대 모집인원 설정 가능(최대 99)
	private long tea_hit; //	모임창 클릭 조회수
	private long tea_status; 	//신고처리시 모임 비활성화(기본1,비활:0)

	private long mem_num; // 회원번호
	private String mem_email;		//아이디
	private String mem_nickname;		//아이디

	private int fav_cnt;			//좋아요 개수
	private long teaA_status;
}
