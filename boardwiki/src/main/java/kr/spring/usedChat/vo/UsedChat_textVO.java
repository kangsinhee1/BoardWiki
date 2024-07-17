package kr.spring.usedChat.vo;



import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class UsedChat_textVO {
	private long chaC_num;		//채팅방 고유번호
	private Long useC_num; 		//채팅방 이름
	private String chaC_txt;	//채팅내용
	private String chaC_time;		//채팅 친 시간
	private int chaC_status;	//활성화비활성화
	private int chaC_check;		//확인
	
	private Long mem_num;		//구매의사 보유자
	private String mem_nickname;//닉네임
}
