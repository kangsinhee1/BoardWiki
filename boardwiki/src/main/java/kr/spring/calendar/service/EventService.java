package kr.spring.calendar.service;

import java.util.List;

import kr.spring.calendar.vo.EventVO;

public interface EventService {
    List<EventVO> getEventsByUser(Long memNum);
    int saveEvent(EventVO event);
    boolean deleteEvent(Long calendar_num);
}