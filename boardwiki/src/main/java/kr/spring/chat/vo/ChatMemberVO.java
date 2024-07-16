package kr.spring.chat.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ChatMemberVO {
	private long chaR_num; //채팅방 번호
	private String chaR_name;// 채팅방 이름
	private long mem_num; //멤버 회원 번호
	
	private String mem_nickname; //멤버 닉네임
}
