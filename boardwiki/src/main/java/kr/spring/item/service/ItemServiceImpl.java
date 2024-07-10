package kr.spring.item.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.item.dao.ItemMapper;
import kr.spring.item.vo.ItemVO;

@Service
@Transactional
public class ItemServiceImpl implements ItemService{

	@Autowired
	ItemMapper itemMapper;

	@Override
	public List<ItemVO> selectList(Map<String, Object> map) {
		return itemMapper.selectList(map);
	}

	@Override
	public Integer selectRowCount(Map<String, Object> map) {
		return itemMapper.selectRowCount(map);
	}

	@Override
	public ItemVO selectItem(Long item_num) {
		return itemMapper.selectItem(item_num);
	}

	@Override
	public List<ItemVO> selectList2(Map<String, Object> map) {
		return itemMapper.selectList2(map);
	}

	@Override
	public List<ItemVO> selectListByKeyword(Map<String, Object> map) {
		return itemMapper.selectListByKeyword(map);
	}

}
