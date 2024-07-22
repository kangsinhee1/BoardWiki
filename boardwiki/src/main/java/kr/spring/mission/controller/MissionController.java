package kr.spring.mission.controller;

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
import kr.spring.util.PagingUtil;

@Controller
public class MissionController {
	
	@Autowired
    private MissionService missionService;

    @GetMapping("/mission/form")
    public String showMissionForm() {
        return "missionForm";
    }

    @GetMapping("/mission/add")
    @ResponseBody
    public Map<String, String> addMission(long str_num, String mis_content, int mis_point,HttpSession session) {
    	Map<String,String> map = new HashMap<String, String>();
    	MemberVO user = (MemberVO)session.getAttribute("user");
    	if(user==null) {
    		map.put("result", "logout");
    	}else {
    		MissionVO mission = new MissionVO();
    		mission.setStr_num(str_num);
    		mission.setMis_content(mis_content);
    		mission.setMis_point(mis_point);
    		mission.setMem_num(user.getMem_num());
    		missionService.addMission(mission);
    		map.put("result", "success");
    	}
        return map;
    }

    @GetMapping("/mission/strlist")
    public String getMissionListByStream(long str_num,@RequestParam(defaultValue="1") int pageNum,Model model) {
    	Map<String, Object> map = new HashMap<String, Object>();
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
    	Map<String,Object> map = new HashMap<String, Object>();
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
    public Map<String, String> updateMissionStatus(long mis_num, int mis_status) {
    	MissionVO vo = new MissionVO();
    	Map<String, String> map = new HashMap<String, String>();
    	vo.setMis_status(mis_status);
    	vo.setMis_num(mis_num);
    	missionService.updateMissionStatus(vo);
    	map.put("result", "success");
        return map;
    }

    @PostMapping("/mission/delete")
    @ResponseBody
    public Map<String, String> deleteMission(long mis_num) {
    	Map<String, String> map = new HashMap<String, String>();
        missionService.deleteMission(mis_num);
        map.put("result", "success");
        return map;
    }
}
