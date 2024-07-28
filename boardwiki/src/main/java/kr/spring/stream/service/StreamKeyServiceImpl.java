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
    public StreamKeyVO findByStreamKey(Long mem_num) {
        return streamKeyMapper.findByStreamKey(mem_num);
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
		if(streamKeyMapper.streamingNumber(mem_num) == null) {
			return 0;
		}else {
			return streamKeyMapper.streamingNumber(mem_num);
		}

	}

	@Override
	public Integer streamingNum(Long str_num) {
		return streamKeyMapper.streamingNum(str_num);
	}

	@Override
	public void save(StreamKeyVO str_Key) {
		streamKeyMapper.save(str_Key);
		
	}
}