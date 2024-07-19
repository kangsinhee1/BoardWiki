package kr.spring.contest.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ContestVO {

    private Long conNum;
    private Long memNum;
    private String conName;
    private String conContent;
    private String conLocation;
    private Date conRdate;
    private Integer conHit;
    private Integer conStatus;
    private Integer conFav;
    private String conSdate;
    private String conEdate;
}