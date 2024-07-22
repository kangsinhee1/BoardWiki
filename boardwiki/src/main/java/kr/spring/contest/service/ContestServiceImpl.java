package kr.spring.contest.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.contest.dao.ContestMapper;
import kr.spring.contest.vo.ContestApplyVO;
import kr.spring.contest.vo.ContestVO;

@Service
@Transactional
public class ContestServiceImpl implements ContestService{
	@Autowired
	ContestMapper contestmapper;

	@Override
	public Integer selectRowCount(Map<String, Object> map) {
		return contestmapper.selectRowCount(map);
	}

	@Override
	public List<ContestVO> selectContestList(Map<String, Object> map) {
		return contestmapper.selectContestList(map);
	}

	@Override
	public void insertContest(ContestVO contest) {
		contestmapper.insertContest(contest);

	}

	@Override
	public ContestVO detailContest(long con_num) {
		// TODO Auto-generated method stub
		return contestmapper.detailContest(con_num);
	}

	@Override
	public void updateContestHit(Long con_num) {
		contestmapper.updateContestHit(con_num);

	}

	@Override
	public void applyForContest(ContestApplyVO contestApplyVO) {
		contestmapper.applyForContest(contestApplyVO);

	}

	@Override
	public Integer selectContestApplyList(ContestApplyVO contestApplyVO) {
		return contestmapper.selectContestApplyList(contestApplyVO);
	}
}
