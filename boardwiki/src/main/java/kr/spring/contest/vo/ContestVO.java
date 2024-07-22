package kr.spring.contest.vo;

import java.sql.Date;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

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
    
    @Size(min=5,max=5)
	private String con_zipcode;//모임을 진행할 장소(지도API)
	@NotBlank
	private String con_address1;
	@NotBlank
	private String con_address2;
	
    private Date con_rdate;
    private Integer con_hit;
    private Integer con_status;
    private Integer con_fav;
    private String con_sdate;
    private String con_edate;
    private Integer con_man;	//참가인원
    private Integer con_maxman;//최대인원
    
    private String mem_auth;
}
