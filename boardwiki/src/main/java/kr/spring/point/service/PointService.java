package kr.spring.point.service;

import java.util.List;
import java.util.Map;

import kr.spring.point.vo.PointVO;

public interface PointService {
	public void processPointTransaction(PointVO pointVO);
	public void selectPoint(PointVO pointVO);
	public List<PointVO> selectPointList(Map<String,Object> map);
	public Integer selectRowCount(Map<String,Object> map);
}
