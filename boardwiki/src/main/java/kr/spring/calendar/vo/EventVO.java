package kr.spring.calendar.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class EventVO {
	private Long calendar_num;
    private Long mem_num;
    private String title;
    private Date startDate;
    private Date endDate;

    // Getters and Setters
}