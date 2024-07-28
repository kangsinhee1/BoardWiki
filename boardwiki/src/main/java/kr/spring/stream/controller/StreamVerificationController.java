package kr.spring.stream.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import kr.spring.member.service.MemberService;
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

    @Autowired
    private MemberService memberService;

    @PostMapping("/streaming/start")
    private Map<String, Object> startStreaming(HttpSession session,Integer str_num) {
    	Map<String, Object> map = new HashMap<String, Object>();
    	MemberVO user = (MemberVO)session.getAttribute("user");
    	if(user==null) {
    		map.put("result","logout");
    	}else {
    	StreamKeyVO key = streamKeyService.findByStreamKey(user.getMem_num());
        if (key != null) {
            BroadcastVO broadcast = broadcastService.findByMemNum(key.getStr_num());
                if(broadcast == null) {
                	BroadcastVO str = new BroadcastVO();
                	str.setIsLive(1);
                	str.setStr_num(key.getStr_num());
                	StreamCreatingVO vo = streamCreatingService.selectCreating(key.getStr_num());
                	if(vo == null) {
                		streamCreatingService.inrsertCreating(key.getStr_num());
                	}
                	broadcastService.startStream(str);
                	map.put("result", "start");
                }else if(broadcast.getIsLive() == 1){
                	BroadcastVO str = new BroadcastVO();
                	str.setIsLive(2);
                	str.setStrD_num(broadcast.getStrD_num());
                    broadcastService.updateBroadcast(str);
                    map.put("result", "stop");
                } 
        }else {
        	String streamKey = UUID.randomUUID().toString();
            StreamKeyVO key2 = new StreamKeyVO();
            key2.setMem_num(user.getMem_num());
            key2.setStr_key(streamKey);
            streamKeyService.save(key2);
            map.put("result", "newkey");
        }
    	}
        return map;
    }

    //채팅방
    @GetMapping("/streaming/messages")
    public List<StreamCreatingVO> getChatMessages(@RequestParam("str_num") long str_num) {
        StreamCreatingVO vo = new StreamCreatingVO();
        vo = streamCreatingService.selectCreating(str_num);
        Long mem_num = 0l;
        List<StreamCreatingVO> list = streamCreatingService.selectMessageLive(vo);
        for (StreamCreatingVO element : list) {
        	mem_num = element.getMem_num();
        	MemberVO member = memberService.selectMember(mem_num);
        	element.setMem_nickName(member.getMem_nickName());
        }
        return list;
    }

    @PostMapping("/streaming/send")
    public Map<String,String> sendChatMessage(@RequestParam("str_num") long str_num,@RequestParam("strt_chat") String strt_chat, HttpSession session) {
    	Map<String,String> map = new HashMap<>();
    	MemberVO user = (MemberVO) session.getAttribute("user");
        StreamCreatingVO vos = new StreamCreatingVO();
        StreamCreatingVO vos2 = streamCreatingService.selectCreating(str_num);
        vos.setMem_num(user.getMem_num());
        vos.setStrt_chat(strt_chat);
        vos.setStrc_num(vos2.getStrc_num());
        streamCreatingService.insertMessage(vos);
        map.put("mem_nickName", user.getMem_nickName());
        map.put("result", "success");
        return map;
    }
}