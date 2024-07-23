package kr.spring.stream.controller;

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

@Controller
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
        request.setAttribute("broadcasts", broadcasts);
        return "broadcast-list";
    }

    @GetMapping("/streaming/broadcast")
    public String getBroadcastPage(Long str_num, HttpServletRequest request, HttpSession session) {
    	List<BroadcastVO> broadcasts = broadcastService.getAllBroadcasts();
    	MemberVO user = null;
    	user = (MemberVO)session.getAttribute("user");
    	String mem_nickName = null;
    	for(int i=0; i<broadcasts.size();i++) {
    		if(broadcasts.get(i).getStr_num()==str_num) {
    			mem_nickName = broadcasts.get(i).getMem_nickName();
    		}
    	}
    	
    	if(user != null) {
    		int strnum = streamKeyService.streamingNumber(user.getMem_num());
    		request.setAttribute("strnum", strnum);
    	}
        BroadcastVO broadcast = broadcastService.findByMemNum(str_num);
        StreamKeyVO streamkey = streamKeyService.selectstream(str_num);
        StreamCreatingVO stream =  streamCreatingService.selectCreating(str_num);
        request.setAttribute("mem_nickName", mem_nickName);
        request.setAttribute("streamkey", streamkey);
        request.setAttribute("broadcast", broadcast);
        request.setAttribute("str", stream);
        return "broadcast-page";
    }
}
