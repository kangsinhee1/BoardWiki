package kr.spring.mission.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.mission.vo.MissionVO;

@Mapper
public interface MissionMapper {
	@Insert("INSERT INTO mission (mis_num,str_num, mis_content, mis_point, mis_status, mem_num) VALUES (mission_seq.nextval,#{str_num}, #{mis_content}, #{mis_point}, 1, #{mem_num})")
    void insertMission(MissionVO mission);

	@Select("SELECT * FROM (SELECT a.*, rownum rnum FROM (SELECT * FROM mission WHERE str_num = #{str_num})a) WHERE rnum >= #{start} AND rnum <= #{end}")
    List<MissionVO> getMissionsByStream(Map<String,Object> map);

	@Select("SELECT * FROM (SELECT a.*, rownum rnum FROM (SELECT * FROM mission WHERE mem_num = #{mem_num} AND str_num=#{str_num})a) WHERE rnum >= #{start} AND rnum <= #{end}")
    List<MissionVO> getMissionsByMember(Map<String,Object> map);

    @Update("UPDATE mission SET mis_status = #{mis_status} WHERE mis_num = #{mis_num}")
    void updateMissionStatus(MissionVO vo);

    @Delete("DELETE FROM mission WHERE mis_num = #{mis_num} ")
    void deleteMission(Long mis_num);

    @Select("SELECT COUNT(*) FROM mission WHERE str_num = #{str_num}")
    Integer selectcountstream(Map<String,Object> map);

    @Select("SELECT COUNT(*) FROM mission WHERE mem_num = #{mem_num} AND str_num=#{str_num}")
    Integer selectcountmember(Map<String,Object> map);
}
