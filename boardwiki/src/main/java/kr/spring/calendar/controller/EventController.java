package kr.spring.calendar.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.spring.calendar.service.EventService;
import kr.spring.calendar.vo.EventVO;
import kr.spring.member.vo.MemberVO;

@RestController
@RequestMapping("/events")
public class EventController {

    @Autowired
    private EventService eventService;

    @PostMapping("/user")
    public List<EventVO> getEventsByUser(HttpSession session) {
    	MemberVO user = (MemberVO)session.getAttribute("user");
        return eventService.getEventsByUser(user.getMem_num());
    }

    @PostMapping("/save")
    public EventVO saveEvent(@RequestBody EventVO event,HttpSession session) {
    	MemberVO user = (MemberVO)session.getAttribute("user");
    	event.setMem_num(user.getMem_num());
        return event;
    }

    @DeleteMapping("/delete/{calendar_num}")
    public boolean deleteEvent(@PathVariable Long calendar_num) {
        return eventService.deleteEvent(calendar_num);
    }
}