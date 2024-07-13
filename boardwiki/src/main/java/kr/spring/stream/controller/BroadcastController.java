package kr.spring.stream.controller;

import kr.spring.stream.service.BroadcastService;
import kr.spring.stream.vo.BroadcastVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
public class BroadcastController {

    @Autowired
    private BroadcastService broadcastService;

    @GetMapping("/streaming/broadcasts")
    public String getBroadcastList(HttpServletRequest request) {
        List<BroadcastVO> broadcasts = broadcastService.getAllBroadcasts();
        request.setAttribute("broadcasts", broadcasts);
        return "broadcast-list";
    }

    @GetMapping("/streaming/broadcast")
    public String getBroadcastPage(Long str_num, HttpServletRequest request) {
        BroadcastVO broadcast = broadcastService.getBroadcastByUsername(str_num);
        request.setAttribute("broadcast", broadcast);
        return "broadcast-page";
    }
}
