package kr.spring.point.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.point.dao.PointMapper;
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
	public void selectPoint(PointVO pointVO) {
		pointMapper.selectPoint(pointVO);
		
	}

	@Override
	public List<PointVO> selectPointList(Map<String, Object> map) {
		return selectPointList(map);
	}

	@Override
	public Integer selectRowCount(Map<String, Object> map) {
		return selectRowCount(map);
	}

}
