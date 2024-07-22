package kr.spring.attendance.service;

import java.util.List;
import java.util.Map;

import kr.spring.attendance.vo.DiceVO;

public interface DiceService {
	void insertDice(DiceVO dice);
    void insertDiceValue(DiceVO dice);
    Integer getDiceByNum(Long mem_num);
    List<DiceVO> selectDice(Map<String, Object>map);
    int rollDice(Long mem_num);
    Integer selectDicechanec(Long mem_num);
}
