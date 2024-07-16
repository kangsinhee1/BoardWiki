package kr.spring.stream.controller;

import kr.spring.stream.service.BroadcastService;
import kr.spring.stream.service.StreamCreatingService;
import kr.spring.stream.service.StreamKeyService;
import kr.spring.stream.vo.BroadcastVO;
import kr.spring.stream.vo.StreamCreatingVO;
import kr.spring.stream.vo.StreamKeyVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
public class BroadcastController {

    @Autowired
    private BroadcastService broadcastService;
    
    @Autowired
    private StreamKeyService streamKeyService;
    
    @Autowired
    private StreamCreatingService streamCreatingService;

    @GetMapping("/streaming/broadcasts")
    public String getBroadcastList(HttpServletRequest request) {
        List<BroadcastVO> broadcasts = broadcastService.getAllBroadcasts();
        request.setAttribute("broadcasts", broadcasts);
        return "broadcast-list";
    }

    @GetMapping("/streaming/broadcast")
    public String getBroadcastPage(Long str_num, HttpServletRequest request) {
        BroadcastVO broadcast = broadcastService.findByMemNum(str_num);
        StreamKeyVO streamkey = streamKeyService.selectstream(str_num);
        StreamCreatingVO stream =  streamCreatingService.selectCreating(str_num);
        request.setAttribute("streamkey", streamkey);
        request.setAttribute("broadcast", broadcast);
        request.setAttribute("str", stream);
        return "broadcast-page";
    }
}
