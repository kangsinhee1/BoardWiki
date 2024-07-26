package kr.spring.calendar.controller;

import kr.spring.calendar.service.EventService;
import kr.spring.calendar.vo.EventVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

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