package kr.spring.attendance.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.attendance.vo.AttendanceVO;

@Mapper
public interface AttendanceMapper {
	@Select("SELECT * FROM attendance WHERE TO_CHAR(att_date, 'MM') = TO_CHAR(SYSDATE, 'MM') AND mem_num = #{mem_num}")
    List<AttendanceVO> getMonthlyAttendance(Long mem_num);

	@Select("SELECT COUNT(*) FROM attendance WHERE att_date = #{att_date} AND mem_num = #{mem_num}")
    int attendanceExists(AttendanceVO vo);

    @Update("UPDATE attendance SET att_status = 1 WHERE att_date = #{att_date} AND mem_num=#{mem_num}")
    void markAttendance(AttendanceVO vo);

    @Insert("INSERT INTO attendance (att_num,att_date, att_status, mem_num) VALUES (attendance_seq.nextval,#{att_date}, 2, #{mem_num})")
    void insertAttendance(AttendanceVO vo);
}
