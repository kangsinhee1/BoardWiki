package kr.spring.rulebook.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.rulebook.vo.RulebookVO;



@Mapper
public interface RulebookMapper {
	//게시글
	public List<RulebookVO> selectRulebookList(Map<String,Object> map);
	public Integer selectRulebookRowCount(Map<String,Object> map);
	public void insertRulebook(RulebookVO rulebook);
	@Select("SELECT * FROM rulebook JOIN member USING(mem_num) LEFT OUTER JOIN member_detail USING(mem_num) WHERE rulB_num=#{rulB_num}")
	public RulebookVO selectRulebook(Long rulB_num);
	public void updateRulebook(RulebookVO rulebook);
	@Delete("DELETE FROM rulebook WHERE rulB_num=#{rulB_num}")
	public void deleteRulebook(Long rulB_num);
	@Update("UPDATE rulebook SET rulB_filename='' WHERE rulB_num=#{rulB_num}")
	public void deleteRulebookFile(Long rulB_num);
}
