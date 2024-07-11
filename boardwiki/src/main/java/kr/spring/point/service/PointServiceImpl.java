package kr.spring.point.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.point.dao.PointMapper;
import kr.spring.point.vo.PointGameVO;
import kr.spring.point.vo.PointVO;

@Service
@Transactional
public class PointServiceImpl implements PointService{

	@Autowired
	PointMapper pointMapper;
	
	/**
	 * 포인트 사용후 증/감 값 삽입<br>
	 * 증/감 후 증/감 값 총포인트에 반영
	 */
	@Override
	public void processPointTransaction(PointVO pointVO) {
		 pointMapper.insertpoint(pointVO);
		 pointMapper.updatepointtotal(pointVO);
	}

	@Override
	public PointVO selectPoint(PointVO pointVO) {
		return pointMapper.selectPoint(pointVO);
		
	}

	@Override
	public List<PointVO> selectPointList(Map<String, Object> map) {
		return pointMapper.selectPointList(map);
	}

	@Override
	public Integer selectRowCount(Map<String, Object> map) {
		return pointMapper.selectRowCount(map);
	}

	@Override
	public void insertPointGame(PointGameVO pointGameVO) {
		pointMapper.insertPointGame(pointGameVO);
		
	}

	@Override
	public PointGameVO selectPointGame(Long poiG_num) {
		return pointMapper.selectPointGame(poiG_num);
	}

	@Override
	public List<PointVO> selectPointGameList(Map<String, Object> map) {
		return pointMapper.selectPointGameList(map);
	}

	@Override
	public Integer selectPointGameRowCount(Map<String, Object> map) {
		return pointMapper.selectPointGameRowCount(map);
	}

	@Override
	public void deletePointGame(Long poiG_num) {
		pointMapper.deletePointGame(poiG_num);
		
	}

	@Override
	public void insertPointOption(PointGameVO pointGameVO) {
		pointMapper.insertPointOption(pointGameVO);
		
	}

	@Override
	public PointGameVO selectPointOption(Long poiO_num) {
		return pointMapper.selectPointOption(poiO_num);
		
	}

	@Override
	public List<PointGameVO> selectPointGameOptionList(Map<String, Object> map) {
		return pointMapper.selectPointGameOptionList(map);
	}

	@Override
	public Integer selectPointGameOptionRowCount(Map<String, Object> map) {
		return pointMapper.selectPointGameOptionRowCount(map);
	}

	@Override
	public void insertPointBetting(PointGameVO pointGameVO) {
		pointMapper.insertPointBetting(pointGameVO);
		
	}

	@Override
	public PointGameVO selectPointGameBetting(Long mem_num, Long poiO_num) {
		return pointMapper.selectPointGameBetting(mem_num, poiO_num);
		
	}

	@Override
	public List<PointGameVO> selectPointGameBettingList(Map<String, Object> map) {
		return pointMapper.selectPointGameBettingList(map);
	}

	@Override
	public Integer selectPointGameBettingRowCount(Map<String, Object> map) {
		return pointMapper.selectPointGameBettingRowCount(map);
	}

	@Override
	public void deletePointGameBetting(Long mem_num, Long poiO_num) {
		pointMapper.deletePointGameBetting(mem_num, poiO_num);
	}

}
