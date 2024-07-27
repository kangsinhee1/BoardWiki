package kr.spring.stream.service;

import java.util.List;

import kr.spring.stream.vo.BroadcastVO;

public interface BroadcastService {
    List<BroadcastVO> getAllBroadcasts();
    BroadcastVO findByUsername(Long str_num);
    void startStream(BroadcastVO broadcast);
    void updateBroadcast(BroadcastVO broadcast);
    BroadcastVO findByMemNum(Long mem_num);

}