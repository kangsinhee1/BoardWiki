package kr.spring.point.controller;

import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import kr.spring.member.vo.MemberVO;
import kr.spring.point.service.PointService;
import kr.spring.point.vo.PointGameVO;
import kr.spring.point.vo.PointVO;
import lombok.extern.slf4j.Slf4j;

import java.util.List;

@Slf4j
@Controller
public class PointAjaxController {
    @Autowired
    private PointService pointService;
    
    @PostMapping("/point/getpoint")
    @ResponseBody
    public Map<String, String> getpoint(PointVO pointVO, HttpSession session) {
        Map<String, String> mapJson = new HashMap<>();
        
        MemberVO user = (MemberVO) session.getAttribute("user");
        if (user == null) {
            mapJson.put("result", "logout");
        } else {
            pointVO.setMem_num(user.getMem_num());
            pointService.processPointTransaction(pointVO);
            mapJson.put("result", "success");
        }
        return mapJson;
    }
    
    @PostMapping("/pointgame/create")
    @ResponseBody
    public Map<String, Object> createGame(@RequestBody Map<String, Object> payload, HttpSession session) {
        Map<String, Object> map = new HashMap<>();
        MemberVO user = (MemberVO) session.getAttribute("user");

        if (user == null) {
            map.put("result", "logout");
            return map;
        }

        long mem_num = user.getMem_num();
        long poiG_num = pointService.getNextPointGameSeq();
        String gameTitle = (String) payload.get("poiG_content");
        List<String> choices = (List<String>) payload.get("choices");

        PointGameVO gameVO = new PointGameVO();
        gameVO.setPoiG_content(gameTitle);
        gameVO.setMem_num(mem_num);
        gameVO.setPoiG_num(poiG_num);

        pointService.insertPointGame(gameVO);

        for (int i = 0; i < choices.size(); i++) {
            PointGameVO optionVO = new PointGameVO();
            optionVO.setPoiO_content(choices.get(i));
            optionVO.setPoiO_no(i + 1);
            optionVO.setPoiG_num(poiG_num);

            pointService.insertPointOption(optionVO);
        }

        map.put("result", "success");
        return map;
    }

    @PostMapping("/pointgame/bet")
    @ResponseBody
    public Map<String, Object> placeBet(@RequestBody Map<String, Object> payload, HttpSession session) {
        Map<String, Object> map = new HashMap<>();
        MemberVO user = (MemberVO) session.getAttribute("user");

        if (user == null) {
            map.put("result", "logout");
            return map;
        }

        Long mem_num = user.getMem_num();

        String poiO_numStr = (String) payload.get("poiO_num");
        String betPointStr = (String) payload.get("bet_point");
        String poiG_numStr = (String) payload.get("poiG_num");
        
        Long poiG_num = Long.valueOf(poiG_numStr);
        int betPoint = Integer.valueOf(betPointStr);
        Long poiO_num = Long.valueOf(poiO_numStr);
        
        PointGameVO user_num = pointService.selectPointGame(poiG_num);
        
        if(mem_num == user_num.getMem_num()) {
        	map.put("result", "autolet");
        	return map;
        }
        if(pointService.selectPointTotal(mem_num) < betPoint) {
        	map.put("result", "error");
        	return map;
        }
        
        log.debug("회원"+mem_num+"옵션값"+poiO_num);
        
        if(pointService.selectPointGameBetting(mem_num, poiO_num)!=null) {
        	map.put("result", "regame");
        	return map;
        }

        try {
            PointGameVO pointGameVO = new PointGameVO();
            pointGameVO.setMem_num(mem_num);
            pointGameVO.setPoiO_num(poiO_num);
            pointGameVO.setBet_point(betPoint);
            pointGameVO.setPoiG_num(poiG_num);

            pointService.insertPointBetting(pointGameVO);

            PointVO pointVO = new PointVO();
            pointVO.setMem_num(mem_num);
            pointVO.setPoi_use(betPoint);
            pointVO.setPoi_increase(1); // 1: Use points
            pointVO.setPoi_status(1);

            pointService.processPointTransaction(pointVO);

            map.put("result", "success");
        } catch (NumberFormatException e) {
            map.put("result", "error");
            map.put("message", "Invalid input: cannot parse numbers.");
        }

        return map;
    }

    @PostMapping("/pointgame/cancelParticipation")
    @ResponseBody
    public Map<String, Object> cancelParticipation(@RequestBody Map<String, Object> payload) {
        Map<String, Object> map = new HashMap<>();
        Long gameId = Long.valueOf((String) payload.get("gameId"));
        Long userId = Long.valueOf((String) payload.get("userId"));
        PointGameVO existingBet = pointService.selectPointGameBetting(userId, gameId);

        if (existingBet != null) {
            pointService.deletePointGameBetting(userId, gameId);
            PointVO pointVO = new PointVO();
            pointVO.setMem_num(userId);
            pointVO.setPoi_use(existingBet.getBet_point());
            pointVO.setPoi_increase(2); // 2: Gain points
            pointService.processPointTransaction(pointVO);

            map.put("result", "success");
        } else {
            map.put("result", "error");
            map.put("message", "No participation found.");
        }

        return map;
    }

    @PostMapping("/pointgame/cancelGame")
    @ResponseBody
    public Map<String, Object> cancelGame(@RequestBody Map<String, Object> payload, HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        MemberVO user = (MemberVO) session.getAttribute("user");

        if (user == null) {
            response.put("result", "logout");
            return response;
        }

        Long gameId = Long.valueOf((String) payload.get("gameId"));
        pointService.deletePointGame(gameId);

        response.put("result", "success");
        return response;
    }

    @PostMapping("/pointgame/selectWinner")
    @ResponseBody
    public Map<String, Object> selectWinner(@RequestBody Map<String, Object> payload, HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        MemberVO user = (MemberVO) session.getAttribute("user");

        if (user == null) {
            response.put("result", "logout");
            return response;
        }

        Long gameId = Long.valueOf(String.valueOf(payload.get("gameId")));
        Long winningOption = Long.valueOf(String.valueOf(payload.get("winningOption")));

        pointService.closeGame(gameId, winningOption);

        response.put("result", "success");
        return response;
    }

    @PostMapping("/pointgame/close/{poiG_num}")
    @ResponseBody
    public void closeGame(@PathVariable Long poiG_num, @RequestParam Long winningOption) {
        List<PointGameVO> bets = pointService.selectPointBettingList(winningOption);

        int totalPointsInWinningOption = bets.stream()
                .filter(bet -> bet.getPoiO_num().equals(winningOption))
                .mapToInt(PointGameVO::getBet_point)
                .sum();

        int totalPointsInAllOptions = bets.stream()
                .mapToInt(PointGameVO::getBet_point)
                .sum();

        for (PointGameVO bet : bets) {
            if (bet.getPoiO_num().equals(winningOption)) {
                int pointsWon = (int) Math.floor((double) bet.getBet_point() * totalPointsInAllOptions / totalPointsInWinningOption);

                PointVO pointVO = new PointVO();
                pointVO.setMem_num(bet.getMem_num());
                pointVO.setPoi_use(pointsWon);
                pointVO.setPoi_increase(2); // 2: Gain points

                pointService.processPointTransaction(pointVO);
            }
        }

        pointService.updatePointGame(poiG_num);
    }
}
