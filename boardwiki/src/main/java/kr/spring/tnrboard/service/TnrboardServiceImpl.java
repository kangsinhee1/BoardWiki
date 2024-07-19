package kr.spring.tnrboard.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.tnrboard.dao.TnrboardMapper;
import kr.spring.tnrboard.vo.TnrboardVO;


@Service
@Transactional
public class TnrboardServiceImpl implements TnrboardService{
	@Autowired
	TnrboardMapper tnrboardMapper;

	@Override
	public List<TnrboardVO> selectTnrList(Map<String, Object> map) {
		return null;
	}

	@Override
	public List<TnrboardVO> selectTnrMyList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Integer selectTnrRowCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Integer selectTnrRowmyCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void insertTnrBoard(TnrboardVO tnrboard) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public TnrboardVO selectTnrBoard(Long tnr_num) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateTnrHit(Long tnr_num) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateTnrBoard(TnrboardVO tnrboard) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteTnrBoard(Long tnr_num) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteTnrFile(Long tnr_num) {
		// TODO Auto-generated method stub
		
	}
	

}
