package kr.spring.tnrboard.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.tnrboard.dao.TnrboardMapper;
import kr.spring.tnrboard.vo.TnrboardFavVO;
import kr.spring.tnrboard.vo.TnrboardReplyVO;
import kr.spring.tnrboard.vo.TnrboardVO;


@Service
@Transactional
public class TnrboardServiceImpl implements TnrboardService{
	@Autowired
	TnrboardMapper tnrboardMapper;

	@Override
	public List<TnrboardVO> selectTnrList(Map<String, Object> map) {
		return tnrboardMapper.selectTnrList(map);
	}

	@Override
	public List<TnrboardVO> selectTnrMyList(Map<String, Object> map) {
		return tnrboardMapper.selectTnrMyList(map);
	}

	@Override
	public Integer selectTnrRowCount(Map<String, Object> map) {
		return tnrboardMapper.selectTnrRowCount(map);
	}

	@Override
	public Integer selectTnrRowmyCount(Map<String, Object> map) {
		return tnrboardMapper.selectTnrRowmyCount(map);
	}

	@Override
	public void insertTnrBoard(TnrboardVO tnrboard) {
		tnrboardMapper.insertTnrBoard(tnrboard);
	}

	@Override
	public TnrboardVO selectTnrBoard(Long tnr_num) {
		return tnrboardMapper.selectTnrBoard(tnr_num);
	}

	@Override
	public void updateTnrHit(Long tnr_num) {
		tnrboardMapper.updateTnrHit(tnr_num);
	}

	@Override
	public void updateTnrBoard(TnrboardVO tnrboard) {
		tnrboardMapper.updateTnrBoard(tnrboard);
	}

	@Override
	public void deleteTnrBoard(Long tnr_num) {
		tnrboardMapper.deleteTnrBoard(tnr_num);
	}

	@Override
	public void deleteTnrboardFile(Long tnr_num) {
		tnrboardMapper.deleteTnrboardFile(tnr_num);
	}

	@Override
	public TnrboardFavVO selectTnrFav(TnrboardFavVO fav) {
		return tnrboardMapper.selectTnrFav(fav);
	}

	@Override
	public Integer selectTnrFavCount(Long tnr_num) {
		return tnrboardMapper.selectTnrFavCount(tnr_num);
	}

	@Override
	public void insertTnrFav(TnrboardFavVO fav) {
		tnrboardMapper.insertTnrFav(fav);
	}

	@Override
	public void deleteTnrFav(TnrboardFavVO fav) {
		tnrboardMapper.deleteTnrFav(fav);
	}

	@Override
	public List<TnrboardReplyVO> selectTnrListReply(Map<String, Object> map) {
		return tnrboardMapper.selectTnrListReply(map);
	}

	@Override
	public Integer selectTnrRowCountReply(Map<String, Object> map) {
		return tnrboardMapper.selectTnrRowCountReply(map);
	}

	@Override
	public TnrboardReplyVO selectTnrReply(Long tnrR_num) {
		return tnrboardMapper.selectTnrReply(tnrR_num);
	}


	@Override
	public void insertTnrReply(TnrboardReplyVO tnrboardReply) {
		tnrboardMapper.insertTnrReply(tnrboardReply);
	}

	@Override
	public void updateTnrReply(TnrboardReplyVO tnrboardReply) {
		tnrboardMapper.updateTnrReply(tnrboardReply);
	}

	@Override
	public void deleteTnrReply(Long tnrR_num) {
		tnrboardMapper.deleteTnrReply(tnrR_num);
	}

	@Override
	public void updateTnrBoardAuth(Long tnr_num, Long tnr_auth) {
		tnrboardMapper.updateTnrBoardAuth(tnr_num, tnr_auth);
	}



}
