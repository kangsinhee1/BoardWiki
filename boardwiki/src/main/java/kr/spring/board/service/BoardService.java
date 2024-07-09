package kr.spring.board.service;

import java.util.List;
import java.util.Map;

import kr.spring.board.vo.BoardFavVO;
import kr.spring.board.vo.BoardReplyVO;
import kr.spring.board.vo.BoardVO;

public interface BoardService {
	//부모글
	public List<BoardVO> selectList(Map<String,Object> map);
	public Integer selectRowCount(Map<String,Object> map);
	public void insertBoard(BoardVO board);
	public BoardVO selectBoard(Long boa_num);
	public void updateHit(Long boa_num);
	public void updateBoard(BoardVO board);
	public void deleteBoard(Long boa_num);
	public void deleteFile(Long boa_num);
	//부모글 좋아요
	public BoardFavVO selectFav(BoardFavVO fav);
	public Integer selectFavCount(Long boa_num);
	public void insertFav(BoardFavVO fav);
	public void deleteFav(BoardFavVO fav);
	//댓글
	public List<BoardReplyVO> selectListReply(Map<String,Object> map);
	public Integer selectRowCountReply(Map<String,Object> map);
	public BoardReplyVO selectReply(Long boaR_num);
	public void insertReply(BoardReplyVO boardReply);
	public void updateReply(BoardReplyVO boardReply);
	public void deleteReply(Long boaR_num);
}
