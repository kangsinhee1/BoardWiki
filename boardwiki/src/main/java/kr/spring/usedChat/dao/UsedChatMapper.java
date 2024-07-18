package kr.spring.usedChat.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import kr.spring.usedChat.vo.UsedChatRoomVO;
import kr.spring.usedChat.vo.UsedChat_textVO;

@Mapper
public interface UsedChatMapper {
	//채팅방 목록
	public List<UsedChatRoomVO> selectUsedChatRoomList (Map<String,Object> map);
	public Integer selectRowCount(Map<String,Object> map);

	//채팅방 번호 생성
	@Select("SELECT usedchatroom_seq.nextval FROM dual")
	public Integer selectUsedChatRoomNum();
	//채팅방 생성
	@Insert("INSERT INTO usedChatRoom (useC_num,useC_name,use_num,mem_num) VALUES (#{useC_num},#{useC_name},#{use_num},#{mem_num})")
	public void insertUsedChatRoom(UsedChatRoomVO usedChatRoomVO);
	
	//채팅방 검색
	@Select("SELECT * FROM usedChatroom WHERE mem_num = #{mem_num} AND use_num =#{use_num}")
	public UsedChatRoomVO selectUsedChatRoom(@Param(value="mem_num") Long mem_num,@Param(value="use_num") Long use_num);
	@Select("SELECT * FROM usedChatroom WHERE useC_name LIKE '%'||#{useC_name}||'%' AND use_num =#{use_num}")
	public UsedChatRoomVO selectUsedChatRoomSeller(@Param(value="useC_name") String useC_name,@Param(value="use_num") Long use_num);
	
	//채팅 메시지 번호 생성
	@Select("SELECT usedchat_text_seq.nextval FROM dual")
	public Integer selectChatNum();
	//채팅 메시지 등록
	@Insert("INSERT INTO usedChat_text (chaC_num,useC_num,mem_num,chaC_txt) VALUES (#{chaC_num},#{useC_num},#{mem_num},#{chaC_txt})")
	public void insertChat(UsedChat_textVO usedChat_textVO);
	
	//채팅 메시지 삭제
	@Delete("DELETE FROM usedchat_txt WHERE useC_num=#{useC_num}")
	public void DeleteChatTxt(Long useC_num);
	
	//채팅 메시지 읽기
	public List<UsedChat_textVO> selectChatDetail(Map<String,Long> map);
	
}
