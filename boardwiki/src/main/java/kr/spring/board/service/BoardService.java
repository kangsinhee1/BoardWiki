package kr.spring.board.service;

import java.util.List;
import java.util.Map;

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
	
}
