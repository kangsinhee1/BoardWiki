package kr.spring.contest.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ContestVO {

    private Long con_num;
    private Long mem_num;
    private String con_name;
    private String con_content;
    private String con_location;
    private Date con_rdate;
    private Integer con_hit;
    private Integer con_status;
    private Integer con_fav;
    private String con_sdate;
    private String con_edate;
    
    private String mem_auth;
}
