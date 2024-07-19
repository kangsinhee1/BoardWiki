package kr.spring.tnrboard.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.tnrboard.vo.TnrboardVO;

@Mapper
public interface TnrboardMapper {
	//게시글
	public List<TnrboardVO> selectTnrList(Map<String,Object> map);
	public List<TnrboardVO> selectTnrMyList(Map<String,Object> map);
	public Integer selectTnrRowCount(Map<String,Object> map);
	public Integer selectTnrRowmyCount(Map<String,Object> map);
	public void insertTnrBoard(TnrboardVO tnrboard);
	@Select("SELECT * FROM tnrboard JOIN member USING(mem_num) LEFT OUTER JOIN member_detail USING(mem_num) WHERE boa_num=#{boa_num}")
	public TnrboardVO selectTnrBoard(Long tnr_num);
	@Update("UPDATE tnrboard SET boa_hit=boa_hit+1 WHERE boa_num=#{boa_num}")
	public void updateTnrHit(Long tnr_num);
	public void updateTnrBoard(TnrboardVO tnrboard);
	@Delete("DELETE FROM tnrboard WHERE boa_num=#{boa_num}")
	public void deleteTnrBoard(Long tnr_num);
	@Update("UPDATE tnrboard SET filename='' WHERE boa_num=#{boa_num}")
	public void deleteTnrFile(Long tnr_num);
	
	
}


















