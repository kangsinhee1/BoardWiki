package kr.spring.report.service;

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

}
