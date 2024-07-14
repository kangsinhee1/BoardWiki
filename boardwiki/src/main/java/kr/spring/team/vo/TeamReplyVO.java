package kr.spring.team.vo;

import java.sql.Date;

import kr.spring.util.DurationFromNow;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
@Getter
@Setter
@ToString
public class TeamReplyVO {
	private long teaR_num;
	private String teaR_content;
	private long teaR_status;
	private String teaR_rdate;
	private String teaR_mdate;
	private String teaB_num;
	private long mem_num;
	private String mem_email;
	private String mem_nickname;
	private long click_num; //클릭한 사람의 회원정보
	
	private long teaR_cnt; //댓글수
	
	public void setTeaR_rdate(String teaR_rdate) {
		this.teaR_rdate = DurationFromNow.getTimeDiffLabel(teaR_rdate);
	}
	public void setTeaR_mdate(String teaR_mdate) {
		this.teaR_mdate = DurationFromNow.getTimeDiffLabel(teaR_mdate);
	}
}
