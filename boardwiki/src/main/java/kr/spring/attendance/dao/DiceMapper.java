package kr.spring.attendance.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.attendance.vo.DiceVO;

@Mapper
public interface DiceMapper {
	@Select("SELECT item_seq.nextval FROM dual")
	public Long selectItem_num();
	@Insert("INSERT INTO dice (dice_num,mem_num,dice_chance) VALUES(#{dice_num},#{mem_num},#{dice_chance})")
	void insertDice(DiceVO dice);
	@Insert("INSERT INTO dice_value (dice_value_num,dice_num,dice_val) VALUES (dice_value_seq.nextval,#{dice_num},#{dice_val})")
    void insertDiceValue(DiceVO dice);
	@Select("SELECT dice_num FROM dice WHERE mem_num=#{mem_num}")
	Integer getDiceByNum(Long mem_num);
    @Select("SELECT * FROM (SELECT a.*, rownum rnum FROM (SELECT * FROM dice JOIN dice_value USING(dice_num) WHERE mem_num = #{mem_num})a) WHERE rnum >= #{start} AND rnum <= #{end}")
    List<DiceVO> selectDice(Map<String, Object>map);
    @Update("UPDATE dice SET dice_chance = dice_chance + 2 WHERE mem_num=#{mem_num}")
    void updateDice(DiceVO dice);
    @Select("SELECT COUNT(*) FROM dice WHERE mem_num=#{mem_num}")
    Integer selectDiceCunt(Long mem_num);

    @Select("SELECT dice_chance FROM dice where mem_num=#{mem_num}")
    Integer selectDicechanec(Long mem_num);
    @Update("UPDATE dice SET dice_chance = dice_chance - 1 WHERE mem_num=#{mem_num}")
    void updateDicedown(Long mem_num);

}
