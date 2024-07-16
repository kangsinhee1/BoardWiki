package kr.spring.stream.service;

import java.util.List;
import java.util.Map;

import kr.spring.stream.vo.StreamCreatingVO;

public interface StreamCreatingService {
	//체팅방 생성
	public void inrsertCreating(long str_num);
	//체팅방 상세
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