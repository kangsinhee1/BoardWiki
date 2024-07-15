package kr.spring.item.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.item.vo.ItemVO;

@Mapper
public interface ItemMapper {
	//상품관리
	public List<ItemVO> selectListByKeyword(Map<String,Object> map);
	public List<ItemVO> selectListByItemGenre(Map<String,Object> map);
	public List<ItemVO> selectList(Map<String,Object> map);
	public List<ItemVO> selectList2(Map<String,Object> map);
	public List<ItemVO> selectList3(Map<String,Object> map);
	public Integer selectRowCount(Map<String,Object> map);
	public Integer selectRowCount2(Map<String,Object> map);
	@Select("SELECT * FROM item WHERE item_num=#{item_num}")
	public ItemVO selectItem(Long item_num);
	@Select("SELECT item_seq.nextval FROM dual")
	public Long selectItem_num();
	@Insert("INSERT INTO item (item_num,item_id,item_name) VALUES (#{item_num},#{item_id},#{item_name})")
	public void insertItem(ItemVO item);
	@Update("UPDATE item SET item_name=#{item_name} WHERE item_num=#{item_num}")
	public void updateItem(ItemVO item);
	public void deleteItem(Long item_num);
	@Delete("DELETE FROM item WHERE item_num=#{item_num}")
	public void deleteBoard(Long item_num);
	//장바구니 관련
	@Select("SELECT item_stock FROM item WHERE item_num=#{item_num}")
	public int getItem(Long item_num);	
}
