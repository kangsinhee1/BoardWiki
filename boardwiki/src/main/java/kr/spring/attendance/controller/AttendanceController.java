package kr.spring.attendance.controller;

import java.time.LocalDate;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.spring.attendance.service.AttendanceService;
import kr.spring.attendance.service.DiceService;
import kr.spring.attendance.vo.AttendanceVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.point.service.PointService;
import kr.spring.point.vo.PointVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class AttendanceController {
	@Autowired
    private AttendanceService attendanceService;
	@Autowired
    private ObjectMapper objectMapper;
	@Autowired
	private DiceService diceService;
	@Autowired
    private PointService pointService;

    @GetMapping("/attendance/attendance")
    public String getAttendance(HttpSession session, Model model) {
    	
        MemberVO user = (MemberVO) session.getAttribute("user");
        if (user != null) {
            long mem_num = user.getMem_num();
            int dice = 0;
            dice = diceService.selectDicechanec(mem_num);
            
            model.addAttribute("dice",dice);
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
    
    @GetMapping("/attendance/roll-dice")
    @ResponseBody
    public ResponseEntity<Integer> rollDice(HttpSession session,Model model) {
        MemberVO user = (MemberVO) session.getAttribute("user");
        if (user != null) {
            Long mem_num = user.getMem_num();
            int diceRollResult = diceService.rollDice(mem_num);
            
            PointVO pointVO = new PointVO();
            pointVO.setMem_num(mem_num);
            pointVO.setPoi_use(diceRollResult * 100);
            pointVO.setPoi_increase(2); // 2: Gain points
            pointVO.setPoi_status(1);
            pointService.processPointTransaction(pointVO);
            return ResponseEntity.ok(diceRollResult);
        } else {
            return ResponseEntity.status(401).build();
        }
    }
}
