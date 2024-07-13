package kr.spring.stream.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BroadcastVO {
	private Long strD_Num;
    private Long mem_num;
    private String str_key;
    private boolean isLive;
}