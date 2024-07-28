package kr.spring.calendar.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.spring.calendar.dao.EventMapper;
import kr.spring.calendar.vo.EventVO;

@Service
public class EventServiceImpl implements EventService{

    @Autowired
    private EventMapper eventMapper;

    @Override
	public List<EventVO> getEventsByUser(Long memNum) {
        return eventMapper.getEventsByUser(memNum);
    }

    @Override
	public int saveEvent(EventVO event) {

        return eventMapper.saveEvent(event);
    }

	@Override
	public boolean deleteEvent(Long calendar_num) {
		return eventMapper.deleteEvent(calendar_num) > 0;
	}
}