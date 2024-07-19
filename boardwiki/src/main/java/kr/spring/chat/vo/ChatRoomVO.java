package kr.spring.chat.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ChatRoomVO {
	private long chaR_num; //채팅방 번호
	private long chaR_status; //채팅방 처리(활성,비활성)
	private String chaR_name; //채팅방 이름
	private String chaR_date; //채팅방 생성 시간
	
	private long[] members; //채팅 멤버들
	private long mem_num;	//채팅방 생성자
	private int chaT_cnt; //해당 채팅방에 읽지 않은 메시지 수 
	private int room_cnt;
	
	private ChatTextVO chatTextVO;
	private ChatMemberVO chatMemberVO;
	private long tea_num; //모임 식별 번호
	
}
