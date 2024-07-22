package kr.spring.stream.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.spring.stream.dao.StreamCreatingMapper;
import kr.spring.stream.vo.StreamCreatingVO;

@Service
public class StreamCreatingServiceImpl implements StreamCreatingService{

	@Autowired
	StreamCreatingMapper streamCreatingMapper;

	@Override
	public void inrsertCreating(long str_num) {
		streamCreatingMapper.inrsertCreating(str_num);
	}

	@Override
	public StreamCreatingVO selectCreating(long str_num) {
		return streamCreatingMapper.selectCreating(str_num);
	}

	@Override
	public List<StreamCreatingVO> selectCreatingList(Map<String, Object> map) {
		return streamCreatingMapper.selectCreatingList(map);
	}

	@Override
	public List<StreamCreatingVO> selectCreatingListuser(Map<String, Object> map) {
		return streamCreatingMapper.selectCreatingListuser(map);
	}

	@Override
	public Integer countCreating(Map<String, Object> map) {
		return streamCreatingMapper.countCreating(map);
	}

	@Override
	public Integer countCreatinguser(Map<String, Object> map) {
		return streamCreatingMapper.countCreatinguser(map);
	}

	@Override
	public void insertMessage(StreamCreatingVO streamvo) {
		streamCreatingMapper.insertMessage(streamvo);
	}

	@Override
	public List<StreamCreatingVO> selectMessageLive(StreamCreatingVO streamvo) {
		return streamCreatingMapper.selectMessageLive(streamvo);
	}

	@Override
	public List<StreamCreatingVO> selectMeassageuser(StreamCreatingVO streamvo) {
		return streamCreatingMapper.selectMeassageuser(streamvo);
	}

	@Override
	public Integer countMeassageLive(Map<String, Object> map) {
		return streamCreatingMapper.countMeassageLive(map);
	}

	@Override
	public Integer countMeassageuser(Map<String, Object> map) {
		return streamCreatingMapper.countMeassageuser(map);
	}

}