package kr.spring.tnrboard.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.board.vo.BoardReplyVO;
import kr.spring.tnrboard.vo.TnrboardFavVO;
import kr.spring.tnrboard.vo.TnrboardReplyVO;
import kr.spring.tnrboard.vo.TnrboardVO;

@Mapper
public interface TnrboardMapper {
	//게시글
	public List<TnrboardVO> selectTnrList(Map<String,Object> map);
	public List<TnrboardVO> selectTnrMyList(Map<String,Object> map);
	public Integer selectTnrRowCount(Map<String,Object> map);
	public Integer selectTnrRowmyCount(Map<String,Object> map);
	public void insertTnrBoard(TnrboardVO tnrboard);
	@Select("SELECT * FROM tnrboard JOIN member USING(mem_num) LEFT OUTER JOIN member_detail USING(mem_num) LEFT OUTER JOIN item USING(item_num) WHERE tnr_num=#{tnr_num}")
	public TnrboardVO selectTnrBoard(Long tnr_num);
	@Update("UPDATE tnrboard SET tnr_hit=tnr_hit+1 WHERE tnr_num=#{tnr_num}")
	public void updateTnrHit(Long tnr_num);
	public void updateTnrBoard(TnrboardVO tnrboard);
	@Delete("DELETE FROM tnrboard WHERE tnr_num=#{tnr_num}")
	public void deleteTnrBoard(Long tnr_num);
	@Update("UPDATE tnrboard SET filename='' WHERE tnr_num=#{tnr_num}")
	public void deleteTnrboardFile(Long tnr_num);
	
	//게시글 좋아요
	@Select("SELECT * FROM tnrboard_fav WHERE tnr_num=#{tnr_num} AND mem_num=#{mem_num}")
	public TnrboardFavVO selectTnrFav(TnrboardFavVO fav);
	@Select("SELECT COUNT(*) FROM tnrboard_fav WHERE tnr_num=#{tnr_num}")
	public Integer selectTnrFavCount(Long tnr_num);
	@Insert("INSERT INTO tnrboard_fav (tnr_num,mem_num) VALUES (#{tnr_num},#{tnr_num})")
	public void insertTnrFav(TnrboardFavVO fav);
	@Delete("DELETE FROM tnrboard_fav WHERE tnr_num=#{tnr_num} AND mem_num=#{mem_num}")
	public void deleteTnrFav(TnrboardFavVO fav);
	@Delete("DELETE FROM tnrboard_fav WHERE tnr_num=#{tnr_num}")
	public void deleteFavByTnrboardNum(Long tnr_num);
	
	//댓글
	public List<TnrboardReplyVO> selectTnrListReply(Map<String,Object> map);
	@Select("SELECT COUNT(*) FROM tnrboard_reply WHERE tnr_num=#{tnr_num}")
	public Integer selectTnrRowCountReply(Map<String,Object> map);
	//댓글 수정,삭제시 작성자 회원번호를 구하기 위해 사용
	@Select("SELECT * FROM tnrboard_reply WHERE tnrR_num=#{tnrR_num}")
	public TnrboardReplyVO selectTnrReply(Long tnrR_num);
	public void insertTnrReply(TnrboardReplyVO tnrboardReply);
	@Update("UPDATE tnrboard_reply SET tnrR_content=#{tnrR_content},tnrR_mdate=SYSDATE WHERE tnrR_num=#{tnrR_num}")
	public void updateTnrReply(TnrboardReplyVO tnrboardReply);
	@Delete("DELETE FROM tnrboard_reply WHERE tnrR_num=#{tnrR_num}")
	public void deleteTnrReply(Long tnrR_num);
	//부모글 삭제시 댓글이 존재하면 부모글 삭제전 댓글 삭제
	@Delete("DELETE FROM tnrboard_reply WHERE tnr_num=#{tnr_num}")
	public void deleteReplyByTnrboardNum(Long tnr_num);
	
}


















