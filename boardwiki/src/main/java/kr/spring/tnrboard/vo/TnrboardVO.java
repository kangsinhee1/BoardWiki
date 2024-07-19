package kr.spring.tnrboard.vo;

import java.sql.Date;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class TnrboardVO {
	private long tnr_num;
	private long item_num;
	private long mem_num;
	@NotBlank
	private String tnr_category;
	@NotBlank
	private String tnr_title;	
	@NotEmpty
	private String tnr_content;
	private int tnr_hit;
	private Date tnr_rdate;
	private Date tnr_mdate;
	private int tnr_auth;
	private MultipartFile upload; 
	private String filename;
	
	
	
	private String mem_email;				
	private String mem_nickname;
	private Integer mem_auth;
	private String item_name;
	
	private int re_cnt;				
	private int fav_cnt; 
	
}
