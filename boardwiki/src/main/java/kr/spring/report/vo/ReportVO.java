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


	private String mem_nickName;

	private Long mem_num;

	//board
	private String boa_title;
	private Long boa_num;
	private int boa_auth;

	//team
	private String tea_name;
	private Long tea_num;
	private int tea_status;

	//used
	private String use_title;
	private Long use_num;
	private int use_auth;

	//tnr
	private String tnr_title;
	private Long tnr_num;
	private int tnr_auth;
}
