package kr.spring.attendance.service;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.spring.attendance.dao.DiceMapper;
import kr.spring.attendance.vo.DiceVO;

@Service
public class DiceServiceImpl implements DiceService{
	
	@Autowired
    private DiceMapper diceMapper;
	
	public int rollDice() {
        return new Random().nextInt(6) + 1;
    }

	@Override
	public void insertDice(DiceVO dice) {
		int diceVal = new Random().nextInt(6) + 1;
        dice.setDice_chance(1); // 주사위를 굴릴 기회를 1로 설정
        dice.setDice_date(LocalDate.now());

		
	}

	@Override
	public void insertDiceValue(Long dice_num, int dice_val) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public DiceVO getDiceByNum(Long dice_num) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<DiceVO> selectDice(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}
}
