package kr.spring.usedChat.vo;


import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class UsedChatRoomVO {
	private long useC_num;		//채팅방 고유번호
	private int useC_status;	//채팅방 활성화 비활성화
	private String useC_name; 	//채팅방이름
	private Date useC_date;		//채팅방개설일

	private Long use_num;		//중고글 번호
	private Long mem_num;		//구매의사 보유자
	private Long seller; // 판매자 회원번호

	private String item_name;
	private UsedChat_textVO usedChat_textVO;
	private Long useC_grade; //판매자 평점
}
