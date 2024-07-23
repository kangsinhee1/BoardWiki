package kr.spring.stream.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

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
    public List<StreamCreatingVO> getChatMessages(@RequestParam("str_num") long str_num) {
        StreamCreatingVO vo = new StreamCreatingVO();
        vo = streamCreatingService.selectCreating(str_num);
        return streamCreatingService.selectMessageLive(vo);
    }

    @PostMapping("/streaming/send")
    public Map<String,String> sendChatMessage(@RequestParam("str_num") long str_num,@RequestParam("strt_chat") String strt_chat, HttpSession session) {
    	Map<String,String> map = new HashMap<String, String>();
    	MemberVO user = (MemberVO) session.getAttribute("user");
        StreamCreatingVO vos = new StreamCreatingVO();
        StreamCreatingVO vos2 = streamCreatingService.selectCreating(str_num);
        vos.setMem_num(user.getMem_num());
        vos.setStrt_chat(strt_chat);
        vos.setStrc_num(vos2.getStrc_num());
        streamCreatingService.insertMessage(vos);
        map.put("mem_nickName", user.getMem_nickName());
        map.put("result", "seusse");
        return map;
    }
}