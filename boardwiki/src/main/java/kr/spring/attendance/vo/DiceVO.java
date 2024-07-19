package kr.spring.attendance.vo;

import java.time.LocalDate;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class DiceVO {
	private Long dice_num;
    private int dice_chance;
    private Long mem_num;
    private LocalDate dice_date;
    private int dice_val;
}
