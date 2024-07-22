package kr.spring.rent.service;

import java.util.List;
import java.util.Map;

import kr.spring.rent.vo.RentVO;

public interface RentService {

	public List<RentVO> selectRentList(Map<String, Object> map);
	public Integer selectRowCount(Map<String, Object> map);
	public void insertRent(RentVO rent);
	public void updateRentStatus(Long rent_num);
    // public void deleteGameRent(Long rentNum);

	// 모든 회원의 대여 목록 수 조회
    public Integer selectAllMembersRowCount(Map<String, Object> map);

    // 모든 회원의 대여 목록 조회
    public List<RentVO> selectAllMembersRentList(Map<String, Object> map);

}
