package kr.spring.member.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MemberVO {
	private long mem_num;//회원번호
	private String mem_email;//회원 이메일(아이디)
	private String mem_auth;//회원 등급
	
	private String mem_name;
	private String mem_nickName;
	private String mem_passwd;
	private String mem_phone;
	private String mem_provider;
	private Date mem_rdate;
	private Date mem_mdate;
	private String mem_photo;
}
