package kr.spring.item.dao;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.item.vo.ItemVO;

@Mapper
public interface ItemMapper {
	//상품관리
	@Select("SELECT item_seq.nextval FROM dual")
	public Long selectItem_num();
	
	@Insert("INSERT INTO item (item_num,item_id,item_name) VALUES (#{item_num},#{item_id},#{item_name})")
	public void insertItem(ItemVO item);
	@Update("UPDATE item SET item_name=#{item_name} WHERE item_num=#{item_num}")
	public void updateItem(ItemVO item);
	public void deleteItem(Long item_num);
}
