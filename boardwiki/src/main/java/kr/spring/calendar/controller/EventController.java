package kr.spring.calendar.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.atomic.AtomicLong;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import kr.spring.member.vo.MemberVO;

@Controller
public class EventController {

    private final List<Event> events = new ArrayList<>();
    private final AtomicLong counter = new AtomicLong();

    @GetMapping("/myPage/calendar")
    public String showCalendar() {
        return "calendar";
    }

    @GetMapping("/events")
    @ResponseBody
    public List<Event> getEvents() {
        return events;
    }

    @PostMapping("/events")
    @ResponseBody
    public Event addEvent(@RequestBody Event event) {
        event.setId(counter.incrementAndGet());
        events.add(event);
        return event;
    }

    @PutMapping("/events/{user}/{id}")
    @ResponseBody
    public Event updateEvent(@SessionAttribute("user") Long user, @PathVariable Long id, @RequestBody Event event, HttpSession session) {
    	
        Event existingEvent = events.stream()
            .filter(e -> e.getId().equals(user))
            .findFirst()
            .orElseThrow(() -> new RuntimeException("Event not found"));
        
        existingEvent.setTitle(event.getTitle());
        existingEvent.setStart(event.getStart());
        existingEvent.setEnd(event.getEnd());
        return existingEvent;
    }

    @DeleteMapping("/events/{id}")
    @ResponseBody
    public void deleteEvent(@PathVariable Long id) {
        events.removeIf(event -> event.getId().equals(id));
    }
}