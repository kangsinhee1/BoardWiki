package kr.spring.contest.service;

import java.util.List;
import java.util.Map;

import kr.spring.contest.vo.ContestApplyVO;
import kr.spring.contest.vo.ContestVO;

public interface ContestService {
	//목록보기
	public Integer selectRowCount(Map<String,Object>map);
	//대회리스트
	public List<ContestVO> selectContestList(Map<String,Object>map);
	//대회 작성
	public void insertContest(ContestVO contest);
	//대회 상세
	public ContestVO detailContest(long con_num);
	//조회수 업데이트
	public void updateContestHit(Long con_num);
	//유저 대회 신청
	public void applyForContest(ContestApplyVO contestApplyVO);
	
	public Integer selectContestApplyList(ContestApplyVO contestApplyVO);
}
