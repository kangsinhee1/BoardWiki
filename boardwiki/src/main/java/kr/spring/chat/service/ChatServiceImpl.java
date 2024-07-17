package kr.spring.chat.service;

import java.util.List;
import java.util.Map;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.spring.chat.dao.ChatMapper;
import kr.spring.chat.vo.ChatMemberVO;
import kr.spring.chat.vo.ChatRoomVO;
import kr.spring.chat.vo.ChatTextVO;

@Service
@Transactional
public class ChatServiceImpl implements ChatService{
	@Autowired 
	ChatMapper chatMapper;
	@Override
	public ChatRoomVO selectChatRoom(long tea_num) {
		return chatMapper.selectChatRoom(tea_num);
	}

	@Override
	public List<ChatRoomVO> selectChatRoomList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Integer selectRowCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}



	@Override
	public void insertChatRoom(ChatRoomVO chatRoomVO) {
		chatRoomVO.setChaR_num(chatMapper.selectChatRoomNum());
		chatMapper.insertChatRoom(chatRoomVO);
	}

	@Override
	public void insertChatRoomMember(Long chaR_num, String chaR_name, Long mem_num) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<ChatMemberVO> selectChatMember(Long chaR_num) {
		return chatMapper.selectChatMember(chaR_num);
	}

	@Override
	public Integer selectChatNum() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void insertChat(ChatTextVO chatTextVO) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<ChatTextVO> selectChatTextDetail(Map<String, Long> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void deleteChatRead(Map<String, Long> map) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void insertChatRead(Long chaR_num, Long chaT_num, Long mem_num) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public ChatTextVO selectChatText(long chaT_num) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void insertChatRoomMemberUser(Long chaR_num, String chaR_name, Long mem_num) {
		chatMapper.insertChatRoomMemberUser(chaR_num, chaR_name, mem_num);
	}

	@Override
	public void deleteChatRoomMemeberUser(Long mem_num, long chaR_num) {
		chatMapper.deleteChatRoomMemeberUser(mem_num, chaR_num);
	}

	@Override
	public Integer selectChatRoomNum() {
		// TODO Auto-generated method stub
		return null;
	}

	
}
