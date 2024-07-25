package kr.spring.stream.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import kr.spring.stream.service.BroadcastService;
import kr.spring.stream.service.StreamCreatingService;
import kr.spring.stream.service.StreamKeyService;
import kr.spring.stream.vo.BroadcastVO;
import kr.spring.stream.vo.StreamCreatingVO;
import kr.spring.stream.vo.StreamKeyVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class BroadcastController {

    @Autowired
    private BroadcastService broadcastService;

    @Autowired
    private StreamKeyService streamKeyService;

    @Autowired
    private StreamCreatingService streamCreatingService;
    
    @Autowired
    private MemberService memberService;

    @GetMapping("/streaming/broadcasts")
    public String getBroadcastList(HttpServletRequest request) {
        List<BroadcastVO> broadcasts = broadcastService.getAllBroadcasts();
       
        long mem_num = 0;
        for(int i=0; i<broadcasts.size();i++) {
        	mem_num = broadcasts.get(i).getMem_num();
        	MemberVO member = memberService.selectMember(mem_num);
            if (member != null) {  
            	broadcasts.get(i).setMem_nickName(member.getMem_nickName());
            }
    	}
        request.setAttribute("broadcasts", broadcasts);
        return "broadcast-list";
    }

    @GetMapping("/streaming/broadcast")
    public String getBroadcastPage(Long str_num, HttpServletRequest request, HttpSession session) {
    	List<BroadcastVO> broadcasts = broadcastService.getAllBroadcasts();
    	MemberVO user = null;
    	user = (MemberVO)session.getAttribute("user");
    	long mem_num = 0;
    	String nick = null;
    	for(int i=0; i<broadcasts.size();i++) {
    		if(broadcasts.get(i).getStr_num() == str_num) {
    			mem_num = broadcasts.get(i).getMem_num();
    			MemberVO member = memberService.selectMember(mem_num);
    			nick = member.getMem_nickName();
    		}
    	}
    	int strnum = 0;
    	if(user != null) {
    		if(streamKeyService.streamingNumber(user.getMem_num()) != null) {
    			strnum = streamKeyService.streamingNumber(user.getMem_num());
    		}
    		log.debug("<체크>"+strnum);
    		if(strnum != 0) {
    			request.setAttribute("strnum", strnum);
    		}else if(strnum == 0) {
    			request.setAttribute("strnum", 0);
    		}
    	}
        BroadcastVO broadcast = broadcastService.findByMemNum(str_num);
        StreamKeyVO streamkey = streamKeyService.selectstream(str_num);
        StreamCreatingVO stream =  streamCreatingService.selectCreating(str_num);
        request.setAttribute("nick", nick);
        request.setAttribute("streamkey", streamkey);
        request.setAttribute("broadcast", broadcast);
        request.setAttribute("str", stream);
        request.setAttribute("user", user);
        return "broadcast-page";
    }
}
