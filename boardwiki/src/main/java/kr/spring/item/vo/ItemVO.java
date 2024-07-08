package kr.spring.item.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ItemVO {
	private Long item_num;
	private String item_id;
	private String item_name;
	private Long item_rank;//순위
	private Long item_average;//평점
	private String item_genre;//장르
	private String item_thumbnail;//썸네일
	private String minage;//최소 연령
	private String minplayers;//최소 플레이어수
	private String maxplayers;//최대 플레이어수
	private String description;//간단 설명
	private String item_year;//출시연도
	private int item_stock;//재고
	private Date item_reg_date;//등록일
}
