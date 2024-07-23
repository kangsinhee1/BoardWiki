package kr.spring.used.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.used.vo.UsedItemVO;

@Mapper
public interface UsedMapper {
	//중고글
	public Integer getUsedRowCount(Map<String,Object>map);
	//중고글 목록
	public List<UsedItemVO> selectUsedList(Map<String,Object>map);
	//중고글 상세
	public UsedItemVO selectUsed(long use_num);
	//중고글 등록
	public void insertUsed(UsedItemVO used);
	//중고글 수정
	public void updateUsed(UsedItemVO used);
	//중고글 삭제
	@Delete("DELETE FROM used_item WHERE use_num=#{use_num}")
	public void deleteUsed(Map<String,Object> map);
	//중고글 판매완료 처리
	@Update("UPDATE  used_item SET use_check=#{use_check} WHERE use_num=#{use_num}")
	public void updateUseCheck(long use_num);
	//중고글 찾기
	@Select("SELECT * FROM used_item WHERE mem_num = #{mem_num}")
	public List<UsedItemVO> selectUsedListByMemNum(Map<String,Object>map);
	//내 중고글 갯수
	@Select("SELECT COUNT(*) FROM used_item WHERE mem_num = #{mem_num}")
	public Integer getUsedRowCountByMemNum(Map<String,Object>map);
	
	@Update("UPDATE  used_item SET use_check= 3 WHERE use_num=#{use_num}")
	public void updateUseCheckByroom(long use_num);

	//등급 수정
	@Update("UPDATE used_item SET use_auth=#{use_auth} WHERE use_num=#{use_num}")
	public void updateUsedAuth(Long use_auth, Long use_num);
}
