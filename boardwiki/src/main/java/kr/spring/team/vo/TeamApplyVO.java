package kr.spring.team.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class TeamApplyVO {
 
 private long teaA_num;
 private long teaA_status;
 private String teaA_time;
 private long teaA_attend;
 private String teaA_content;
 private long teaA_auth;
 private long tea_num;
 private long mem_num;
 private String mem_email;
 private String mem_nickname;
 private String tea_name;
 private long tea_status; 	//신고처리시 모임 비활성화(기본1,비활:0)
 
}
