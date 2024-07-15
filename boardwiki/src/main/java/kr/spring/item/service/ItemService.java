package kr.spring.item.service;

import java.util.List;
import java.util.Map;

import kr.spring.item.vo.ItemVO;

public interface ItemService {
	public List<ItemVO> selectListByKeyword(Map<String,Object> map);
	public List<ItemVO> selectListByItemGenre(Map<String,Object> map);
	public List<ItemVO> selectList(Map<String,Object> map);
	public List<ItemVO> selectList2(Map<String,Object> map);
	public List<ItemVO> selectList3(Map<String,Object> map);
	public Integer selectRowCount(Map<String,Object> map);
	public Integer selectRowCount2(Map<String,Object> map);
	public ItemVO selectItem(Long item_num);
	public int getItem(Long item_num);
}
