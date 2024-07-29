package kr.spring.used.vo;

import java.sql.Date;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class UsedItemVO {
	private long use_num;
	private long mem_num;
	private long item_num;
	private int use_auth;

	@NotBlank
	@Size(max = 150, message = "제목은 최대 150자까지 입력 가능합니다")
	private String use_title;
	@NotEmpty
	private String use_content;

	private String use_comment;
	private long use_grade;
	private MultipartFile use_upload;
	private String use_photo;
	private int use_price;
	private int use_check;
	private Date use_rdate;
	private Date use_mdate;

	private String mem_email;
	private String item_name;
	private String mem_nickname;

	private Long useC_grade;

}
