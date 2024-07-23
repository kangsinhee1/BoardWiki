package kr.spring.attendance.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.spring.attendance.dao.AttendanceMapper;
import kr.spring.attendance.dao.DiceMapper;
import kr.spring.attendance.vo.AttendanceVO;
import kr.spring.attendance.vo.DiceVO;

@Service
public class AttendanceServiceImpl implements AttendanceService{

	@Autowired
	AttendanceMapper attendanceMapper;

	@Autowired
    private DiceMapper diceMapper;

	@Override
	public List<AttendanceVO> getMonthlyAttendance(Long mem_num) {
		return attendanceMapper.getMonthlyAttendance(mem_num);
	}

	@Override
	public int attendanceExists(AttendanceVO vo) {
		return attendanceMapper.attendanceExists(vo);
	}

	@Override
	public void markAttendance(AttendanceVO vo) {
		attendanceMapper.markAttendance(vo);
	}

	@Override
	public void insertAttendance(AttendanceVO vo) {
		attendanceMapper.insertAttendance(vo);
	}

	@Override
	public void checkAndInsertAttendance(AttendanceVO vo) {
		if (attendanceMapper.attendanceExists(vo) == 0) {
			attendanceMapper.insertAttendance(vo);
		}
		attendanceMapper.markAttendance(vo);
		DiceVO dice = new DiceVO();
        Integer count = 0;
        count = diceMapper.selectDiceCunt(vo.getMem_num());
        dice.setMem_num(vo.getMem_num());
        if(count == 1) {
        	diceMapper.updateDice(dice);
        }else {
        	dice.setDice_num(diceMapper.selectItem_num());
            dice.setDice_chance(2);
            diceMapper.insertDice(dice);
        }
	}

	@Override
	public AttendanceVO getAttendance(Long mem_num) {
		return attendanceMapper.getAttendance(mem_num);
	}

}
