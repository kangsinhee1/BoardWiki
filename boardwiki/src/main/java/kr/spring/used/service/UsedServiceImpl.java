package kr.spring.used.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.used.dao.UsedMapper;
import kr.spring.used.vo.UsedItemVO;
import kr.spring.usedChat.dao.UsedChatMapper;

@Service
@Transactional
public class UsedServiceImpl implements UsedService{

	@Autowired
	UsedMapper usedMapper;
	@Autowired
	UsedChatMapper usedChatMapper;

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
	public void deleteUsed(Map<String,Object> map) {
		usedChatMapper.deleteUsedChatRoom(map);
		usedMapper.deleteUsed(map);
	}

	@Override
	public List<UsedItemVO> selectUsedListByMemNum(Map<String, Object> map) {
		return usedMapper.selectUsedListByMemNum(map);
	}

	@Override
	public Integer getUsedRowCountByMemNum(Map<String, Object> map) {
		return usedMapper.getUsedRowCountByMemNum(map);
	}

	@Override
	public void updateUseCheckByroom(long use_num) {
		usedMapper.updateUseCheckByroom(use_num);
	}
	@Override
	public void updateUsedAuth(Long use_auth, Long use_num) {
		usedMapper.updateUsedAuth(use_auth, use_num);
	}

	@Override
	public List<UsedItemVO> selectUsedListForClient(Map<String, Object> map) {
		return usedMapper.selectUsedListForClient(map);
	}

	@Override
	public Integer getUsedRowCountForClient(Map<String, Object> map) {
		return usedMapper.getUsedRowCountForClient(map);
	}

	@Override
	public Integer getUsedRowCountByItemNum(Map<String, Object> map) {
		return usedMapper.getUsedRowCountByItemNum(map);
	}

	@Override
	public List<UsedItemVO> selectUsedListByItemNum(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return usedMapper.selectUsedListByItemNum(map);
	}

	@Override
	public UsedItemVO selectMainUsed() {
		return usedMapper.selectMainUsed();
	}

}  
