package kr.spring.contest.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import kr.spring.contest.vo.ContestVO;

@Mapper
public interface ContestMapper {
	//모임 관리( 관리자)
	@Select("SELECT contest_seq.nextval FROM dual")
	public Long selectTea_num();
	//목록보기
	public Integer selectRowCount(Map<String,Object>map);
	//대회리스트
	public List<ContestVO> selectContestList(Map<String,Object>map);
}
