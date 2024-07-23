package kr.spring.mission.controller;

import java.net.http.HttpResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.member.vo.MemberVO;
import kr.spring.mission.service.MissionService;
import kr.spring.mission.vo.MissionVO;
import kr.spring.point.service.PointService;
import kr.spring.point.vo.PointVO;
import kr.spring.stream.service.StreamKeyService;
import kr.spring.util.PagingUtil;

@Controller
public class MissionController {

	@Autowired
    private MissionService missionService;
	@Autowired
	private PointService pointService;
	@Autowired
	private StreamKeyService streamKeyService;

    @GetMapping("/mission/form")
    public String showMissionForm(HttpSession session, Model model) {
    	MemberVO user = (MemberVO) session.getAttribute("user");
    	int point = 0;
    	
    	if(user==null) {
    		model.addAttribute("logout","로그인 필요");
    	}else {
    		point = pointService.selectPointTotal(user.getMem_num());
    		model.addAttribute("user",user);
    		model.addAttribute("point",point);
    	}
    	
        return "missionForm";
    }

    @GetMapping("/mission/add")
    @ResponseBody
    public Map<String, String> addMission(long str_num, String mis_content, int mis_point,HttpSession session) {
    	Map<String,String> map = new HashMap<>();
    	MemberVO user = (MemberVO)session.getAttribute("user");
    	int point = 0;
    	if(user==null) {
    		map.put("result", "logout");
    	}else {
    		point = pointService.selectPointTotal(user.getMem_num());
    		if(point < mis_point) {
    			map.put("result", "rowpoint");
    		}else {
    		MissionVO mission = new MissionVO();
    		mission.setStr_num(str_num);
    		mission.setMis_content(mis_content);
    		mission.setMis_point(mis_point);
    		mission.setMem_num(user.getMem_num());

            PointVO point2 = new PointVO();
    		point2.setMem_num(user.getMem_num());
    		point2.setPoi_use(mis_point);
    		point2.setPoi_increase(1);
    		point2.setPoi_status(4);
            pointService.processPointTransaction(point2);
            missionService.addMission(mission);
    		
    		map.put("result", "success");
    		}
    	}
        return map;
    }

    @GetMapping("/mission/strlist")
    public String getMissionListByStream(long str_num,@RequestParam(defaultValue="1") int pageNum,Model model) {
    	Map<String, Object> map = new HashMap<>();
        List<MissionVO> list = null;
        map.put("str_num", str_num);
        int count = missionService.selectcountstream(map);
        PagingUtil page = new PagingUtil(pageNum, count, 20, 10, "misstreamlist");
        map.put("start", page.getStartRow());
	    map.put("end", page.getEndRow());
    	if (count > 0) {
		     map.put("start", page.getStartRow());
		     map.put("end", page.getEndRow());

		     list = missionService.getMissionsByStream(map);
		}

    	model.addAttribute("count", count);
		model.addAttribute("list", list);
		model.addAttribute("page", page.getPage());

        missionService.getMissionsByStream(map);

        return "misstreamlist";
    }

    @GetMapping("/mission/userlist")
    public String getMissionListByMember(HttpSession session,long str_num, @RequestParam(defaultValue="1") int pageNum,Model model) {
    	Map<String,Object> map = new HashMap<>();
    	MemberVO user = (MemberVO) session.getAttribute("user");
    	map.put("mem_num", user.getMem_num());
    	map.put("str_num", str_num);

    	int count = missionService.selectcountmember(map);

    	PagingUtil page = new PagingUtil(pageNum, count, 20, 10, "mismemberlist");

    	List<MissionVO> list = null;

    	if (count > 0) {
		     map.put("start", page.getStartRow());
		     map.put("end", page.getEndRow());

		     list = missionService.getMissionsByMember(map);
		}

    	model.addAttribute("count", count);
		model.addAttribute("list", list);
		model.addAttribute("page", page.getPage());
        return "mismemberlist";
    }

    @PostMapping("/mission/updateStatus")
    @ResponseBody
    public Map<String, String> updateMissionStatus(long mis_num, int mis_status, long str_num,HttpSession session, long mem_num,int mis_point) {
    	MemberVO user = (MemberVO) session.getAttribute("user");
    	MissionVO vo = new MissionVO();
    	int strNum = 0;
    	Map<String, String> map = new HashMap<>();
    	vo.setMis_status(mis_status);
    	vo.setMis_num(mis_num);
    	if(mis_status == 3) {
    		PointVO pointVO = new PointVO();
    		strNum = streamKeyService.streamingNum(str_num);
            pointVO.setMem_num(strNum);
            pointVO.setPoi_use(mis_point);
            pointVO.setPoi_increase(2);
            pointVO.setPoi_status(4);
            pointService.processPointTransaction(pointVO);
    	}else if(mis_status == 4) {
    		PointVO point2 = new PointVO();
    		if(mem_num == 0) {
    			point2.setMem_num(user.getMem_num());
    		}else {
    			point2.setMem_num(mem_num);
    		}
    		point2.setPoi_use(mis_point);
    		point2.setPoi_increase(2);
    		point2.setPoi_status(4);
            pointService.processPointTransaction(point2);
    	}
    	
    	
    	missionService.updateMissionStatus(vo);
    	map.put("result", "success");
        return map;
    }

    @PostMapping("/mission/delete")
    @ResponseBody
    public Map<String, String> deleteMission(long mis_num, HttpSession session, int mis_point, long mem_num) {
    	MemberVO user = (MemberVO) session.getAttribute("user");
    	Map<String, String> map = new HashMap<>();
        PointVO point2 = new PointVO();
        if(mem_num == 0) {
			point2.setMem_num(user.getMem_num());
		}else {
			point2.setMem_num(mem_num);
		}
		point2.setPoi_use(mis_point);
		point2.setPoi_increase(2);
		point2.setPoi_status(4);
        pointService.processPointTransaction(point2);
        missionService.deleteMission(mis_num);
        map.put("result", "success");
        return map;
    }
}
