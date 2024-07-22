package kr.spring.report.service;

import java.util.Map;

import kr.spring.report.vo.ReportVO;

public interface ReportService {
	public void insertReport(ReportVO reportVO);
	public Integer getReportRowCount(Map<String,Object>map);
}
