package kr.spring.rulebook.vo;

import java.sql.Date;

import javax.validation.constraints.NotEmpty;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class RulebookVO {
	private long rulB_num;
	private long item_num;
	private long mem_num;
	@NotEmpty
	private String rulB_content;
	private MultipartFile upload;
	private String filename;
	private Date rulB_rdate;
	private Date rulB_mdate;
	
	private String item_name;
}
