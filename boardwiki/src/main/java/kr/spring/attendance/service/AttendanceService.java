package kr.spring.attendance.service;

import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

import kr.spring.attendance.vo.AttendanceVO;

public interface AttendanceService {
    List<AttendanceVO> getMonthlyAttendance(Long mem_num);
    int attendanceExists(AttendanceVO vo);
    void markAttendance(AttendanceVO vo);
    void insertAttendance(AttendanceVO vo);
    void checkAndInsertAttendance(AttendanceVO vo);
    
}
