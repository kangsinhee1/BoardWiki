package kr.spring.calendar.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Select;

import kr.spring.calendar.vo.EventVO;

@Mapper
public interface EventMapper {

    @Select("SELECT * FROM calendar WHERE mem_num = #{mem_num}")
    List<EventVO> getEventsByUser(Long memNum);

    @Insert("INSERT INTO calendar (calendar_num,mem_num, title, startDate, endDate) VALUES (calendar_seq.nextval #{memNum}, #{title}, #{startDate}, #{endDate})")
    @Options(useGeneratedKeys = true, keyProperty = "calendar_num")
    int saveEvent(EventVO event);

    @Delete("DELETE FROM calendar WHERE calendar_num = #{calendar_num}")
    int deleteEvent(Long id);
}