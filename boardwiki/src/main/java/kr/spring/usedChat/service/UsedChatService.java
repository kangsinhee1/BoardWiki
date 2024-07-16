package kr.spring.usedChat.service;

import java.util.List;
import java.util.Map;

import kr.spring.usedChat.vo.UsedChatRoomVO;
import kr.spring.usedChat.vo.UsedChat_textVO;

public interface UsedChatService {
	//채팅방 목록
	public List<UsedChatRoomVO> selectUsedChatRoomList (Map<String,Object> map);
	public Integer selectRowCount(Map<String,Object> map);

	//채팅방 생성
	public void insertUsedChatRoom(UsedChatRoomVO talkRoomVO);
	public UsedChatRoomVO selectUsedChatRoom(Long mem_num, Long use_num);

	public void insertChat(UsedChat_textVO usedChat_textVO);
	public List<UsedChat_textVO> selectChatDetail(Map<String,Long> map);
}
