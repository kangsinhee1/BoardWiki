package kr.spring.calendar.controller;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Event {
    private Long id;
    private String title;
    private String start;
    private String end;

    // Getters and Setters
}