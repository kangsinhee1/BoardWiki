package kr.spring.chat.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ChatTextVO {
	private long chaT_num; //채팅 번호
	private long chaR_num;  //채팅방 번호
	private long mem_num; //메시지 발신자

	private String chaT_txt; //메시지
	private String message; // 메시지 웹소켓
	private long chaT_status; //채팅메시지 활성화/신고처리
	private String chaT_time; // 채팅메시지 작성시간

	private int chaT_cnt; //메시지당 읽지 않은 수
	private int read_count; //메시지당 읽지 않은 수
	private String mem_nickname; //작성자

}
