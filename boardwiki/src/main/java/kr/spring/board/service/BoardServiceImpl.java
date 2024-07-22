package kr.spring.board.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.board.dao.BoardMapper;
import kr.spring.board.vo.BoardFavVO;
import kr.spring.board.vo.BoardReplyVO;
import kr.spring.board.vo.BoardVO;

@Service
@Transactional
public class BoardServiceImpl implements BoardService{
	@Autowired
	BoardMapper boardMapper;

	@Override
	public List<BoardVO> selectList(Map<String, Object> map) {
		return boardMapper.selectList(map);
	}

	@Override
	public Integer selectRowCount(Map<String, Object> map) {
		return boardMapper.selectRowCount(map);
	}

	@Override
	public void insertBoard(BoardVO board) {
		boardMapper.insertBoard(board);
	}

	@Override
	public BoardVO selectBoard(Long boa_num) {
		return boardMapper.selectBoard(boa_num);
	}

	@Override
	public void updateHit(Long boa_num) {
		boardMapper.updateHit(boa_num);
	}

	@Override
	public void updateBoard(BoardVO board) {
		boardMapper.updateBoard(board);
	}

	@Override
	public void deleteBoard(Long boa_num) {
		boardMapper.deleteBoard(boa_num);
	}

	@Override
	public void deleteFile(Long boa_num) {
		boardMapper.deleteFile(boa_num);
	}

	@Override
	public BoardFavVO selectFav(BoardFavVO fav) {
		return boardMapper.selectFav(fav);
	}

	@Override
	public Integer selectFavCount(Long boa_num) {
		return boardMapper.selectFavCount(boa_num);
	}

	@Override
	public void insertFav(BoardFavVO fav) {
		boardMapper.insertFav(fav);
	}

	@Override
	public void deleteFav(BoardFavVO fav) {
		boardMapper.deleteFav(fav);
	}

	@Override
	public List<BoardReplyVO> selectListReply(Map<String, Object> map) {
		return boardMapper.selectListReply(map);
	}

	@Override
	public Integer selectRowCountReply(Map<String, Object> map) {
		return boardMapper.selectRowCountReply(map);
	}

	@Override
	public BoardReplyVO selectReply(Long boaR_num) {
		return boardMapper.selectReply(boaR_num);
	}

	@Override
	public void insertReply(BoardReplyVO boardReply) {
		boardMapper.insertReply(boardReply);
	}

	@Override
	public void updateReply(BoardReplyVO boardReply) {
		boardMapper.updateReply(boardReply);
	}

	@Override
	public void deleteReply(Long boaR_num) {
		boardMapper.deleteReply(boaR_num);
	}

	@Override
	public Integer selectRowmyCount(Map<String, Object> map) {
		return boardMapper.selectRowmyCount(map);
	}

	@Override
	public List<BoardVO> selectMyList(Map<String, Object> map) {
		return boardMapper.selectMyList(map);
	}

	@Override
	public Integer selectAdminReply(Long boa_num) {
		return boardMapper.selectAdminReply(boa_num);
	}


}
