package kr.spring.tnrboard.service;

import java.util.List;
import java.util.Map;

import kr.spring.tnrboard.vo.TnrboardVO;

public interface TnrboardService {
	//부모글
	public List<TnrboardVO> selectTnrList(Map<String,Object> map);
	public List<TnrboardVO> selectTnrMyList(Map<String,Object> map);
	public Integer selectTnrRowCount(Map<String,Object> map);
	public Integer selectTnrRowmyCount(Map<String,Object> map);
	public void insertTnrBoard(TnrboardVO tnrboard);
	public TnrboardVO selectTnrBoard(Long tnr_num);
	public void updateTnrHit(Long tnr_num);
	public void updateTnrBoard(TnrboardVO tnrboard);
	public void deleteTnrBoard(Long tnr_num);
	public void deleteTnrFile(Long tnr_num);
	
}
