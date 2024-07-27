package kr.spring.calendar.controller;

import java.util.List;

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

@RestController
@RequestMapping("/events")
public class EventController {

    @Autowired
    private EventService eventService;

    @GetMapping("/user/{memNum}")
    public List<EventVO> getEventsByUser(@PathVariable Long memNum) {
        return eventService.getEventsByUser(memNum);
    }

    @PostMapping("/save")
    public EventVO saveEvent(@RequestBody EventVO event) {
        return null;
    }

    @DeleteMapping("/delete/{id}")
    public boolean deleteEvent(@PathVariable Long id) {
        return false;
    }
}