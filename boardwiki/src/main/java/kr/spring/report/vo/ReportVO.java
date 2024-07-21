package kr.spring.report.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@Getter
@Setter
@ToString
public class ReportVO {
	private Long report_num;		//신고 고유번호
	private Long reporter_num;		//신고자 고유번호
	private String report_content;	//신고 내용
	private Date report_date;		//신고 접수일
	private int report_category;	//신고 유형
	private int report_type;		//신고 분류(게시판)
	private	Long report_typeDetail;	//신고된 글이나 댓글 고유 번호
	
}
