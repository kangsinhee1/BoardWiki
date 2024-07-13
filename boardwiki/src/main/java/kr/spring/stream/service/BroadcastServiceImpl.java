package kr.spring.stream.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.spring.stream.dao.BroadcastMapper;
import kr.spring.stream.vo.BroadcastVO;

import java.util.List;

@Service
public class BroadcastServiceImpl implements BroadcastService {

    @Autowired
    private BroadcastMapper broadcastMapper;

    @Override
    public List<BroadcastVO> getAllBroadcasts() {
        return broadcastMapper.findAll();
    }

    @Override
    public BroadcastVO getBroadcastByUsername(Long str_num) {
        return broadcastMapper.findByUsername(str_num);
    }
}