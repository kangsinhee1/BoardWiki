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

	@Override
    public int rollDice(Long mem_num) {
        int diceVal = new Random().nextInt(6) + 1;
        long dice_num = diceMapper. getDiceByNum(mem_num);
        int cont = diceMapper.selectDicechanec(mem_num);
        if(cont >0) {
        	DiceVO diceValue = new DiceVO();
        	diceValue.setDice_num(dice_num);
            diceValue.setDice_val(diceVal);
            diceValue.setDice_date(LocalDate.now());
            diceMapper.insertDiceValue(diceValue);
            diceMapper.updateDicedown(mem_num);
        }

        return diceVal;
    }

	@Override
	public void insertDiceValue(DiceVO dice) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public Integer getDiceByNum(Long mem_num) {
		return null;
	}

	@Override
	public List<DiceVO> selectDice(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void insertDice(DiceVO dice) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public Integer selectDicechanec(Long mem_num) {
		return diceMapper.selectDicechanec(mem_num);
	}
}
