package kr.spring.report.dao;

import org.apache.ibatis.annotations.Mapper;

import kr.spring.report.vo.ReportVO;

@Mapper
public interface ReportMapper {
	
	
	//신고 접수
	public void insertReport(ReportVO reportVO);
}
