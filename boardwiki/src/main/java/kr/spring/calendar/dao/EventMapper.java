package kr.spring.calendar.dao;

import kr.spring.calendar.vo.EventVO;
import org.apache.ibatis.annotations.*;

import java.util.List;

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