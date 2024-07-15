package kr.spring.stream.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BroadcastVO {
	private Long strD_num;
    private Long mem_num;
    private Long str_num;
    private String str_key;
    private int isLive;
}