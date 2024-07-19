package kr.spring.usedChat.service;

import java.util.List;
import java.util.Map;


import kr.spring.usedChat.vo.UsedChatRoomVO;
import kr.spring.usedChat.vo.UsedChat_textVO;

public interface UsedChatService {
	//채팅방 목록
	public List<UsedChatRoomVO> selectUsedChatRoomList (Map<String,Object> map);
	public Integer selectRowCount(Map<String,Object> map);
	public Integer selectRowCountByMemNum(Map<String,Object> map);

	//채팅방
	public void insertUsedChatRoom(UsedChatRoomVO talkRoomVO);
	public List<UsedChatRoomVO> selectUsedChatRoomByMemNickName(Map<String,Object> map);
	public UsedChatRoomVO selectUsedChatRoom(Long mem_num, Long use_num);
	public UsedChatRoomVO selectUsedChatRoomSeller(String useC_name, Long use_num);
	public void deleteUsedChatRoom(Map<String,Object> map);
	
	//채팅
	public void insertChat(UsedChat_textVO usedChat_textVO);
	public List<UsedChat_textVO> selectChatDetail(Map<String,Long> map);
	public void deleteUsedChatTxt(Map<String,Object> map);
}
