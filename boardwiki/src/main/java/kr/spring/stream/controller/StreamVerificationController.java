package kr.spring.stream.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import kr.spring.member.vo.MemberVO;
import kr.spring.stream.service.BroadcastService;
import kr.spring.stream.service.StreamCreatingService;
import kr.spring.stream.service.StreamKeyService;
import kr.spring.stream.vo.BroadcastVO;
import kr.spring.stream.vo.StreamCreatingVO;
import kr.spring.stream.vo.StreamKeyVO;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@RestController
public class StreamVerificationController {

    @Autowired
    private StreamKeyService streamKeyService;
    
    @Autowired
    private BroadcastService broadcastService;
    
    @Autowired
    private StreamCreatingService streamCreatingService;

    @GetMapping("/streaming/verify")
    public String verifyStreamKeyGet(@RequestParam String name) {
        return verifyStreamKey(name);
    }

    @PostMapping("/streaming/verify")
    public String verifyStreamKeyPost(@RequestParam String name) {
        return verifyStreamKey(name);
    }

    private String verifyStreamKey(String name) {
    	log.debug("<<살려줘>>"+name);
        try {
            StreamKeyVO key = streamKeyService.findByStreamKey(name);
            if (key != null) {
                System.out.println("Stream key verified: " + name);
                BroadcastVO broadcast = broadcastService.findByMemNum(key.getStr_num());
                if(broadcast == null) {
                	BroadcastVO str = new BroadcastVO();
                	str.setIsLive(1);
                	str.setStr_num(key.getStr_num());
                	broadcastService.startStream(str);
                }else if(broadcast.getIsLive() == 1){
                	BroadcastVO str = new BroadcastVO();
                	str.setIsLive(2);
                	str.setStrD_num(broadcast.getStrD_num());
                    broadcastService.updateBroadcast(str);
                }
                return "status=200";
            } else {
                System.out.println("Invalid stream key: " + name);
                return "status=403";
            }
        } catch (NumberFormatException e) {
            System.out.println("Invalid mem_num format: " + name);
            return "status=400";
        }
    }
    
    //채팅방
    @GetMapping("/streaming/messages")
    public List<StreamCreatingVO> getChatMessages(@RequestParam("strc_num") long strc_num, @RequestParam("str_num") long str_num) {
        StreamCreatingVO vo = new StreamCreatingVO();
        vo.setStrc_num(strc_num);
        return streamCreatingService.selectMessageLive(vo);
    }

    @PostMapping("/streaming/send")
    public ResponseEntity<?> sendChatMessage(@RequestBody StreamCreatingVO vo, HttpSession session) {
        MemberVO user = (MemberVO) session.getAttribute("user");
        vo.setMem_num(user.getMem_num());
        streamCreatingService.insertMessage(vo);
        return ResponseEntity.ok("Message sent successfully");
    }
}