package kr.spring.attendance.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import kr.spring.attendance.vo.DiceVO;

@Mapper
public interface DiceMapper {
	@Insert("INSERT INTO dice (dice_num,mem_num,dice_chance) VALUES(dice_seq.nextval,#{mem_num},#{dice_chance})")
	void insertDice(DiceVO dice);
	@Insert("INSERT INTO dice_value (dice_value_num,dice_num,dice_val) VALUES (dice_value_seq.nextval,#{dice_num},#{dice_val})")
    void insertDiceValue(Long dice_num, int dice_val);
	
    DiceVO getDiceByNum(Long dice_num);
    @Select("SELECT * FROM (SELECT a.*, rownum rnum FROM (SELECT * FROM dice JOIN dice_value USING(dice_num) WHERE mem_num = #{mem_num})a) WHERE rnum >= #{start} AND rnum <= #{end}")
    List<DiceVO> selectDice(Map<String, Object>map);
}
