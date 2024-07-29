package kr.spring.point.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;

import kr.spring.member.vo.MemberVO;
import kr.spring.point.service.PointService;
import kr.spring.point.vo.PointGameVO;
import kr.spring.point.vo.PointVO;
import kr.spring.util.PagingUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class Pointcontroller {
	@Autowired
	private PointService pointService;

	@ModelAttribute
	public PointVO initCommand() {
		return new PointVO();
	}
	/**포인트 목록*/
	@GetMapping("/myPage/pointList")
	public String getList(
	        @RequestParam(defaultValue="1") int pageNum,
	        @RequestParam(defaultValue="") String poi_status,
	        Model model, HttpSession session) {

	    MemberVO user = (MemberVO) session.getAttribute("user");
	    long mem_num = user.getMem_num();
	    int point = 0;

	    log.debug("<<포인트 목록 - poi_status>> : {}", poi_status);
	    log.debug("<<포인트 목록 - user>> : {}", mem_num);

	    Map<String, Object> map = new HashMap<>();
	    map.put("mem_num", mem_num);
	    if (!poi_status.isEmpty()) {
	        map.put("poi_status", Integer.parseInt(poi_status));
	    }

	    // 전체, 검색 레코드 수
	    int count = pointService.selectRowCount(map);

	    // 페이지 처리
	    PagingUtil page = new PagingUtil(pageNum, count, 20, 10, "list",
	            "&poi_status=" + poi_status + "&mem_num=" + mem_num);

	    List<PointVO> list = null;
	    if (count > 0) {
	        map.put("start", page.getStartRow());
	        map.put("end", page.getEndRow());

	        list = pointService.selectPointList(map);
	        point = pointService.selectPointTotal(mem_num);
	    }

	    model.addAttribute("count", count);
	    model.addAttribute("list", list);
	    model.addAttribute("page", page.getPage());
	    model.addAttribute("point", point);

	    return "pointList";
	}

	@GetMapping("/pointgame/create")
    public String createGamePage() {
        return "createGame";
    }

	@GetMapping("/pointgame/list")
    public String gameListPage(@RequestParam(defaultValue="1") int pageNum,
	        				   @RequestParam(defaultValue="") String poi_status,
	        				   Integer poi_ck,
	        				   Model model, HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user!=null) {
			model.addAttribute("mem_auth",user.getMem_auth());
		}
		Map<String,Object> map = new HashMap<>();

		if (!poi_status.isEmpty()) {
		   map.put("poi_status", Integer.parseInt(poi_status));
		}

		// 전체, 검색 레코드 수
		int count = pointService.selectPointGameRowCount(map);

		// 페이지 처리
		PagingUtil page = new PagingUtil(pageNum, count, 20, 10, "gameList");

		List<PointGameVO> list = null;
		if (count > 0) {
		     map.put("start", page.getStartRow());
		     map.put("end", page.getEndRow());

		     list = pointService.selectPointGameList(map);
		}
		
		model.addAttribute("count", count);
		model.addAttribute("list", list);
		model.addAttribute("page", page.getPage());

		poi_ck = 0;

		if(poi_ck!=0 || poi_ck!=null) {
			map.put("poi_ck", poi_ck);
		}

        return "gameList";
    }

	@GetMapping("/pointgame/participate")
    public String participateGamePage(@RequestParam(defaultValue="1") int pageNum,
    								  Long poiG_num, Model model,
    								  HttpSession session) {
		Map<String,Object> map = new HashMap<>();



		// 전체, 검색 레코드 수
		int count = pointService.selectPointGameRowCount(map);

		PointGameVO game = pointService.selectPointGame(poiG_num);

		// 페이지 처리
		PagingUtil page = new PagingUtil(pageNum, count, 20, 10, "participateGame");

		List<PointGameVO> list = null;
		if (count > 0) {
			 map.put("start", page.getStartRow());
			 map.put("end", page.getEndRow());
			 map.put("poiG_num", poiG_num);

			 list = pointService.selectPointGameOptionList(map);
		}

		model.addAttribute("count", count);
		model.addAttribute("list", list);
		model.addAttribute("page", page.getPage());



        model.addAttribute("game", game);

        return "participateGame";
    }

	@GetMapping("/pointgame/manageGames")
    public String manageGames(@SessionAttribute("user") MemberVO user, Model model) {
        if (user == null) {
            return "redirect:/member/login";
        }

        Long mem_num = user.getMem_num();
        List<PointGameVO> createdGames = pointService.getCreatedGames(mem_num);

        for (PointGameVO game : createdGames) {
            List<PointGameVO> options = pointService.getGameOptions(game.getPoiG_num());
            game.setOptions(options);
        }

        model.addAttribute("createdGames", createdGames);
        return "manageGame";
    }
}
