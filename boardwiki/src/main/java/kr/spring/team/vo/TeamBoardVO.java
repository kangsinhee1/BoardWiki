package kr.spring.team.vo;

import javax.validation.constraints.NotBlank;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
@Getter
@Setter
@ToString
public class TeamBoardVO {
	private long teaB_num; //글번호
	private long teaB_status; //글 상태
	@NotBlank
	private String teaB_title; //글제목
	@NotBlank
	private String teaB_content;//글 내용
	private String teaB_rdate; //등록일
	private String teaB_mdate; //수정일
	private String tea_rdate;
	private Long teaB_category; //카테고리 분류
	private String filename;
	private MultipartFile upload; //파일
	private long teaA_status;
	private long tea_status;
	private String tea_name;
	private long tea_num;
	private long teaA_auth;
	private long mem_num;
	private String mem_email;
	private String mem_nickname;
	private int teaR_cnt;
	private int teaB_hit;
}
