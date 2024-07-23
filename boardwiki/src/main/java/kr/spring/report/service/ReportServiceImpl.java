package kr.spring.report.service;

import java.util.List;
import java.util.Map;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.spring.report.dao.ReportMapper;
import kr.spring.report.vo.ReportVO;

@Service
@Transactional
public class ReportServiceImpl implements ReportService {

	@Autowired
	ReportMapper reportMapper;


	@Override
	public void insertReport(ReportVO reportVO) {
		reportMapper.insertReport(reportVO);
	}


	@Override
	public Integer getReportRowCount(Map<String, Object> map) {
		return reportMapper.getReportRowCount(map);
	}


	@Override
	public List<ReportVO> selectReportList(Map<String, Object> map) {
		return reportMapper.selectReportList(map);
	}


	@Override
	public ReportVO selectReportDetail(Long report_typeDetail, int report_type) {
		return reportMapper.selectReportDetail(report_typeDetail, report_type);
	}

}
