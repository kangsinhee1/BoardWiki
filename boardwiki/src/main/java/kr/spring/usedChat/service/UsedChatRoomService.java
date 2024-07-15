package kr.spring.usedChat.service;

import java.util.List;
import java.util.Map;

import kr.spring.usedChat.vo.UsedChatRoomVO;

public interface UsedChatRoomService {
	//채팅방 목록
	public List<UsedChatRoomVO> selectUsedChatRoomList (Map<String,Object> map);
	public Integer selectRowCount(Map<String,Object> map);

	//채팅방 생성
	public void insertUsedChatRoom(UsedChatRoomVO talkRoomVO);
}
