package kr.spring.calendar.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class EventVO {
	private Long id;
    private Long memNum;
    private String title;
    private String startDate;
    private String endDate;

    // Getters and Setters
}