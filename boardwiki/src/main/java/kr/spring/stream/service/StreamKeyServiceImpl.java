package kr.spring.stream.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.spring.stream.dao.StreamKeyMapper;
import kr.spring.stream.vo.StreamKeyVO;

@Service
public class StreamKeyServiceImpl implements StreamKeyService {

    @Autowired
    private StreamKeyMapper streamKeyMapper;

    @Override
    public StreamKeyVO findByStreamKey(String str_key) {
        return streamKeyMapper.findByStreamKey(str_key);
    }

	@Override
	public StreamKeyVO findByUsername(Long mem_num) {
		return streamKeyMapper.findByUsername(mem_num);
	}

	@Override
	public StreamKeyVO selectstream(Long str_key) {
		return streamKeyMapper.selectstream(str_key);
	}

	@Override
	public Integer streamingNumber(long mem_num) {
		return streamKeyMapper.streamingNumber(mem_num);
	}

	@Override
	public Integer streamingNum(Long str_num) {
		return streamKeyMapper.streamingNum(str_num);
	}
}