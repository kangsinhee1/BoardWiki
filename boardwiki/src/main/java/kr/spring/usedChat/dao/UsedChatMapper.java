package kr.spring.usedChat.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.usedChat.vo.UsedChatRoomVO;
import kr.spring.usedChat.vo.UsedChat_textVO;

@Mapper
public interface UsedChatMapper {
	//채팅방 목록
	public List<UsedChatRoomVO> selectUsedChatRoomList (Map<String,Object> map);
	public Integer selectRowCount(Map<String,Object> map);
	public Integer selectRowCountByMemNum(Map<String,Object> map);

	//채팅방 번호 생성
	@Select("SELECT usedchatroom_seq.nextval FROM dual")
	public Integer selectUsedChatRoomNum();
	//채팅방 생성
	@Insert("INSERT INTO usedChatRoom (useC_num,useC_name,use_num,mem_num) VALUES (#{useC_num},#{useC_name},#{use_num},#{mem_num})")
	public void insertUsedChatRoom(UsedChatRoomVO usedChatRoomVO);
	//채팅방 삭제
	@Delete("DELETE FROM usedChatRoom WHERE use_num = #{use_num}")
	public void deleteUsedChatRoom(Map<String,Object> map);


	//채팅방 검색
	@Select("SELECT * FROM usedChatroom WHERE useC_name LIKE '%'||#{mem_nickName}||'%'")
	public List<UsedChatRoomVO> selectUsedChatRoomByMemNickName(Map<String,Object> map);
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
	public void deleteUsedChatTxt(Map<String,Object> map);

	//채팅 메시지 읽기
	public List<UsedChat_textVO> selectChatDetail(Map<String,Long> map);
	
	
	
	//구매 완료 처리
	@Update("UPDATE usedChatROOM set usec_status = 2 WHERE useC_num = #{useC_num}")
	public void updateUseC_status (long useC_num);
	//구매 완료된 목록 보기
	@Select("SELECT * FROM UsedChatROOM WHERE usec_status =2 AND MEM_NUM = #{mem_num} AND useC_grade is  null")
	public List<UsedChatRoomVO> selectChatRoomstatus2(long mem_num);
	
	@Select("SELECT count(*) FROM UsedChatROOM WHERE usec_status =2 AND MEM_NUM = #{mem_num} AND useC_grade is null ")
	public Integer selectChatRoomCountstatus2(long mem_num);
	
	// 판매자 평가하기
	@Update("UPDATE usedChatRoom SET useC_grade = #{useC_grade} WHERE useC_num = #{useC_num}")
	public void updateUseC_grade(UsedChatRoomVO usedChatRoomVO);
	
	// 판매자 평점
	public Long selectAvgGrade(long mem_num);
	//채팅방 정보 불러오기 
	@Select("Select * FROM usedChatRoom WHERE useC_Num = #{useC_num}")
	public UsedChatRoomVO selectUsedChatROOMByuseCNum(long useC_num);
	
}
