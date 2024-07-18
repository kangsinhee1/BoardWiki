package kr.spring.attendance.service;

import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.spring.attendance.dao.AttendanceMapper;
import kr.spring.attendance.vo.AttendanceVO;

@Service
public class AttendanceServiceImpl implements AttendanceService{

	@Autowired
	AttendanceMapper attendanceMapper;

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

	public void checkAndInsertAttendance(AttendanceVO vo) {
		if (attendanceMapper.attendanceExists(vo) == 0) {
			attendanceMapper.insertAttendance(vo);
		}
		attendanceMapper.markAttendance(vo);
	}

}
