package kr.spring.rent.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.spring.rent.vo.RentVO;

@Mapper
public interface RentMapper {
	public List<RentVO> selectRentList(Map<String, Object> map);
	public Integer selectRowCount(Map<String, Object> map);
	public void insertRent(RentVO rent);
	
    public void updateRentStatus(Long rent_num);
    // public void deleteGameRent(Long rentNum);
    
    public Integer selectAllMembersRowCount(Map<String, Object> map);
    public List<RentVO> selectAllMembersRentList(Map<String, Object> map);
}
