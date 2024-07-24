package kr.spring.board.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.board.vo.BoardFavVO;
import kr.spring.board.vo.BoardReplyVO;
import kr.spring.board.vo.BoardVO;

@Mapper
public interface BoardMapper {
	//게시글
	public List<BoardVO> selectList(Map<String,Object> map);
	public List<BoardVO> selectMyList(Map<String,Object> map);
	public List<BoardVO> selectListForClient(Map<String,Object> map);
	public Integer selectRowCount(Map<String,Object> map);
	public Integer selectRowmyCount(Map<String,Object> map);
	public Integer selectClientRowCount(Map<String,Object> map);
	public void insertBoard(BoardVO board);
	@Select("SELECT * FROM board JOIN member USING(mem_num) LEFT OUTER JOIN member_detail USING(mem_num) WHERE boa_num=#{boa_num}")
	public BoardVO selectBoard(Long boa_num);
	@Update("UPDATE board SET boa_hit=boa_hit+1 WHERE boa_num=#{boa_num}")
	public void updateHit(Long boa_num);
	public void updateBoard(BoardVO board);
	@Delete("DELETE FROM board WHERE boa_num=#{boa_num}")
	public void deleteBoard(Long boa_num);
	@Update("UPDATE board SET filename='' WHERE boa_num=#{boa_num}")
	public void deleteFile(Long boa_num);

	//게시글 좋아요
	@Select("SELECT * FROM board_fav WHERE boa_num=#{boa_num} AND mem_num=#{mem_num}")
	public BoardFavVO selectFav(BoardFavVO fav);
	@Select("SELECT COUNT(*) FROM board_fav WHERE boa_num=#{boa_num}")
	public Integer selectFavCount(Long boa_num);
	@Insert("INSERT INTO board_fav (boa_num,mem_num) VALUES (#{boa_num},#{mem_num})")
	public void insertFav(BoardFavVO fav);
	@Delete("DELETE FROM board_fav WHERE boa_num=#{boa_num} AND mem_num=#{mem_num}")
	public void deleteFav(BoardFavVO fav);
	@Delete("DELETE FROM board_fav WHERE boa_num=#{boa_num}")
	public void deleteFavByBoardNum(Long boa_num);
	//관리자 댓글
	@Select("SELECT COUNT(*) FROM board JOIN (SELECT * FROM board_reply JOIN member USING (mem_num)) USING (boa_num) WHERE boa_num=#{boa_num} AND mem_auth=9 AND boa_category=5")
	public Integer selectAdminReply(Long boa_num);


	//댓글
	public List<BoardReplyVO> selectListReply(Map<String,Object> map);
	@Select("SELECT COUNT(*) FROM board_reply WHERE boa_num=#{boa_num}")
	public Integer selectRowCountReply(Map<String,Object> map);
	//댓글 수정,삭제시 작성자 회원번호를 구하기 위해 사용
	@Select("SELECT * FROM board_reply WHERE boaR_num=#{boaR_num}")
	public BoardReplyVO selectReply(Long boaR_num);
	public void insertReply(BoardReplyVO boardReply);
	@Update("UPDATE board_reply SET boaR_content=#{boaR_content},boaR_mdate=SYSDATE WHERE boaR_num=#{boaR_num}")
	public void updateReply(BoardReplyVO boardReply);
	@Delete("DELETE FROM board_reply WHERE boaR_num=#{boaR_num}")
	public void deleteReply(Long boaR_num);
	//부모글 삭제시 댓글이 존재하면 부모글 삭제전 댓글 삭제
	@Delete("DELETE FROM board_reply WHERE boa_num=#{boa_num}")
	public void deleteReplyByBoardNum(Long boa_num);
	
	//등급 수정
	@Update("UPDATE board SET boa_auth=#{boa_auth} WHERE boa_num=#{boa_num}")
	public void updateBoardAuth(Long boa_num, Long boa_auth);
	
	//메인 화면 표시
	@Select("SELECT *FROM (SELECT * FROM board ORDER BY boa_rdate DESC) WHERE ROWNUM = 1")
	public BoardVO selectMainBoard();
}


















