package kr.spring.board.vo;

import kr.spring.util.DurationFromNow;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BoardReplyVO {
	private long boaR_num;			//댓글 번호
	private String boaR_content;	//내용
	private String boaR_rdate;		//등록일
	private String boaR_mdate;		//수정일
	private long boa_num;			//부모글 번호
	private long mem_num;			//작성자 회원번호
	
	private Integer mem_auth;
	private String mem_email;			//아이디
	private String mem_nickname;		//별명
	
	//로그인 한 상태에서 클릭한 사람의 정보 읽기, 로그인하지 않으면 0 전달
	private int click_num;		
	
	
	public void setRe_date(String boaR_rdate) {
		this.boaR_rdate = 
			    DurationFromNow.getTimeDiffLabel(boaR_rdate);
	}
	public void setRe_mdate(String boaR_mdate) {
		this.boaR_mdate = 
				DurationFromNow.getTimeDiffLabel(boaR_mdate);
	}
	
}











