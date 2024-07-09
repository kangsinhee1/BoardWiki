package kr.spring.board.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.board.vo.BoardVO;

@Mapper
public interface BoardMapper {
	//부모글
	public List<BoardVO> selectList(Map<String,Object> map);
	public Integer selectRowCount(Map<String,Object> map);
	public void insertBoard(BoardVO board);
	@Select("SELECT * FROM board JOIN member USING(mem_num) LEFT OUTER JOIN member_detail USING(mem_num) WHERE boa_num=#{boa_num}")
	public BoardVO selectBoard(Long boa_num);
	@Update("UPDATE board SET boa_hit=boa_hit+1 WHERE boa_num=#{boa_num}")
	public void updateHit(Long boa_num);
	public void updateBoard(BoardVO board);
	@Delete("DELETE FROM board WHERE boa_num=#{boa_num}")
	public void deleteBoard(Long boa_num);
	@Update("UPDATE board SET boa_file='' WHERE boa_num=#{boa_num}")
	public void deleteFile(Long boa_num);
	
}


















