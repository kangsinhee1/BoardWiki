package kr.spring.tnrboard.vo;

import kr.spring.util.DurationFromNow;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class TnrboardReplyVO {
	private long tnrR_num;			//댓글 번호
	private String tnrR_content;	//내용
	private String tnrR_rdate;		//등록일
	private String tnrR_mdate;		//수정일
	private long tnr_num;			//부모글 번호
	private long mem_num;			//작성자 회원번호
	
	private Integer mem_auth;
	private String mem_email;			//아이디
	private String mem_nickname;		//별명
	
	//로그인 한 상태에서 클릭한 사람의 정보 읽기, 로그인하지 않으면 0 전달
	private int click_num;		
	
	
	public void setRe_date(String tnrR_rdate) {
		this.tnrR_rdate = 
			    DurationFromNow.getTimeDiffLabel(tnrR_rdate);
	}
	public void setRe_mdate(String tnrR_mdate) {
		this.tnrR_mdate = 
				DurationFromNow.getTimeDiffLabel(tnrR_mdate);
	}
	
}











