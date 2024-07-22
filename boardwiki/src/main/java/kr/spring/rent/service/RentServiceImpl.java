package kr.spring.rent.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.rent.dao.RentMapper;
import kr.spring.rent.vo.RentVO;

@Service
@Transactional
public class RentServiceImpl implements RentService {
	@Autowired
	RentMapper rentMapper;

	@Override
	public List<RentVO> selectRentList(Map<String, Object> map) {
		return rentMapper.selectRentList(map);
	}

	@Override
	public Integer selectRowCount(Map<String, Object> map) {
		return rentMapper.selectRowCount(map);
	}

	@Override
	public void insertRent(RentVO rent) {
		rentMapper.insertRent(rent);

	}

	@Override
    public void updateRentStatus(Long rent_num) {
        rentMapper.updateRentStatus(rent_num);
    }

	@Override
    public Integer selectAllMembersRowCount(Map<String, Object> map) {
        return rentMapper.selectAllMembersRowCount(map);
    }

    @Override
    public List<RentVO> selectAllMembersRentList(Map<String, Object> map) {
        return rentMapper.selectAllMembersRentList(map);
    }

}
