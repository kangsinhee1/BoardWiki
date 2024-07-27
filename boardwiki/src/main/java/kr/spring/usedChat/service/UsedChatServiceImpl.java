package kr.spring.usedChat.service;

import java.util.List;
import java.util.Map;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.spring.usedChat.dao.UsedChatMapper;
import kr.spring.usedChat.vo.UsedChatRoomVO;
import kr.spring.usedChat.vo.UsedChat_textVO;

@Service
@Transactional
public class UsedChatServiceImpl implements UsedChatService{

	@Autowired
	UsedChatMapper usedChatMapper;

	@Override
	public List<UsedChatRoomVO> selectUsedChatRoomList(Map<String, Object> map) {
		return usedChatMapper.selectUsedChatRoomList(map);
	}

	@Override
	public Integer selectRowCount(Map<String, Object> map) {
		return usedChatMapper.selectRowCount(map);
	}

	@Override
	public void insertUsedChatRoom(UsedChatRoomVO talkRoomVO) {
		talkRoomVO.setUseC_num(usedChatMapper.selectUsedChatRoomNum());
		usedChatMapper.insertUsedChatRoom(talkRoomVO);
	}

	@Override
	public void insertChat(UsedChat_textVO usedChat_textVO) {
		usedChat_textVO.setChaC_num(usedChatMapper.selectChatNum());
		usedChatMapper.insertChat(usedChat_textVO);
	}

	@Override
	public UsedChatRoomVO selectUsedChatRoom(Long mem_num, Long use_num) {
		return usedChatMapper.selectUsedChatRoom(mem_num, use_num);
	}

	@Override
	public List<UsedChat_textVO> selectChatDetail(Map<String, Long> map) {

		return usedChatMapper.selectChatDetail(map);
	}

	@Override
	public UsedChatRoomVO selectUsedChatRoomSeller(String useC_name, Long use_num) {
		return usedChatMapper.selectUsedChatRoomSeller(useC_name, use_num);
	}

	@Override
	public void deleteUsedChatRoom(Map<String,Object> map) {
		usedChatMapper.deleteUsedChatRoom(map);
	}

	@Override
	public void deleteUsedChatTxt(Map<String,Object> map) {
		usedChatMapper.deleteUsedChatTxt(map);
	}

	@Override
	public List<UsedChatRoomVO> selectUsedChatRoomByMemNickName(Map<String,Object> map) {
		return usedChatMapper.selectUsedChatRoomByMemNickName(map);
	}

	@Override
	public Integer selectRowCountByMemNum(Map<String, Object> map) {
		return usedChatMapper.selectRowCountByMemNum(map);
	}

	@Override
	public void updateUseC_status(long useC_num) {
		usedChatMapper.updateUseC_status(useC_num);

	}

	@Override
	public List<UsedChatRoomVO> selectChatRoomstatus2(long mem_num) {
		return usedChatMapper.selectChatRoomstatus2(mem_num);
	}

	@Override
	public Long selectAvgGrade(Long mem_num) {
		return usedChatMapper.selectAvgGrade(mem_num);
	}

	@Override
	public void updateUseC_grade(UsedChatRoomVO usedChatRoomVO) {
		usedChatMapper.updateUseC_grade(usedChatRoomVO);
	}

	@Override
	public Integer selectChatRoomCountstatus2(long mem_num) {
		return usedChatMapper.selectChatRoomCountstatus2(mem_num);
	}

	@Override
	public UsedChatRoomVO selectUsedChatROOMByuseCNum(long useC_num) {
		return usedChatMapper.selectUsedChatROOMByuseCNum(useC_num);
	}

}
