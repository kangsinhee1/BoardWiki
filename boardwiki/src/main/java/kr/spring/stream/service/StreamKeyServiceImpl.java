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
}