package kr.spring.contest.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.contest.dao.ContestMapper;
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
}
