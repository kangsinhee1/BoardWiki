package kr.spring.used.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import kr.spring.used.vo.UsedItemVO;

@Mapper
public interface UsedMapper {
	//중고글 
	@Select("SELECT COUNT(*) FROM used_item")
	public Integer getUsedRowCount(Map<String,Object>map);
	//중고글 목록
	public List<UsedItemVO> selectUsedList(Map<String,Object>map);
	//중고글 상세
	public UsedItemVO selectUsed(Long use_num);
	//중고글 등록
	public void insertUsed(UsedItemVO used);
	//중고글 수정
	public void updateUsed(UsedItemVO used);
	//중고글 삭제
	public void deleteUsed(long use_num);
}
