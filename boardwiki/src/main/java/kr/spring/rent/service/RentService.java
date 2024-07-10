package kr.spring.rent.service;

import java.util.List;
import java.util.Map;

import kr.spring.rent.vo.RentVO;

public interface RentService {
	
	public List<RentVO> selectRentList(Map<String, Object> map);
	public Integer selectRowCount(Map<String, Object> map);
	public void insertRent(RentVO rent);
    public void updateRent(RentVO rent);
    // public void deleteGameRent(Long rentNum);

}
