package kr.spring.stream.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class StreamCreatingVO {
	private long mem_num;
	private long str_num;
	private long strc_num;
	private long strt_num;
	private String strt_chat;
	private Date strt_date;
}
