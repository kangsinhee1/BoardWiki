package kr.spring.report.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.spring.report.vo.ReportVO;

@Mapper
public interface ReportMapper {


	//신고 접수
	public void insertReport(ReportVO reportVO);
	//신고 모음
	public Integer getReportRowCount(Map<String,Object>map);
	//신고 vo 리스트에 넣기
	public List<ReportVO> selectReportList(Map<String,Object>map);
	
	//신고 상세 내용 찾기
	public ReportVO selectReportDetail(Long report_typeDetail, int report_type);
}
