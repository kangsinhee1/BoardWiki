package kr.spring.used.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.used.dao.UsedMapper;
import kr.spring.used.vo.UsedItemVO;

@Service
@Transactional
public class UsedServiceImpl implements UsedService{
	
	@Autowired
	UsedMapper usedMapper;

	@Override
	public Integer getUsedRowCount(Map<String, Object> map) {
		return usedMapper.getUsedRowCount(map);
	}

	@Override
	public List<UsedItemVO> selectUsedList(Map<String, Object> map) {
		return usedMapper.selectUsedList(map);
	}

	@Override
	public UsedItemVO selectUsed(long use_num) {
		return usedMapper.selectUsed(use_num);
	}

	@Override
	public void insertUsed(UsedItemVO used) {
		usedMapper.insertUsed(used);
	}

	@Override
	public void updateUsed(UsedItemVO used) {
		usedMapper.updateUsed(used);
	}

	@Override
	public void deleteUsed(long use_num) {
		usedMapper.deleteUsed(use_num);
	}

}
