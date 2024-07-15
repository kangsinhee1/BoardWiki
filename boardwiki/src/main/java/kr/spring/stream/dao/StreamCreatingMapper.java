package kr.spring.stream.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import kr.spring.stream.vo.StreamCreatingVO;

@Mapper
public interface StreamCreatingMapper {
	//체팅방 생성
	@Insert("INSERT INTO streaming_chatroom(strc_num,str_num) VALUES(streaming_chatroom_seq.nextval,#{str_num})")
	public void inrsertCreating(int str_num);
	//체팅방 상세
	@Select("SELECT * FROM streaming_chatroom WHERE str_num=#{str_num}")
	public StreamCreatingVO selectCreating(int str_num);
	//체팅방 전체 목록
	public List<StreamCreatingVO> selectCreatingList(Map<String,Object>map);
	//채팅방 조건부 불러오기(방송,유저 검색)
	
	//채팅방 메세지 등록
	
	//채팅방 메세지 불러오기(방송에서:라이브 조건)
	
	//채팅방 메세지 목록불러오기 (조건부:유저,방송 검색)
	
}
