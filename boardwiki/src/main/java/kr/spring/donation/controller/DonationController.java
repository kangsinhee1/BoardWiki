package kr.spring.donation.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.donation.service.DonationService;
import kr.spring.donation.vo.DonationVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.point.service.PointService;
import kr.spring.point.vo.PointVO;
import kr.spring.stream.service.StreamKeyService;
import kr.spring.util.PagingUtil;

@Controller
public class DonationController {

	    @Autowired
	    private DonationService donationService;
	    
	    @Autowired
	    private PointService pointService;
	    
	    @Autowired
	    private StreamKeyService streamKeyService;

	    @GetMapping("/donation/form")
	    public String donationfrom(HttpSession session, Model model) {
	    	MemberVO user = (MemberVO) session.getAttribute("user");
	    	int point = 0;
	    	
	    	if(user==null) {
	    		model.addAttribute("logout","로그인 필요");
	    	}else {
	    		point = pointService.selectPointTotal(user.getMem_num());
	    		model.addAttribute("user",user);
	    		model.addAttribute("point",point);
	    	}
	    	return "broadcast";
	    }

	    @GetMapping("/donation/add")
	    @ResponseBody
	    public Map<String, String> addDonation(long str_num,String don_content,int don_point, HttpSession session) {
	    	Map<String, String> mapJson = new HashMap<>();
	    	DonationVO donation = new DonationVO();
	    	MemberVO user = (MemberVO) session.getAttribute("user");
	    	int strNum = 0;
	    	int point = 0;
	    	
	    	if(user==null) {
	    		mapJson.put("result", "logout");
	    	}else {
	    		point = pointService.selectPointTotal(user.getMem_num());
	    		if(point < don_point) {
	    			mapJson.put("result", "rowpoint");
	    		}else {
	    			donation.setMem_num(user.getMem_num());
		    		donation.setDon_content(don_content);
		    		donation.setDon_point(don_point);
		    		donation.setStr_num(str_num);
		    		PointVO pointVO = new PointVO();
		    		strNum = streamKeyService.streamingNum(str_num);
		            pointVO.setMem_num(strNum);
		            pointVO.setPoi_use(don_point);
		            pointVO.setPoi_increase(2);
		            pointVO.setPoi_status(3);
		            pointService.processPointTransaction(pointVO);
		            
		            PointVO point2 = new PointVO();
		    		point2.setMem_num(user.getMem_num());
		    		point2.setPoi_use(don_point);
		    		point2.setPoi_increase(1);
		    		point2.setPoi_status(3);
		            pointService.processPointTransaction(point2);
		            donationService.addDonation(donation);
		    		mapJson.put("result", "success");
	    		}
	    	}

	        return mapJson;
	    }

	    @GetMapping("/donation/strlist")
	    public String getDonationsByStream(long str_num, @RequestParam(defaultValue="1") int pageNum,Model model) {
	    	Map<String,Object> map = new HashMap<>();
	    	map.put("str_num", str_num);
	    	int count = donationService.SelectDonationscount(map);

	    	PagingUtil page = new PagingUtil(pageNum, count, 20, 10, "strlist");

	    	List<DonationVO> list = null;

	    	if (count > 0) {
			     map.put("start", page.getStartRow());
			     map.put("end", page.getEndRow());

			     list = donationService.getDonationsByStream(map);
			}

	    	model.addAttribute("count", count);
			model.addAttribute("list", list);
			model.addAttribute("page", page.getPage());

	        return "strlist";
	    }

	    @GetMapping("/donation/userlist")
	    public String getDonationsByMember(HttpSession session,long str_num, @RequestParam(defaultValue="1") int pageNum,Model model) {
	    	Map<String,Object> map = new HashMap<>();
	    	MemberVO user = (MemberVO) session.getAttribute("user");
	    	map.put("mem_num", user.getMem_num());
	    	map.put("str_num", str_num);

	    	int count = donationService.SelectDonationcount(map);

	    	PagingUtil page = new PagingUtil(pageNum, count, 20, 10, "userlist");

	    	List<DonationVO> list = null;

	    	if (count > 0) {
			     map.put("start", page.getStartRow());
			     map.put("end", page.getEndRow());

			     list = donationService.getDonationsByMember(map);
			}

	    	model.addAttribute("count", count);
			model.addAttribute("list", list);
			model.addAttribute("page", page.getPage());

	    	return "userlist";
	    }

}
