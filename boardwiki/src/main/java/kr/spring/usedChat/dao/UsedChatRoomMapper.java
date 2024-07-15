package kr.spring.usedChat.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import kr.spring.usedChat.vo.UsedChatRoomVO;

@Mapper
public interface UsedChatRoomMapper {
	//채팅방 목록
	public List<UsedChatRoomVO> selectUsedChatRoomList (Map<String,Object> map);
	public Integer selectRowCount(Map<String,Object> map);

	//채팅방 번호 생성
	@Select("SELECT UsedChatRoom_seq.nextval FROM dual")
	public Integer selectUsedChatRoomNum();
	//채팅방 생성
	@Insert("INSERT INTO usedChatRoom (useC_num,useC_name) VALUES (#{useC_num},#{useC_name})")
	public void insertUsedChatRoom(UsedChatRoomVO usedChatRoomVO);
}
