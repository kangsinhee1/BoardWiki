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

    @Select("SELECT * FROM events WHERE memNum = #{memNum}")
    List<EventVO> getEventsByUser(Long memNum);

    @Insert("INSERT INTO events (memNum, title, startDate, endDate) VALUES (#{memNum}, #{title}, #{startDate}, #{endDate})")
    @Options(useGeneratedKeys = true, keyProperty = "id")
    int saveEvent(EventVO event);

    @Delete("DELETE FROM events WHERE id = #{id}")
    int deleteEvent(Long id);
}