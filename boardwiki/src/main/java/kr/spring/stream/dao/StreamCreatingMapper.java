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
	public void inrsertCreating(long str_num);
	//체팅방 상세
	@Select("SELECT * FROM streaming_chatroom WHERE str_num=#{str_num}")
	public StreamCreatingVO selectCreating(long str_num);
	//체팅방 전체 목록
	public List<StreamCreatingVO> selectCreatingList(Map<String,Object>map);
	//채팅방 조건부 불러오기(방송,유저 검색)
	public List<StreamCreatingVO> selectCreatingListuser(Map<String,Object>map);
	//채팅방 목록 수
	public Integer countCreating(Map<String,Object>map);
	//채팅방 목록 수
	public Integer countCreatinguser(Map<String,Object>map);
	//채팅방 메세지 등록
	@Insert("INSERT INTO streaming_chattage(strt_num,strc_num,mem_num, strt_chat) VALUES(streaming_chattage_seq.nextval,#{strc_num},#{mem_num},#{strt_chat})")
	public void insertMessage(StreamCreatingVO streamvo);
	//채팅방 메시지 불러오기(방송에서:라이브 조건)
	public List<StreamCreatingVO> selectMessageLive(StreamCreatingVO streamvo);
	//채팅방 메시지 목록불러오기 (조건부:유저,방송 검색)
	public List<StreamCreatingVO> selectMeassageuser(StreamCreatingVO streamvo);
	//채팅방 메시지 수
	public Integer countMeassageLive(Map<String,Object>map);
	//채팅방 메시지 수 유저
	public Integer countMeassageuser(Map<String,Object>map);
}
