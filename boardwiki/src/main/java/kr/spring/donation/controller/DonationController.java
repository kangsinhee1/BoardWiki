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
import kr.spring.util.PagingUtil;

@Controller
public class DonationController {

	    @Autowired
	    private DonationService donationService;

	    @GetMapping("/donation/form")
	    public String donationfrom() {
	    	return "broadcast";
	    }

	    @GetMapping("/donation/add")
	    @ResponseBody
	    public Map<String, String> addDonation(long str_num,String don_content,int don_point, HttpSession session) {
	    	Map<String, String> mapJson = new HashMap<>();
	    	DonationVO donation = new DonationVO();
	    	MemberVO user = (MemberVO) session.getAttribute("user");

	    	if(user==null) {
	    		mapJson.put("result", "logout");
	    	}else {
	    		donation.setMem_num(user.getMem_num());
	    		donation.setDon_content(don_content);
	    		donation.setDon_point(don_point);
	    		donation.setStr_num(str_num);
	    		donationService.addDonation(donation);
	    		mapJson.put("result", "success");
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
