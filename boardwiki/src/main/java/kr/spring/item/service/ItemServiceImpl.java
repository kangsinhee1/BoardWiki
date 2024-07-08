package kr.spring.item.service;

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
	public ItemVO selectItem_num(Long item_num) {
		return itemMapper.selectItem(item_num);
	}
	
}
