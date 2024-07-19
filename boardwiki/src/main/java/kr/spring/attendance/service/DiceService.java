package kr.spring.attendance.service;

import java.util.List;
import java.util.Map;

import kr.spring.attendance.vo.DiceVO;

public interface DiceService {
	void insertDice(DiceVO dice);
    void insertDiceValue(Long dice_num, int dice_val);
    DiceVO getDiceByNum(Long dice_num);
    List<DiceVO> selectDice(Map<String, Object>map);
}
