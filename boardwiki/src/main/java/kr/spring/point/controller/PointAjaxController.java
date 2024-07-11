package kr.spring.point.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import kr.spring.member.vo.MemberVO;
import kr.spring.point.service.PointService;
import kr.spring.point.vo.PointGameVO;
import kr.spring.point.vo.PointVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class PointAjaxController {
	@Autowired
	private PointService pointService;
	
	/**포인트 변동 등록*/
	@PostMapping("/point/getpoint")
	@ResponseBody
	public Map<String, String> getpoint(PointVO pointVO,HttpSession session,HttpServletRequest request){
		Map<String,String> mapJson = new HashMap<String, String>();
		
		MemberVO user=(MemberVO)session.getAttribute("user");
		if(user == null) {
			mapJson.put("result", "logout");
		}else {
			pointVO.setMem_num(user.getMem_num());
			
			pointService.processPointTransaction(pointVO);
			mapJson.put("result", "success");
		}
		return mapJson;
	}
	
	@PostMapping("/pointgame/create")
    @ResponseBody
    public void createGame(@RequestBody Map<String, Object> payload, HttpSession session) {
        MemberVO user = (MemberVO) session.getAttribute("user");
        long mem_num = user.getMem_num();

        String gameTitle = (String) payload.get("poiG_content");
        List<String> choices = (List<String>) payload.get("choices");

        PointGameVO gameVO = new PointGameVO();
        gameVO.setPoiG_content(gameTitle);
        gameVO.setStr_num(0); // Placeholder, replace with actual logic to set the stream number
        gameVO.setMem_num(mem_num);

        pointService.insertPointGame(gameVO);

        for (int i = 0; i < choices.size(); i++) {
            PointGameVO optionVO = new PointGameVO();
            optionVO.setPoiO_content(choices.get(i));
            optionVO.setPoiO_no(i + 1);
            optionVO.setPoiG_num(gameVO.getPoiG_num());

            pointService.insertPointOption(optionVO);
        }
    }
	
	@PostMapping("/pointgame/bet")
    @ResponseBody
    public void placeBet(@RequestBody Map<String, Object> payload, HttpSession session) {
        MemberVO user = (MemberVO) session.getAttribute("user");
        long mem_num = user.getMem_num();
        log.debug("<<회원 번호 확인>>"+mem_num);

        Long poiO_num = Long.valueOf((String) payload.get("poiO_num"));
        int betPoint = Integer.valueOf((String) payload.get("bet_point"));

        PointGameVO pointGameVO = new PointGameVO();
        pointGameVO.setMem_num(mem_num);
        pointGameVO.setPoiO_num(poiO_num);
        pointGameVO.setBet_point(betPoint);

        pointService.insertPointBetting(pointGameVO);

        PointVO pointVO = new PointVO();
        pointVO.setMem_num(mem_num);
        pointVO.setPoi_use(betPoint);
        pointVO.setPoi_increase(1); // 1: Use points

        pointService.processPointTransaction(pointVO);
    }

    @PostMapping("/pointgame/cancelBet")
    @ResponseBody
    public void cancelBet(@RequestBody Map<String, Object> payload, HttpSession session) {
        MemberVO user = (MemberVO) session.getAttribute("user");
        long mem_num = user.getMem_num();

        Long poiO_num = Long.valueOf((String) payload.get("poiO_num"));
        int betPoint = Integer.valueOf((String) payload.get("bet_point"));

        pointService.deletePointGameBetting(mem_num, poiO_num);

        PointVO pointVO = new PointVO();
        pointVO.setMem_num(mem_num);
        pointVO.setPoi_use(betPoint);
        pointVO.setPoi_increase(2); // 2: Gain points

        pointService.processPointTransaction(pointVO);
    }

    @PostMapping("/pointgame/close/{poiG_num}")
    @ResponseBody
    public void closeGame(@PathVariable Long poiG_num, @RequestParam Long winningOption) {
        Map<String, Object> params = Map.of("poiG_num", poiG_num);
        List<PointGameVO> bets = pointService.selectPointGameBettingList(params);

        int totalPointsInWinningOption = bets.stream()
                .filter(bet -> bet.getPoiO_num().equals(winningOption))
                .mapToInt(PointGameVO::getBet_point)
                .sum();

        int totalPointsInAllOptions = bets.stream()
                .mapToInt(PointGameVO::getBet_point)
                .sum();

        for (PointGameVO bet : bets) {
            if (bet.getPoiO_num().equals(winningOption)) {
                int pointsWon = (bet.getBet_point() * totalPointsInAllOptions) / totalPointsInWinningOption;

                PointVO pointVO = new PointVO();
                pointVO.setMem_num(bet.getMem_num());
                pointVO.setPoi_use(pointsWon);
                pointVO.setPoi_increase(2); // 2: Gain points

                pointService.processPointTransaction(pointVO);
            }
        }
    }
}
