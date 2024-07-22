package kr.spring.rulebook.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.rulebook.dao.RulebookMapper;
import kr.spring.rulebook.vo.RulebookVO;

@Service
@Transactional
public class RulebookServiceImpl implements RulebookService{
	@Autowired
	RulebookMapper rulebookMapper;

	@Override
	public List<RulebookVO> selectRulebookList(Map<String, Object> map) {
		return rulebookMapper.selectRulebookList(map);
	}

	@Override
	public Integer selectRulebookRowCount(Map<String, Object> map) {
		return rulebookMapper.selectRulebookRowCount(map);
	}

	@Override
	public void insertRulebook(RulebookVO rulebook) {
		rulebookMapper.insertRulebook(rulebook);
	}

	@Override
	public RulebookVO selectRulebook(Long rulB_num) {
		return rulebookMapper.selectRulebook(rulB_num);
	}

	@Override
	public void updateRulebook(RulebookVO rulebook) {
		rulebookMapper.updateRulebook(rulebook);
	}

	@Override
	public void deleteRulebook(Long rulB_num) {
		rulebookMapper.deleteRulebook(rulB_num);
	}

	@Override
	public void deleteRulebookFile(Long rulB_num) {
		rulebookMapper.deleteRulebookFile(rulB_num);
	}

}
