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
import kr.spring.member.dao.MemberMapper;
import kr.spring.member.vo.MemberVO;

@Service
@Transactional
public class ChatServiceImpl implements ChatService{
	@Autowired
	ChatMapper chatMapper;
	@Autowired
	MemberMapper memberMapper;


	@Override
	public ChatRoomVO selectChatRoom(long tea_num) {
		return chatMapper.selectChatRoom(tea_num);
	}

	@Override
	public List<ChatRoomVO> selectChatRoomList(Map<String, Object> map) {
		return chatMapper.selectChatRoomList(map);
	}

	@Override
	public Integer selectRowCount(Map<String, Object> map) {
		return chatMapper.selectChatRowCount(map);
	}



	@Override
	public void insertChatRoom(ChatRoomVO chatRoomVO) {
		chatRoomVO.setChaR_num(chatMapper.selectChatRoomNum());
		chatMapper.insertChatRoom(chatRoomVO);
	}

	@Override
	public void insertChatRoomMember(Long chaR_num, String chaR_name, Long mem_num) {
		chatMapper.insertChatRoomMember(chaR_num, chaR_name, mem_num);

		//입장 메시지 처리
		ChatTextVO chatTextVO = new ChatTextVO();
		chatTextVO.setChaT_num(chatMapper.selectChatNum());
		chatTextVO.setChaR_num(chaR_num);
		chatTextVO.setMem_num(mem_num);
		MemberVO member = memberMapper.selectMember(mem_num);
		chatTextVO.setMessage(member.getMem_nickName()+" 님이 가입하였습니다.");
		insertChat(chatTextVO);
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
		//메시지 생성후 chatread에 뿌리기,멤버 전체에게
		chatTextVO.setChaT_num(chatMapper.selectChatNum());
		chatMapper.insertChat(chatTextVO);
		for(ChatMemberVO vo : chatMapper.selectChatMember(chatTextVO.getChaR_num())) {
			chatMapper.insertChatRead(chatTextVO.getChaR_num(),chatTextVO.getChaT_num(),vo.getMem_num());
		}

	}

	@Override
	public List<ChatTextVO> selectChatTextDetail(Map<String, Long> map) {
		chatMapper.deleteChatReadAdmin(map);
		return chatMapper.selectChatTextDetail(map);
	}

	@Override
	public void deleteChatRead(Map<String, Long> map) {
		// TODO Auto-generated method stub

	}
	@Override
	public void deleteChatReadAdmin(Map<String, Long> map) {
		chatMapper.deleteChatReadAdmin(map);
	}

	@Override
	public void insertChatRead(Long chaR_num, Long chaT_num, Long mem_num) {
		chatMapper.insertChatRead(chaR_num, chaT_num, mem_num);
	}

	@Override
	public ChatTextVO selectChatText(long chaT_num) {
		return chatMapper.selectChatText(chaT_num);
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

	@Override
	public ChatRoomVO selectChatRoomBychaRnum(long chaR_num) {
		return chatMapper.selectChatRoomBychaRnum(chaR_num);
	}

	@Override
	public void updateChatRoomStatus1Bytea_num(long tea_num) {
		chatMapper.updateChatRoomStatus1Bytea_num(tea_num);
	}

	@Override
	public void updateChatRoomStatus0Bytea_num(long tea_num) {
		chatMapper.updateChatRoomStatus0Bytea_num(tea_num);
	}




}
