package kr.spring.used.service;

import java.util.List;
import java.util.Map;

import kr.spring.used.vo.UsedItemVO;

public interface UsedService {
	//중고글 목록
	public Integer getUsedRowCount(Map<String,Object>map);
	public Integer getUsedRowCountByItemNum(Map<String,Object>map);
	public Integer getUsedRowCountForClient(Map<String,Object>map);
	//중고글 정보
	public List<UsedItemVO> selectUsedList(Map<String,Object>map);  
	public List<UsedItemVO> selectUsedListByItemNum(Map<String,Object>map);
	public List<UsedItemVO> selectUsedListForClient(Map<String,Object>map);
	//중고글 상세
	public UsedItemVO selectUsed(long use_num);
	//중고글 등록
	public void insertUsed(UsedItemVO used);
	//중고글 수정
	public void updateUsed(UsedItemVO used);
	//중고글 삭제
	public void deleteUsed(Map<String,Object> map);

	//내중고글 찾기
	public List<UsedItemVO> selectUsedListByMemNum(Map<String,Object>map);
	//내 중고글 갯수
	public Integer getUsedRowCountByMemNum(Map<String,Object>map);
	// 중고글 판매처리
	public void updateUseCheckByroom(long use_num);
	
	//등급수정
	public void updateUsedAuth(Long use_auth, Long use_num);
	public UsedItemVO selectMainUsed();
}
