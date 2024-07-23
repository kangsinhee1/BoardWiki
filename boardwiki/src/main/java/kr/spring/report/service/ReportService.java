package kr.spring.report.service;

import java.util.List;
import java.util.Map;

import kr.spring.report.vo.ReportVO;

public interface ReportService {
	public void insertReport(ReportVO reportVO);
	//신고 모음
	public Integer getReportRowCount(Map<String,Object>map);
	//신고 vo 리스트에 넣기
	public List<ReportVO> selectReportList(Map<String,Object>map);
	
	public ReportVO selectReportDetail(Long report_typeDetail, int report_type);
}
