package kr.spring.attendance.vo;

import java.time.LocalDate;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class AttendanceVO {
	private Long att_num;
	private LocalDate att_date;
	private int att_status;
	private Long mem_num;
}
