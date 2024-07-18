package kr.spring.attendance.controller;

import java.time.LocalDate;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.spring.attendance.service.AttendanceService;
import kr.spring.attendance.vo.AttendanceVO;
import kr.spring.member.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class AttendanceController {
	@Autowired
    private AttendanceService attendanceService;
	@Autowired
    private ObjectMapper objectMapper;

    @GetMapping("/attendance/attendance")
    public String getAttendance(HttpSession session, Model model) {
    	
        MemberVO user = (MemberVO) session.getAttribute("user");
        if (user != null) {
            long mem_num = user.getMem_num();
            List<AttendanceVO> attendance = attendanceService.getMonthlyAttendance(mem_num);
            for(int i=0; i<attendance.size(); i++) {
            	if(attendance.get(i).getAtt_status() == 1) {
            		model.addAttribute("att_status",attendance.get(i).getAtt_status());
            	}
            }
            try {
                String attendancesJson = objectMapper.writeValueAsString(attendance);
                model.addAttribute("attendancesJson", attendancesJson);
            } catch (JsonProcessingException e) {
                e.printStackTrace();
                model.addAttribute("attendancesJson", "[]");
            }
        }
        return "attendance";
    }

    @PostMapping("/attendance/check")
    public String checkAttendance(HttpSession session,Model model) {
        MemberVO user = (MemberVO) session.getAttribute("user");
        if (user != null) {
        	AttendanceVO vo = new AttendanceVO();
            vo.setMem_num(user.getMem_num());
            vo.setAtt_date(LocalDate.now());
            attendanceService.checkAndInsertAttendance(vo);
        }
        
        model.addAttribute("message","출서체크 완료");
		model.addAttribute("url","/attendance/attendance");
		return "common/resultAlert";
    }
}
