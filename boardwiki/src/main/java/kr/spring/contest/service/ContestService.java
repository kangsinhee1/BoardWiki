package kr.spring.contest.service;

import java.util.List;
import java.util.Map;

import kr.spring.contest.vo.ContestVO;

public interface ContestService {
	//목록보기
	public Integer selectRowCount(Map<String,Object>map);
	//대회리스트
	public List<ContestVO> selectContestList(Map<String,Object>map);
}
