package kr.spring.stream.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import kr.spring.stream.service.StreamKeyService;
import kr.spring.stream.vo.StreamKeyVO;

@RestController
public class StreamVerificationController {

    @Autowired
    private StreamKeyService streamKeyService;

    @GetMapping("/streaming/verify")
    public String verifyStreamKeyGet(@RequestParam String name) {
        StreamKeyVO key = streamKeyService.findByStreamKey(name);
        if (key != null) {
            System.out.println("Stream key verified: " + name);
            return "status=200";
        } else {
            System.out.println("Invalid stream key: " + name);
            return "status=403";
        }
    }

    @PostMapping("/streaming/verify")
    public String verifyStreamKeyPost(@RequestParam String name) {
        StreamKeyVO key = streamKeyService.findByStreamKey(name);
        if (key != null) {
            System.out.println("Stream key verified: " + name);
            return "status=200";
        } else {
            System.out.println("Invalid stream key: " + name);
            return "status=403";
        }
    }
}
