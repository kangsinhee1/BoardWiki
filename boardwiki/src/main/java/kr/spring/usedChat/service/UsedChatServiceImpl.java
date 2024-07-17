package kr.spring.usedChat.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.spring.usedChat.dao.UsedChatMapper;
import kr.spring.usedChat.vo.UsedChatRoomVO;
import kr.spring.usedChat.vo.UsedChat_textVO;

@Service
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

}
