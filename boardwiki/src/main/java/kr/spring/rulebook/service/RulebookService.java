package kr.spring.rulebook.service;

import java.util.List;
import java.util.Map;

import kr.spring.rulebook.vo.RulebookVO;

public interface RulebookService {
	public List<RulebookVO> selectRulebookList(Map<String,Object> map);
	public Integer selectRulebookRowCount(Map<String,Object> map);
	public void insertRulebook(RulebookVO rulebook);
	public RulebookVO selectRulebook(Long rulB_num);
	public void updateRulebook(RulebookVO rulebook);
	public void deleteRulebook(Long rulB_num);
	public void deleteRulebookFile(Long rulB_num);
}
